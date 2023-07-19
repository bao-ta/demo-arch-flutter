import 'package:clean_architecture_demo/core/error/failures.dart';
import 'package:clean_architecture_demo/core/usecases/usecases.dart';
import 'package:clean_architecture_demo/features/number_trivia/domain/entities/number_trival.dart';
import 'package:clean_architecture_demo/features/number_trivia/domain/use_cases/get_concrete_number.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/number_trival_repository.dart';

class GetRandomNumberUseCase implements UseCase<NumberTriviaEntity, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberUseCase(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(NoParams noParams) async {
    return await repository.getRandomNumberTrivial();
  }

}

