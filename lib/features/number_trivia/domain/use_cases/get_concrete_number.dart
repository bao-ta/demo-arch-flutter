import 'package:clean_architecture_demo/core/error/failures.dart';
import 'package:clean_architecture_demo/core/usecases/usecases.dart';
import 'package:clean_architecture_demo/features/number_trivia/domain/entities/number_trival.dart';
import 'package:clean_architecture_demo/features/number_trivia/domain/repositories/number_trival_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetConcreteNumberUseCase implements UseCase<NumberTriviaEntity, int> {
  final NumberTriviaRepository repository;
  GetConcreteNumberUseCase(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(int number) async {
    return await repository.getConcreteNumberTrivial(number);

  }
}

class Params extends Equatable {
   final int number;

  const Params({required this.number});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}