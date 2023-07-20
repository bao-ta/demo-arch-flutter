import 'package:clean_architecture_demo/core/network/network_info.dart';
import 'package:clean_architecture_demo/features/number_trivia/data/datasources/number_trivial_local_data_source.dart';
import 'package:clean_architecture_demo/features/number_trivia/data/datasources/number_trivial_remote_data_source.dart';
import 'package:clean_architecture_demo/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_architecture_demo/features/number_trivia/domain/repositories/number_trival_repository.dart';
import 'package:clean_architecture_demo/features/number_trivia/domain/use_cases/get_concrete_number.dart';
import 'package:clean_architecture_demo/features/number_trivia/domain/use_cases/get_random_number.dart';
import 'package:clean_architecture_demo/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:clean_architecture_demo/utils/input_converter.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

final sl = GetIt.instance;

 init() async {
  ///   Bloc
  sl.registerFactory(
      () => NumberTriviaBloc(getConcreteNumberUseCase: sl(), getRandomNumberUseCase: sl(), inputConverter: sl()));

  /// Usescase
  sl.registerLazySingleton(() => GetConcreteNumberUseCase(sl()));
  sl.registerLazySingleton(() => GetRandomNumberUseCase(sl()));

  ///   Repositories
  sl.registerLazySingleton<NumberTriviaRepository>(() => NumberTriviaRepositoryImpl(sl(), sl(), sl()));

  ///   Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///  Data
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(() => NumberTriviaRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(() => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingletonAsync(() async => await SharedPreferences.getInstance());

  /// External
  sl.registerLazySingleton(() => http.Client);
  sl.registerLazySingleton(() => Connectivity());
}
