import 'package:bloc/bloc.dart';
import 'package:egg_factory/presentations/model_classes/expenses_model.dart';
import 'package:egg_factory/service/api_services.dart';
import 'package:equatable/equatable.dart';

part 'expenses_screen_event.dart';
part 'expenses_screen_state.dart';

class ExpensesScreenBloc
    extends Bloc<ExpensesScreenEvent, ExpensesScreenState> {
  final ApiService apiService;
  ExpensesScreenBloc(this.apiService) : super(ExpensesScreenInitial()) {
    on<ExpensesScreenEvent>(_onExpensesRequest);
  }

  Future<void> _onExpensesRequest(event, emit) async {
    emit(ExpensesLoading());
    try {
      final response = await apiService.getExpenses();
      if (response.statusCode == 200) {
        final dataResponse = ExpensesModel.fromJson(response.data);
        emit(ExpensesSuccess(dataResponse));
      } else {
        emit(ExpensesFailure(response.statusMessage.toString()));
      }
    } catch (e) {
      emit(ExpensesFailure('Failed :${e.toString()}'));
    }
  }
}
