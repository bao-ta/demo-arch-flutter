import 'package:clean_architecture_demo/features/number_trivia/domain/entities/number_trival.dart';

class NumberTriviaModel extends NumberTriviaEntity {
  final String text;
  final int number;

  const NumberTriviaModel({required this.text, required this.number}) : super(text, number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(text: json['text'], number: (json['number'] as num).toInt());
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'number': number};
  }
}
