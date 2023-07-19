import 'package:clean_architecture_demo/core/error/failures.dart';
import 'package:clean_architecture_demo/core/network/network_info.dart';
import 'package:clean_architecture_demo/features/number_trivia/data/datasources/number_trivial_local_data_source.dart';
import 'package:clean_architecture_demo/features/number_trivia/data/datasources/number_trivial_remote_data_source.dart';
import 'package:clean_architecture_demo/features/number_trivia/data/models/number_trivial_model.dart';
import 'package:clean_architecture_demo/features/number_trivia/domain/entities/number_trival.dart';
import 'package:clean_architecture_demo/features/number_trivia/domain/repositories/number_trival_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NetworkInfo networkInfo;
  final NumberTriviaLocalDataSource localDataSource;
  final NumberTriviaRemoteDataSource remoteDataSource;

  NumberTriviaRepositoryImpl(this.networkInfo, this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivial(int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivial(number);
    });
  }

  @override
  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivial() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivial();
    });
  }

  Future<Either<Failure, NumberTriviaEntity>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on SeverException {
        return Left(SeverFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}