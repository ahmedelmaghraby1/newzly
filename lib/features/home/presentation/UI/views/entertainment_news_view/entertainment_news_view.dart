import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/core/localization/app_localization.dart';
import 'package:newzly/core/utils/show_snack_bar.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/presentation/UI/views/Entertainment_news_view/widgets/Entertainment_news_list_view.dart';
import 'package:newzly/features/home/presentation/controller/entertainment_news_cubit/entertainment_news_cubit.dart';

class EntertainmentNewsView extends StatefulWidget {
  const EntertainmentNewsView({super.key});

  @override
  State<EntertainmentNewsView> createState() => _EntertainmentNewsViewState();
}

class _EntertainmentNewsViewState extends State<EntertainmentNewsView>
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
        BlocProvider.of<EntertainmentNewsCubit>(
          context,
        ).fetchEntertainmentNews(page: _pageNumber);
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
    await BlocProvider.of<EntertainmentNewsCubit>(
      context,
    ).fetchEntertainmentNews(page: 0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: BlocConsumer<EntertainmentNewsCubit, EntertainmentNewsState>(
        listener: (context, state) {
          if (state is EntertainmentNewsLoaded) {
            int oldArticlesCount = articles.length;
            articles.addAll(state.articles);
            int newArticlesCount = articles.length;
            if (newArticlesCount == oldArticlesCount) {
              _isLoading = true;
            }
          }
          if (state is EntertainmentNewsPaginationFailure) {
            showErrorSnackBar(
              context: context,
              message: (state.errorMessage).tr(context),
            );
          }
        },
        builder:
            (context, state) =>
                (state is EntertainmentNewsLoaded ||
                        state is EntertainmentNewsPaginationLoading ||
                        state is EntertainmentNewsPaginationFailure)
                    ? RefreshIndicator.adaptive(
                      onRefresh: _onRefresh,
                      child: EntertainmentNewsListView(articles: articles),
                    )
                    : state is EntertainmentNewsLoading
                    ? CircularProgressIndicator()
                    : state is EntertainmentNewsFailure
                    ? Text((state.errorMessage).tr(context))
                    : Text('error'.tr(context)),
      ),
    );
  }
}
