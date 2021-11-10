import 'package:bufi_remake/core/network/network_info.dart';
import 'package:bufi_remake/screens/features/splash/data/datasources/splash_local_datasource.dart';
import 'package:bufi_remake/screens/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:bufi_remake/screens/features/splash/domain/repositories/splash_repository.dart';
import 'package:bufi_remake/screens/features/splash/domain/usecases/fetch_token.dart';
import 'package:bufi_remake/screens/features/login/data/datasources/login_local_datasource.dart';
import 'package:bufi_remake/screens/features/login/data/datasources/login_remote_datasource.dart';
import 'package:bufi_remake/screens/features/login/data/repositories/login_repository_impl.dart';
import 'package:bufi_remake/screens/features/login/domain/repositories/login_repository.dart';
import 'package:bufi_remake/screens/features/login/domain/usecases/login_user.dart';
import 'package:bufi_remake/screens/features/splash/presentation/bloc/splas_bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'screens/features/login/presentation/blocs/user_login/user_login_bloc.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

//Dependency injection
Future<void> init() async {
  //Blocs

  sl.registerFactory(
    () => UserLoginBloc(
      loginUser: sl(),
    ),
  );

  sl.registerFactory(
    () => SplashBloc(
      fetchToken: sl(),
    )..add(CheckLoginStatusEvent()),
  );

  //Use cases
  sl.registerLazySingleton(() => LoginUser(repository: sl()));
  sl.registerLazySingleton(() => FetchToken(repository: sl()));

  //Repositories
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(
      splashLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<LoginLocalDataSource>(
    () => LoginLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<SplashLocalDataSource>(
    () => SplashLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  //External
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton(() => http.Client());
}
