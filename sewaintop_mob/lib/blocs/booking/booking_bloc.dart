import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewaintop_mob/blocs/booking/booking_event.dart';
import 'package:sewaintop_mob/blocs/booking/booking_state.dart';
import 'package:sewaintop_mob/repositories/booking_repository.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;

  BookingBloc({required this.bookingRepository}) : super(BookingInitial()) {
    on<LoadMyBookings>(_onLoadMyBookings);
    on<CreateBooking>(_onCreateBooking);
    on<CancelBookingEvent>(_onCancelBooking);
  }

  Future<void> _onLoadMyBookings(LoadMyBookings event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final result = await bookingRepository.fetchBookings(event.userId);
      emit(BookingLoaded(bookings: result.bookings, isFromCache: result.isFromCache));
    } catch (e) {
      emit(BookingError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onCreateBooking(CreateBooking event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final created = await bookingRepository.createBooking(event.booking);
      emit(BookingCreatedSuccess(created));
    } catch (e) {
      emit(BookingError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onCancelBooking(CancelBookingEvent event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      await bookingRepository.cancelBooking(event.bookingId);
      // Reload bookings list directly
      final result = await bookingRepository.fetchBookings(event.userId);
      emit(BookingLoaded(bookings: result.bookings, isFromCache: result.isFromCache));
    } catch (e) {
      emit(BookingError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
