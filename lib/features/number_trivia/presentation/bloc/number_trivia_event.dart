part of 'number_trivia_bloc.dart';
@immutable
abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent([List pros = const<dynamic>[]]);
}

class GetTriviaConcreteNumber extends NumberTriviaEvent {
  final String numberString;
  int get number =>int.parse(numberString);
  const GetTriviaConcreteNumber(this.numberString);

  @override
  List<Object?> get props => [];
}
class GetTriviaRandomNumber extends NumberTriviaEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}