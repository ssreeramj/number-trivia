part of 'trivia_bloc.dart';

abstract class TriviaEvent extends Equatable {
  const TriviaEvent();
}

class NumberTrivia extends TriviaEvent {
  final int number;

  NumberTrivia(this.number);
 
  @override
  List<Object> get props => [number];
}

class RandomNumberTrivia extends TriviaEvent {
  
  @override
  List<Object> get props => null;
}

class EnteredFloat extends TriviaEvent {
  
  @override
  List<Object> get props => null;
}