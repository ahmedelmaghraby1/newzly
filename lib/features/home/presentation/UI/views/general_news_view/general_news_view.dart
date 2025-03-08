import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/core/localization/app_localization.dart';
import 'package:newzly/core/utils/show_snack_bar.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/presentation/controller/general_news_cubit/general_news_cubit.dart';
import 'package:newzly/features/home/presentation/UI/views/general_news_view/widgets/general_news_list_view.dart';

class GeneralNewsView extends StatefulWidget {
  const GeneralNewsView({super.key});

  @override
  State<GeneralNewsView> createState() => _GeneralNewsViewState();
}

class _GeneralNewsViewState extends State<GeneralNewsView>
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

  void _scrollControllerListener() async {
    double currentPosition = _scrollController.position.pixels;
    double maxScrollLength = _scrollController.position.maxScrollExtent;
    if (currentPosition > 0.9 * maxScrollLength) {
      if (!_isLoading) {
        _isLoading = true;
        await BlocProvider.of<GeneralNewsCubit>(
          context,
        ).fetchGeneralNews(page: _pageNumber);
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
    await BlocProvider.of<GeneralNewsCubit>(context).fetchGeneralNews(page: 0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: BlocConsumer<GeneralNewsCubit, GeneralNewsState>(
        listener: (context, state) {
          if (state is GeneralNewsLoaded) {
            int oldArticlesCount = articles.length;
            articles.addAll(state.articles);
            int newArticlesCount = articles.length;
            if (newArticlesCount == oldArticlesCount) {
              _isLoading = true;
            }
          }
          if (state is GeneralNewsPaginationFailure) {
            showErrorSnackBar(
              context: context,
              message: (state.errorMessage).tr(context),
            );
          }
        },

        builder:
            (context, state) =>
                (state is GeneralNewsLoaded ||
                        state is GeneralNewsPaginationLoading ||
                        state is GeneralNewsPaginationFailure)
                    ? RefreshIndicator.adaptive(
                      backgroundColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                      onRefresh: _onRefresh,
                      child: GeneralNewsListView(
                        articles: articles,
                        scrollController: _scrollController,
                      ),
                    )
                    : state is GeneralNewsLoading
                    ? CircularProgressIndicator()
                    : state is GeneralNewsFailure
                    ? Text((state.errorMessage).tr(context))
                    : Text('data'.tr(context)),
      ),
    );
  }
}
