import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewaintop_mob/blocs/laptop/laptop_event.dart';
import 'package:sewaintop_mob/blocs/laptop/laptop_state.dart';
import 'package:sewaintop_mob/repositories/laptop_repository.dart';

class LaptopBloc extends Bloc<LaptopEvent, LaptopState> {
  final LaptopRepository laptopRepository;

  LaptopBloc({required this.laptopRepository}) : super(LaptopInitial()) {
    on<LoadLaptops>(_onLoadLaptops);
  }

  Future<void> _onLoadLaptops(LoadLaptops event, Emitter<LaptopState> emit) async {
    // Hanya tampilkan loading jika bukan refresh (agar UI tidak kedip jika sudah ada data)
    if (state is! LaptopLoaded || event.forceRefresh) {
      emit(LaptopLoading());
    }
    try {
      final result = await laptopRepository.fetchLaptops();
      emit(LaptopLoaded(laptops: result.laptops, isFromCache: result.isFromCache));
    } catch (e) {
      emit(LaptopError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
