import 'package:bufi_remake/core/network/network_info.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/data/datasources/Category/productsCategory_local_datasource.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/data/datasources/Category/productsCategory_remote_datasource.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/data/datasources/ItemSubcategory/productsItemSubCategory_local_datasource.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/data/datasources/Subcategory/productsSubCategory_local_datasource.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/data/repositories/productsCategory_repository_impl.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/domain/repositories/productsCategory_repository.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/domain/usecases/get_productitemSubCategory.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/domain/usecases/get_productsCategory.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/domain/usecases/get_productsSubcategory.dart';
import 'package:bufi_remake/screens/features/Explorar/features/productsCategory/presentation/bloc/Categories/categories_bloc.dart';
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
    () => CategoriesBloc(
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
  sl.registerLazySingleton(() => GetProductsCategory(productCategoryRepository: sl()));
  sl.registerLazySingleton(() => GetProductsSubCategory(productCategoryRepository: sl()));
  sl.registerLazySingleton(() => GetProductsItemSubCategory(productCategoryRepository: sl()));

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
  sl.registerLazySingleton<ProductCategoryRepository>(
    () => ProductCategoryRepositoryImpl(
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
  sl.registerLazySingleton<ProductCategoryLocalDataSource>(
    () => ProductCategoryLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<ProductSubCategoryLocalDatasource>(
    () => ProductSubCategoryLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<ProductItemSubCategoryLocalDataSource>(
    () => ProductItemSubCategoryLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<ProductsCategoryRemoteDataSource>(
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
