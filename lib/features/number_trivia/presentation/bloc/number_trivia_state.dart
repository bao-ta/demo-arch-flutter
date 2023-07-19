part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}

class EmptyNumber extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class Loading extends NumberTriviaState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class Loaded extends NumberTriviaState {
  final NumberTriviaEntity trivia;

  const Loaded(this.trivia);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class Error extends NumberTriviaState {
  final String message;

  const Error(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
