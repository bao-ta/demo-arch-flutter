import 'package:clean_architecture_demo/core/usecases/usecases.dart';
import 'package:clean_architecture_demo/features/number_trivia/domain/entities/number_trival.dart';
import 'package:clean_architecture_demo/features/number_trivia/domain/use_cases/get_concrete_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../utils/input_converter.dart';
import '../../domain/use_cases/get_random_number.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberUseCase getConcreteNumberUseCase;
  final GetRandomNumberUseCase getRandomNumberUseCase;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {required this.getConcreteNumberUseCase, required this.getRandomNumberUseCase, required this.inputConverter})
      : super(EmptyNumber()) {
    on<GetTriviaConcreteNumber>((event, emit) {
      final input = inputConverter.stringToUnsignedInt(event.numberString);
      input.fold((l) => emit(const Error('INVALID_INPUT_FAILURE_MESSAGE')), (r) async {
        emit(Loading());
        final failureOrTrivia = await getConcreteNumberUseCase(Params(number: r) as int);
        emit(failureOrTrivia.fold((l) => const Error('SERVER_FAILURE_MESSAGE'), (r) => Loaded(r)));
      });
    });
    on<GetTriviaRandomNumber>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await getRandomNumberUseCase(NoParams());
      emit(failureOrTrivia.fold((l) => const Error('SERVER_FAILURE_MESSAGE'), (r) => Loaded(r)));
    });
  }
}
