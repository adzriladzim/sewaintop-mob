import 'package:equatable/equatable.dart';
import 'package:sewaintop_mob/models/booking_model.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyBookings extends BookingEvent {
  final int userId;

  const LoadMyBookings({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class CreateBooking extends BookingEvent {
  final Booking booking;

  const CreateBooking({required this.booking});

  @override
  List<Object?> get props => [booking];
}

class CancelBookingEvent extends BookingEvent {
  final int bookingId;
  final int userId; // to reload after cancel

  const CancelBookingEvent({required this.bookingId, required this.userId});

  @override
  List<Object?> get props => [bookingId, userId];
}
