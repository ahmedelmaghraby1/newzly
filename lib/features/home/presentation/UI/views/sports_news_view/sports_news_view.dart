import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/core/localization/app_localization.dart';
import 'package:newzly/core/utils/show_snack_bar.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/presentation/UI/views/sports_news_view/widgets/sports_news_list_view.dart';
import 'package:newzly/features/home/presentation/controller/sports_news_cubit/sports_news_cubit.dart';

class SportsNewsView extends StatefulWidget {
  const SportsNewsView({super.key});

  @override
  State<SportsNewsView> createState() => _SportsNewsViewState();
}

class _SportsNewsViewState extends State<SportsNewsView>
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
        BlocProvider.of<SportsNewsCubit>(
          context,
        ).fetchSportsNews(page: _pageNumber);
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
    await BlocProvider.of<SportsNewsCubit>(context).fetchSportsNews(page: 0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: BlocConsumer<SportsNewsCubit, SportsNewsState>(
        listener: (context, state) {
          if (state is SportsNewsLoaded) {
            int oldArticlesCount = articles.length;
            articles.addAll(state.articles);
            int newArticlesCount = articles.length;
            if (newArticlesCount == oldArticlesCount) {
              _isLoading = true;
            }
          }
          if (state is SportsNewsPaginationFailure) {
            showErrorSnackBar(
              context: context,
              message: (state.errorMessage).tr(context),
            );
          }
        },
        builder:
            (context, state) =>
                (state is SportsNewsLoaded ||
                        state is SportsNewsPaginationLoading ||
                        state is SportsNewsPaginationFailure)
                    ? RefreshIndicator.adaptive(
                      backgroundColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                      onRefresh: _onRefresh,
                      child: SportsNewsListView(articles: articles),
                    )
                    : state is SportsNewsLoading
                    ? CircularProgressIndicator()
                    : state is SportsNewsFailure
                    ? Text((state.errorMessage).tr(context))
                    : Text('data'.tr(context)),
      ),
    );
  }
}
