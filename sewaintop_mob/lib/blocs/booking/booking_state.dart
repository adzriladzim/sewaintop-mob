import 'package:equatable/equatable.dart';
import 'package:sewaintop_mob/models/booking_model.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<Booking> bookings;
  final bool isFromCache;

  const BookingLoaded({required this.bookings, required this.isFromCache});

  @override
  List<Object?> get props => [bookings, isFromCache];
}

class BookingCreatedSuccess extends BookingState {
  final Booking booking;

  const BookingCreatedSuccess(this.booking);

  @override
  List<Object?> get props => [booking];
}

class BookingError extends BookingState {
  final String message;

  const BookingError(this.message);

  @override
  List<Object?> get props => [message];
}
