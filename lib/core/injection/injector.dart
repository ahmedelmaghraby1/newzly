import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:newzly/core/localization/cubit/localization_cubit.dart';
import 'package:newzly/core/routes/app_router.dart';
import 'package:newzly/core/theme/cubit/theming_cubit.dart';
import 'package:newzly/core/utils/api_services.dart';
import 'package:newzly/core/utils/dio_helper.dart';
import 'package:newzly/features/home/data/data_sources/home_local_data_source.dart';
import 'package:newzly/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:newzly/features/home/data/repositories/home_repository_imp.dart';
import 'package:newzly/features/home/domain/repositories/home_repo.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_business_news_use_case.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_entertainment_news_use_case.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_general_news_use_case.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_health_news_use_case.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_sports_news_use_case.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_technology_news_use_case.dart';
import 'package:newzly/features/home/presentation/controller/business_news_cubit/business_news_cubit.dart';
import 'package:newzly/features/home/presentation/controller/entertainment_news_cubit/entertainment_news_cubit.dart';
import 'package:newzly/features/home/presentation/controller/general_news_cubit/general_news_cubit.dart';
import 'package:newzly/features/home/presentation/controller/health_news_cubit/health_news_cubit.dart';
import 'package:newzly/features/home/presentation/controller/sports_news_cubit/sports_news_cubit.dart';
import 'package:newzly/features/home/presentation/controller/technology_news_cubit/technology_news_cubit.dart';

GetIt getIt = GetIt.instance;
String baseUrl = dotenv.env['base_url'] ?? 'https://newsapi.org/v2/';
String apiKey = dotenv.env['api_key'] ?? 'b928c8f387064fc98c047920c08c874e';
GoRouter goRouter = AppRouter.createRouter();
initGetIt() {
  // Dio
  getIt.registerLazySingleton<ApiServices<Map<String, dynamic>>>(
    () => DioHelper(),
  );

  //Remote data sources
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImplementation(dioHelper: getIt()),
  );

  //Local data sources
  getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImplementation(),
  );
  // Repositories
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImplementation(
      homeRemoteDataSource: getIt(),
      homeLocalDataSource: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton<FetchGeneralNewsUseCase>(
    () => FetchGeneralNewsUseCase(getIt()),
  );
  getIt.registerLazySingleton<FetchHealthNewsUseCase>(
    () => FetchHealthNewsUseCase(getIt()),
  );
  getIt.registerLazySingleton<FetchSportsNewsUseCase>(
    () => FetchSportsNewsUseCase(getIt()),
  );

  getIt.registerLazySingleton<FetchTechnologyNewsUseCase>(
    () => FetchTechnologyNewsUseCase(getIt()),
  );
  getIt.registerLazySingleton<FetchEntertainmentNewsUseCase>(
    () => FetchEntertainmentNewsUseCase(getIt()),
  );
  getIt.registerLazySingleton<FetchBusinessNewsUseCase>(
    () => FetchBusinessNewsUseCase(getIt()),
  );

  //Cubits
  getIt.registerFactory<LocalizationCubit>(() => LocalizationCubit());
  getIt.registerFactory<ThemingCubit>(() => ThemingCubit());
  getIt.registerFactory<GeneralNewsCubit>(
    () => GeneralNewsCubit(fetchGeneralNewsUseCase: getIt()),
  );
  getIt.registerFactory<HealthNewsCubit>(
    () => HealthNewsCubit(fetchHealthNewsUseCase: getIt()),
  );
  getIt.registerFactory<SportsNewsCubit>(
    () => SportsNewsCubit(fetchSportsNewsUseCase: getIt()),
  );
  getIt.registerFactory<TechnologyNewsCubit>(
    () => TechnologyNewsCubit(fetchTechnologyNewsUseCase: getIt()),
  );
  getIt.registerFactory<EntertainmentNewsCubit>(
    () => EntertainmentNewsCubit(fetchEntertainmentNewsUseCase: getIt()),
  );

  getIt.registerFactory<BusinessNewsCubit>(
    () => BusinessNewsCubit(fetchBusinessNewsUseCase: getIt()),
  );
}
