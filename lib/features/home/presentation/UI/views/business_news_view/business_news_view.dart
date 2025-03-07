import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/core/utils/show_snack_bar.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/presentation/UI/views/business_news_view/widgets/business_news_list_view.dart';
import 'package:newzly/features/home/presentation/controller/business_news_cubit/business_news_cubit.dart';

class BusinessNewsView extends StatefulWidget {
  const BusinessNewsView({super.key});

  @override
  State<BusinessNewsView> createState() => _BusinessNewsViewState();
}

class _BusinessNewsViewState extends State<BusinessNewsView>
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
        BlocProvider.of<BusinessNewsCubit>(
          context,
        ).fetchBusinessNews(page: _pageNumber);
        _pageNumber++;
        _isLoading = false;
      }
    }
  }

  Future<void> _onRefresh() async {
    articles.clear();
    _pageNumber = 1;
    await BlocProvider.of<BusinessNewsCubit>(
      context,
    ).fetchBusinessNews(page: 0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: BlocConsumer<BusinessNewsCubit, BusinessNewsState>(
        listener: (context, state) {
          if (state is BusinessNewsLoaded) {
            articles.addAll(state.articles);
          }
          if (state is BusinessNewsPaginationFailure) {
            showErrorSnackBar(context: context, message: state.errorMessage);
          }
        },
        builder:
            (context, state) =>
                (state is BusinessNewsLoaded ||
                        state is BusinessNewsPaginationLoading ||
                        state is BusinessNewsPaginationFailure)
                    ? RefreshIndicator.adaptive(
                      onRefresh: _onRefresh,
                      child: BusinessNewsListView(
                        articles: articles,
                        scrollController: _scrollController,
                      ),
                    )
                    : state is BusinessNewsLoading
                    ? CircularProgressIndicator()
                    : state is BusinessNewsFailure
                    ? Text(state.errorMessage)
                    : Text('data'),
      ),
    );
  }
}
