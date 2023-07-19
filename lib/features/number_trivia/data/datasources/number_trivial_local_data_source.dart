import 'package:clean_architecture_demo/core/error/exception.dart';
import 'package:clean_architecture_demo/features/number_trivia/data/models/number_trivial_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/number_trival.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaEntity> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) async {
    sharedPreferences.setString('CACHE_NUMBER_TRIVIA', triviaToCache.toJson() as String);
  }

  @override
  Future<NumberTriviaEntity> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString('CACHE_NUMBER_TRIVIA');
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(jsonString as Map<String, dynamic>));
    } else {
      throw CacheException();
    }
  }
}
