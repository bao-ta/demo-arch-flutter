import 'package:clean_architecture_demo/features/number_trivia/domain/entities/number_trival.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivial(int number);

  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivial();
}
