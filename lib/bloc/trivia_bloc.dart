import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:numbers_api/models/data_repository.dart';

part 'trivia_event.dart';
part 'trivia_state.dart';

class TriviaBloc extends Bloc<TriviaEvent, TriviaState> {
  final TriviaRepository repository;

  TriviaBloc(this.repository);

  @override
  TriviaState get initialState => TriviaInitial();

  @override
  Stream<TriviaState> mapEventToState(
    TriviaEvent event,
  ) async* {
    yield TriviaLoading();

    if (event is NumberTrivia) {
      try {
        final trivia = await repository.getNumberTrivia(event.number);
        yield TriviaLoaded(trivia);
      } on NetworkError {
        yield TriviaError('Could not load trivia...connect to internet.');
      }
    } else if (event is RandomNumberTrivia) {
      try {
        final trivia = await repository.getRandomNumberTrivia();
        yield TriviaLoaded(trivia);
      } on NetworkError {
        yield TriviaError('Could not load trivia...connect to internet.');
      }
    } else if (event is EnteredFloat) {
      yield TriviaLoaded('Please enter an Integer!!');
    }
  }
}
