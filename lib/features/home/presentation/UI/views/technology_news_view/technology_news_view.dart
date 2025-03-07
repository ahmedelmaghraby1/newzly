import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/core/utils/show_snack_bar.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/presentation/UI/views/technology_news_view/widgets/technology_news_list_view.dart';
import 'package:newzly/features/home/presentation/controller/technology_news_cubit/technology_news_cubit.dart';

class TechnologyNewsView extends StatefulWidget {
  const TechnologyNewsView({super.key});

  @override
  State<TechnologyNewsView> createState() => _TechnologyNewsViewState();
}

class _TechnologyNewsViewState extends State<TechnologyNewsView>
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

  Future<void> _onRefresh() async {
    articles.clear();
    _pageNumber = 1;
    await BlocProvider.of<TechnologyNewsCubit>(
      context,
    ).fetchTechnologyNews(page: 0);
  }

  void _scrollControllerListener() {
    double currentPosition = _scrollController.position.pixels;
    double maxScrollLength = _scrollController.position.maxScrollExtent;
    if (currentPosition > 0.7 * maxScrollLength) {
      if (!_isLoading) {
        _isLoading = true;
        BlocProvider.of<TechnologyNewsCubit>(
          context,
        ).fetchTechnologyNews(page: _pageNumber);
        _pageNumber++;
        _isLoading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: BlocConsumer<TechnologyNewsCubit, TechnologyNewsState>(
        listener: (context, state) {
          if (state is TechnologyNewsLoaded) {
            articles.addAll(state.articles);
          }
          if (state is TechnologyNewsPaginationFailure) {
            showErrorSnackBar(context: context, message: state.errorMessage);
          }
        },
        builder:
            (context, state) =>
                (state is TechnologyNewsLoaded ||
                        state is TechnologyNewsPaginationLoading ||
                        state is TechnologyNewsPaginationFailure)
                    ? RefreshIndicator.adaptive(
                      onRefresh: _onRefresh,
                      child: TechnologyNewsListView(articles: articles),
                    )
                    : state is TechnologyNewsLoading
                    ? CircularProgressIndicator()
                    : state is TechnologyNewsFailure
                    ? Text(state.errorMessage)
                    : Text('data'),
      ),
    );
  }
}
