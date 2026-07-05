import 'package:equatable/equatable.dart';

abstract class LaptopEvent extends Equatable {
  const LaptopEvent();

  @override
  List<Object?> get props => [];
}

class LoadLaptops extends LaptopEvent {
  final bool forceRefresh;

  const LoadLaptops({this.forceRefresh = false});

  @override
  List<Object?> get props => [forceRefresh];
}
