part of 'expenses_screen_bloc.dart';

abstract class ExpensesScreenEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchExpenses extends ExpensesScreenEvent {}
