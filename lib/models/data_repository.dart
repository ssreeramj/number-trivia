import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

abstract class DataRepository extends Equatable {
  Future<String> getNumberTrivia(int number);
  Future<String> getRandomNumberTrivia();
}

class NetworkError extends Error {}


class TriviaRepository implements DataRepository {
  @override
  Future<String> getNumberTrivia(int number) async {
    var response = await http.get("http://numbersapi.com/$number");

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw NetworkError();
    }
  }

  @override
  Future<String> getRandomNumberTrivia() async {
    var response = await http.get("http://numbersapi.com/random/trivia");
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw NetworkError();
    }
  
  }

  @override
  List<Object> get props => null;

  @override
  bool get stringify => null;
}
