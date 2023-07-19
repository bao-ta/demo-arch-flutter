import 'package:equatable/equatable.dart';
class NumberTriviaEntity extends Equatable {
  final String text;
  final int number;

   const NumberTriviaEntity(this.text,this.number);

  @override
  List<Object?> get props => [text, number];
}
