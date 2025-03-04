part of 'expenses_screen_bloc.dart';

sealed class ExpensesScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExpensesScreenInitial extends ExpensesScreenState {}

class ExpensesLoading extends ExpensesScreenState {}

class ExpensesSuccess extends ExpensesScreenState {
  final ExpensesModel expensesModel;

  ExpensesSuccess(this.expensesModel);
  @override
  List<Object> get props => [expensesModel];
}

class ExpensesFailure extends ExpensesScreenState {
  final String message;

  ExpensesFailure(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [message];
}
