import 'package:dartz/dartz.dart';

import '../core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInt(String string) {
    try {
      final integer = int.parse(string);
      if (integer < 0) throw const FormatException();
      return Right(int.parse(string));
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}
