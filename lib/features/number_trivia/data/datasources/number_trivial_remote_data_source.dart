import 'dart:convert';

import 'package:clean_architecture_demo/core/error/exception.dart';
import 'package:clean_architecture_demo/features/number_trivia/data/models/number_trivial_model.dart';
import 'package:http/http.dart' as http;
import '../../domain/entities/number_trival.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Call https://numbersapi.com/{number}
  /// Throws a [SeverException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivial(int number);

  /// Call https://numbersapi.com/random

  Future<NumberTriviaModel> getRandomNumberTrivial();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl(this.client);

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivial(int number) => _getTriviaFromUri('https://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivial() => _getTriviaFromUri('https://numbersapi.com/random');

  Future<NumberTriviaModel> _getTriviaFromUri(String url) async {
    final response = await client.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(jsonDecode(response.body));
    } else {
      throw SeverException();
    }
  }
}
