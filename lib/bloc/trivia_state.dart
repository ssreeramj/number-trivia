part of 'trivia_bloc.dart';

abstract class TriviaState extends Equatable {
  const TriviaState();
}

class TriviaInitial extends TriviaState {
  @override
  List<Object> get props => [];
}

class TriviaLoading extends TriviaState {
  @override
  List<Object> get props => [];
}

class TriviaLoaded extends TriviaState {
  
  final String trivia;

  TriviaLoaded(this.trivia);
  
  @override
  List<Object> get props => [trivia];
}

class TriviaError extends TriviaState {
  
  final String errorMessage;

  TriviaError(this.errorMessage);
  
  @override
  List<Object> get props => [errorMessage];
}