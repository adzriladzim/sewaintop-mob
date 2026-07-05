import 'package:equatable/equatable.dart';
import 'package:sewaintop_mob/models/laptop_model.dart';

abstract class LaptopState extends Equatable {
  const LaptopState();

  @override
  List<Object?> get props => [];
}

class LaptopInitial extends LaptopState {}

class LaptopLoading extends LaptopState {}

class LaptopLoaded extends LaptopState {
  final List<Laptop> laptops;
  final bool isFromCache;

  const LaptopLoaded({required this.laptops, required this.isFromCache});

  @override
  List<Object?> get props => [laptops, isFromCache];
}

class LaptopError extends LaptopState {
  final String message;

  const LaptopError(this.message);

  @override
  List<Object?> get props => [message];
}
