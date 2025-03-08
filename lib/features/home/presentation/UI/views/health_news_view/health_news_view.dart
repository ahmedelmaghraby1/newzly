import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/core/localization/app_localization.dart';
import 'package:newzly/core/utils/show_snack_bar.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/presentation/UI/views/health_news_view/widgets/health_news_list_view.dart';
import 'package:newzly/features/home/presentation/controller/health_news_cubit/health_news_cubit.dart';

class HealthNewsView extends StatefulWidget {
  const HealthNewsView({super.key});

  @override
  State<HealthNewsView> createState() => _HealthNewsViewState();
}

class _HealthNewsViewState extends State<HealthNewsView>
    with AutomaticKeepAliveClientMixin {
  int _pageNumber = 1;
  bool _isLoading = false;
  late List<ArticleEntity> articles = [];

  @override
  bool get wantKeepAlive => true;
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollControllerListener);
    super.initState();
  }

  void _scrollControllerListener() {
    double currentPosition = _scrollController.position.pixels;
    double maxScrollLength = _scrollController.position.maxScrollExtent;
    if (currentPosition > 0.7 * maxScrollLength) {
      if (!_isLoading) {
        _isLoading = true;
        BlocProvider.of<HealthNewsCubit>(
          context,
        ).fetchHealthNews(page: _pageNumber);
        _pageNumber++;
        _isLoading = false;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    articles.clear();
    _pageNumber = 1;
    await BlocProvider.of<HealthNewsCubit>(context).fetchHealthNews(page: 0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: BlocConsumer<HealthNewsCubit, HealthNewsState>(
        listener: (context, state) {
          if (state is HealthNewsLoaded) {
            int oldArticlesCount = articles.length;
            articles.addAll(state.articles);
            int newArticlesCount = articles.length;
            if (newArticlesCount == oldArticlesCount) {
              _isLoading = true;
            }
          }
          if (state is HealthNewsPaginationFailure) {
            showErrorSnackBar(
              context: context,
              message: (state.errorMessage).tr(context),
            );
          }
        },
        builder:
            (context, state) =>
                (state is HealthNewsLoaded ||
                        state is HealthNewsPaginationLoading ||
                        state is HealthNewsPaginationFailure)
                    ? RefreshIndicator.adaptive(
                      onRefresh: _onRefresh,
                      child: HealthNewsListView(
                        articles: articles,
                        scrollController: _scrollController,
                      ),
                    )
                    : state is HealthNewsLoading
                    ? CircularProgressIndicator()
                    : state is HealthNewsFailure
                    ? Text((state.errorMessage).tr(context))
                    : Text('data'.tr(context)),
      ),
    );
  }
}
