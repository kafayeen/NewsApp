import 'package:get_it/get_it.dart';
import 'package:newsapp/data/data_source/data_source.dart';
import 'package:newsapp/data/repository/repo.dart';
import 'package:newsapp/domain/repository/base_repository.dart';
import 'package:newsapp/domain/usecases/business_usecases.dart';
import 'package:newsapp/domain/usecases/sciences_usecases.dart';
import 'package:newsapp/domain/usecases/search_usecases.dart';
import 'package:newsapp/domain/usecases/sports_usecases.dart';
import 'package:newsapp/presentation/controller/new_cubit.dart';

final sl = GetIt.instance;

class GetItService {
  void init() {
    sl.registerFactory<Appcubit>(() =>Appcubit(sl(),sl(),sl(),sl()));
    sl.registerLazySingleton<BaseRepo>(() =>Repo(baseDataSource: sl()));

    sl.registerLazySingleton<BaseDataSource>(() => DataSource());

    
    sl.registerLazySingleton<BusinessUsecases>(() => BusinessUsecases(baseRepo: sl()));

    sl.registerLazySingleton<SciencesUsecases>(() => SciencesUsecases(baseRepo: sl()));
    sl.registerLazySingleton<SearchUsecases>(() => SearchUsecases(baseRepo: sl()));

    sl.registerLazySingleton<SportsUsecases>(() => SportsUsecases(baseRepo: sl()));
  }
}
