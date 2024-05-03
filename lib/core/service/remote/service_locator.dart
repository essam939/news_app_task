import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:news/core/service/simple_secure_user_data.dart';
import 'package:news/core/service/simple_user_data.dart';
import 'package:news/features/news/data/data_sources/news_remote_data_source.dart';
import 'package:news/features/news/data/repositories/news_repository.dart';
import 'package:news/features/news/domain/repositories/base_news_repository.dart';
import 'package:news/features/news/domain/use_cases/get_news_usecase.dart';
import 'package:news/features/news/presentation/controller/news/news_cubit.dart';

import 'api_consumer.dart';
import 'dio_consumer.dart';

mixin ServiceLocator {
  static final instance = GetIt.instance;
  static void init() {
    // bloc
    instance.registerLazySingleton(() => NewsCubit(getNewsUseCase: instance()));

    // use cases
    instance.registerLazySingleton(() => GetNewsUseCase(instance()));

// repository
    instance.registerLazySingleton<BaseNewsRepository>(
      () => NewsRepository(newsDataSource: instance()),
    );
    // data source
    instance.registerLazySingleton<BaseNewsDataSource>(
          () => NewsDataSource(
        instance(),
      ),
    );

    instance.registerLazySingleton(() => const SimpleLocalData());
    instance.registerLazySingleton(() => SimpleSecureData(instance()));
    instance.registerLazySingleton<DioConsumer>(() => ApiConsumer());
    instance.registerLazySingleton(() => const FlutterSecureStorage());
  }
}
