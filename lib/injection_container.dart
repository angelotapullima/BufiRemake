import 'package:bufi_remake/core/network/network_info.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/datasources/Category/explorar_local_datasource.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/datasources/Category/explorar_remote_datasource.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/datasources/ItemSubcategory/productsItemSubCategory_local_datasource.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/datasources/Subcategory/productsSubCategory_local_datasource.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/data/repositories/explorar_repository_impl.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/repositories/explorar_repository.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/usecases/get_itemSubCategory.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/usecases/get_category.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/domain/usecases/get_subcategory.dart';
import 'package:bufi_remake/features/Explorar/Productos/productsCategory/presentation/bloc/Categories/explorar_bloc.dart';
import 'package:bufi_remake/features/splash/data/datasources/splash_local_datasource.dart';
import 'package:bufi_remake/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:bufi_remake/features/splash/domain/repositories/splash_repository.dart';
import 'package:bufi_remake/features/splash/domain/usecases/fetch_token.dart';
import 'package:bufi_remake/features/login/data/datasources/login_local_datasource.dart';
import 'package:bufi_remake/features/login/data/datasources/login_remote_datasource.dart';
import 'package:bufi_remake/features/login/data/repositories/login_repository_impl.dart';
import 'package:bufi_remake/features/login/domain/repositories/login_repository.dart';
import 'package:bufi_remake/features/login/domain/usecases/login_user.dart';
import 'package:bufi_remake/features/splash/presentation/bloc/splas_bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'features/login/presentation/blocs/user_login/user_login_bloc.dart';

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
    () => ExplorarBloc(
      getProductsCategory: sl(),
      getProductsSubCategory: sl(),
      getProductsItemSubCategory: sl(),
    ),
  );

  //###################################
  //Use cases

  //login
  sl.registerLazySingleton(() => LoginUser(repository: sl()));

  //Splash
  sl.registerLazySingleton(() => FetchToken(repository: sl()));

  //ProductsCategory
  sl.registerLazySingleton(() => GetCategory(productCategoryRepository: sl()));
  sl.registerLazySingleton(() => GetSubCategory(productCategoryRepository: sl()));
  sl.registerLazySingleton(() => GetItemSubCategory(productCategoryRepository: sl()));

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
  sl.registerLazySingleton<ExplorarRepository>(
    () => ExplorarRepositoryImpl(
      productCategoryLocalDataSource: sl(),
      productsCategoryRemoteDataSource: sl(),
      productSubCategoryLocalDataSource: sl(),
      productItemSubCategoryLocalDataSource: sl(),
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
    () => ProductCategoryLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<ProductSubCategoryLocalDatasource>(
    () => ProductSubCategoryLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<ProductItemSubCategoryLocalDataSource>(
    () => ProductItemSubCategoryLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<ExplorarRemoteDataSource>(
    () => ProductsCategoryRemoteDataSourceImpl(client: sl()),
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
