import 'package:clean_architecture_demo/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  ///   Bloc
  sl.registerFactory(
      () => NumberTriviaBloc(getConcreteNumberUseCase: sl(), getRandomNumberUseCase: sl(), inputConverter: sl()));

  ///   Features
  ///   Core

  ///  External
}
