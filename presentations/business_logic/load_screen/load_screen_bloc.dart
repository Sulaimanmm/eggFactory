import 'package:egg_factory/presentations/model_classes/load_screen_model.dart';
import 'package:egg_factory/service/api_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'load_screen_event.dart';
part 'load_screen_state.dart';

class LoadScreenBloc extends Bloc<LoadScreenEvent, LoadScreenState> {
  final ApiService apiService;
  LoadScreenBloc(this.apiService) : super(LoadScreenInitial()) {
    on<LoadScreenEvent>(_onLoadRequest);
  }

  Future<void> _onLoadRequest(event, emit) async {
    emit(LoadLoading());
    try {
      final response = await apiService.getLoad();
      if (response.statusCode == 200) {
        final dataResponse = LoadModel.fromJson(response.data);
        emit(LoadSuccess(dataResponse));
      } else {
        emit(LoadFailure(response.statusMessage ?? 'Loading error'));
      }
    } catch (error) {
      emit(LoadFailure('Loading Failed ${error.toString()}'));
    }
  }
}
