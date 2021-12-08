import 'package:bufi_remake/core/network/network_info.dart';
import 'package:bufi_remake/features/data/datasources/Explorer/Category/explorer_local_datasource.dart';
import 'package:bufi_remake/features/data/datasources/Explorer/Category/explorer_remote_datasource.dart';
import 'package:bufi_remake/features/data/datasources/Explorer/ItemSubcategory/itemSubCategory_local_datasource.dart';
import 'package:bufi_remake/features/data/datasources/Explorer/Subcategory/subCategory_local_datasource.dart';
import 'package:bufi_remake/features/data/datasources/Inicio/Publicidad/publicidad_local_datasource.dart';
import 'package:bufi_remake/features/data/datasources/Inicio/Publicidad/publicidad_remote_datasource.dart';
import 'package:bufi_remake/features/data/datasources/Splash/splash_local_datasource.dart';
import 'package:bufi_remake/features/data/datasources/login/login_local_datasource.dart';
import 'package:bufi_remake/features/data/datasources/login/login_remote_datasource.dart';
import 'package:bufi_remake/features/data/repositories/Explorer/explorer_repository_impl.dart';
import 'package:bufi_remake/features/data/repositories/Inicio/inicio_repository_impl.dart';
import 'package:bufi_remake/features/data/repositories/Splash/splash_repository_impl.dart';
import 'package:bufi_remake/features/data/repositories/login/login_repository_impl.dart';
import 'package:bufi_remake/features/domain/repositories/Explorer/explorer_repository.dart';
import 'package:bufi_remake/features/domain/repositories/Inicio/inicio_repository.dart';
import 'package:bufi_remake/features/domain/repositories/Splash/splash_repository.dart';
import 'package:bufi_remake/features/domain/repositories/login/login_repository.dart';
import 'package:bufi_remake/features/domain/usecases/Explorer/get_category.dart';
import 'package:bufi_remake/features/domain/usecases/Explorer/get_itemSubCategory.dart';
import 'package:bufi_remake/features/domain/usecases/Explorer/get_subcategory.dart';
import 'package:bufi_remake/features/domain/usecases/Inicio/get_publicidad.dart';
import 'package:bufi_remake/features/domain/usecases/Splash/fetch_token.dart';
import 'package:bufi_remake/features/domain/usecases/login/login_user.dart';
import 'package:bufi_remake/features/presentation/Explorer/bloc/Category/explorer_bloc.dart';
import 'package:bufi_remake/features/presentation/Inicio/blocs/publicidad/publicidad_bloc.dart';
import 'package:bufi_remake/features/presentation/Splash/bloc/splas_bloc/splash_bloc.dart';
import 'package:bufi_remake/features/presentation/login/blocs/user_login/user_login_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'features/domain/usecases/Explorer/get_category.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

//Dependency injection
Future<void> init() async {
  //################################################
  //Blocs

  //login
  sl.registerFactory(
    () => UserLoginBloc(
      loginUser: sl(),
    ),
  );

  //Splash
  sl.registerFactory(
    () => SplashBloc(
      fetchToken: sl(),
    )..add(CheckLoginStatusEvent()),
  );

  //Category
  sl.registerFactory(
    () => ExplorerBloc(
      getProductsCategory: sl(),
      getProductsSubCategory: sl(),
      getProductsItemSubCategory: sl(),
    ),
  );

  //Publicidad
  sl.registerFactory(
    () => PublicidadBloc(
      getPublicidad: sl(),
    ),
  );

  //###################################
  //Use cases

  //login
  sl.registerLazySingleton(() => LoginUser(repository: sl()));

  //Splash
  sl.registerLazySingleton(() => FetchToken(repository: sl()));

  //ProductsCategory
  sl.registerLazySingleton(() => GetCategory(explorerRepository: sl()));
  sl.registerLazySingleton(() => GetSubCategory(explorerRepository: sl()));
  sl.registerLazySingleton(() => GetItemSubCategory(explorerRepository: sl()));

  //Publicidad
  sl.registerLazySingleton(
    () => GetPublicidad(
      publicidadRepository: sl(),
    ),
  );

  //##################################
  //Repositories

  //login
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  //Splash
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(
      splashLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //ProductsCategory
  sl.registerLazySingleton<ExplorerRepository>(
    () => ExplorerRepositoryImpl(
      subCategoryLocalDatasource: sl(),
      explorarLocalDataSource: sl(),
      itemSubCategoryLocalDataSource: sl(),
      explorarRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Publicidad
  sl.registerLazySingleton<InicioRepository>(
    () => InicioRepositoryImpl(
      publicidadLocalDataSource: sl(),
      publicidadRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //###########################################
  //Data sources

  //login
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

  //Splash
  sl.registerLazySingleton<SplashLocalDataSource>(
    () => SplashLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

//ProductsCategory
  sl.registerLazySingleton<ExplorarLocalDataSource>(
    () => ExplorarLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<SubCategoryLocalDatasource>(
    () => SubCategoryLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<ItemSubCategoryLocalDataSource>(
    () => ItemSubCategoryLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<ExplorarRemoteDataSource>(
    () => ExplorarLocalDataSourceImplDataSourceImpl(client: sl()),
  );

//Publicidad

  sl.registerLazySingleton<PublicidadLocalDataSource>(
    () => PublicidadLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<PublicidadRemoteDataSource>(
    () => PublicidadRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  //########################################################################
  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  //########################################################################
  //External
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}
