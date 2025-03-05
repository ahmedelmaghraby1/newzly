import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/core/injection/service_locator.dart';
import 'package:newzly/core/utils/dio_helper.dart';
import 'package:newzly/features/home/data/data_sources/home_local_data_source.dart';
import 'package:newzly/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:newzly/features/home/data/repositories/home_repository_imp.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_Business_news_use_case.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_Entertainment_news_use_case.dart';
import 'package:newzly/features/home/presentation/UI/views/business_news_view/business_news_view.dart';
import 'package:newzly/features/home/presentation/UI/views/entertainment_news_view/entertainment_news_view.dart';
import 'package:newzly/features/home/presentation/UI/views/general_news_view/general_news_view.dart';
import 'package:newzly/features/home/presentation/UI/views/health_news_view/health_news_view.dart';
import 'package:newzly/features/home/presentation/UI/views/sports_news_view/sports_news_view.dart';
import 'package:newzly/features/home/presentation/UI/views/technology_news_view/technology_news_view.dart';
import 'package:newzly/features/home/presentation/manager/business_news_cubit/business_news_cubit.dart';
import 'package:newzly/features/home/presentation/manager/entertainment_news_cubit/entertainment_news_cubit.dart';
import 'package:newzly/features/home/presentation/manager/general_news_cubit/general_news_cubit.dart';
import 'package:newzly/features/home/presentation/manager/health_news_cubit/health_news_cubit.dart';
import 'package:newzly/features/home/presentation/manager/sports_news_cubit/sports_news_cubit.dart';
import 'package:newzly/features/home/presentation/manager/technology_news_cubit/technology_news_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late int _pageIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _pageIndex = index;
      _tabController.animateTo(index);
    });
  }

  void _onTabChanged(int index) {
    setState(() {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.bounceInOut,
      );
    });
  }

  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _pageIndex);
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
        bottom: TabBar(
          onTap: _onTabChanged,
          controller: _tabController,
          tabs: [
            Tab(text: 'general'),
            Tab(text: 'health'),
            Tab(text: 'sports'),
            Tab(text: 'technology'),
            Tab(text: 'entertainment'),
            Tab(text: 'business'),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          BlocProvider<GeneralNewsCubit>(
            create: (context) => getIt<GeneralNewsCubit>()..fetchGeneralNews(),
            child: GeneralNewsView(),
          ),
          BlocProvider<HealthNewsCubit>(
            create: (context) => getIt<HealthNewsCubit>()..fetchHealthNews(),
            child: HealthNewsView(),
          ),
          BlocProvider<SportsNewsCubit>(
            create: (context) => getIt<SportsNewsCubit>()..fetchSportsNews(),
            child: SportsNewsView(),
          ),

          BlocProvider<TechnologyNewsCubit>(
            create:
                (context) =>
                    getIt<TechnologyNewsCubit>()..fetchTechnologyNews(),
            child: TechnologyNewsView(),
          ),
          BlocProvider<EntertainmentNewsCubit>(
            create:
                (context) => EntertainmentNewsCubit(
                  fetchEntertainmentNewsUseCase: FetchEntertainmentNewsUseCase(
                    HomeRepositoryImplementation(
                      homeLocalDataSource: HomeLocalDataSourceImplementation(),
                      homeRemoteDataSource: HomeRemoteDataSourceImplementation(
                        dioHelper: DioHelper(
                          Dio(
                              BaseOptions(
                                baseUrl: baseUrl,
                                receiveDataWhenStatusError: true,
                                connectTimeout: const Duration(seconds: 50),
                                receiveTimeout: const Duration(seconds: 50),
                              ),
                            )
                            ..interceptors.add(
                              LogInterceptor(
                                requestBody: true,
                                error: true,
                                requestHeader: true,
                                responseHeader: false,
                                request: true,
                                responseBody: true,
                                logPrint: (object) => log(object.toString()),
                              ),
                            ),
                        ),
                      ),
                    ),
                  ),
                )..fetchEntertainmentNews(),
            child: EntertainmentNewsView(),
          ),
          BlocProvider<BusinessNewsCubit>(
            create:
                (context) => BusinessNewsCubit(
                  fetchBusinessNewsUseCase: FetchBusinessNewsUseCase(
                    HomeRepositoryImplementation(
                      homeLocalDataSource: HomeLocalDataSourceImplementation(),
                      homeRemoteDataSource: HomeRemoteDataSourceImplementation(
                        dioHelper: DioHelper(
                          Dio(
                              BaseOptions(
                                baseUrl: baseUrl,
                                receiveDataWhenStatusError: true,
                                connectTimeout: const Duration(seconds: 50),
                                receiveTimeout: const Duration(seconds: 50),
                              ),
                            )
                            ..interceptors.add(
                              LogInterceptor(
                                requestBody: true,
                                error: true,
                                requestHeader: true,
                                responseHeader: false,
                                request: true,
                                responseBody: true,
                                logPrint: (object) => log(object.toString()),
                              ),
                            ),
                        ),
                      ),
                    ),
                  ),
                )..fetchBusinessNews(),
            child: BusinessNewsView(),
          ),
        ],
      ),
    );
  }
}
