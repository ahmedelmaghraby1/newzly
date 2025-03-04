import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/features/home/presentation/UI/views/sports_news_view/widgets/sports_news_list_view.dart';
import 'package:newzly/features/home/presentation/manager/sports_news_cubit/sports_news_cubit.dart';

class SportsNewsView extends StatefulWidget {
  const SportsNewsView({super.key});

  @override
  State<SportsNewsView> createState() => _SportsNewsViewState();
}

class _SportsNewsViewState extends State<SportsNewsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: BlocBuilder<SportsNewsCubit, SportsNewsState>(
        builder:
            (context, state) =>
                state is SportsNewsLoaded
                    ? SportsNewsListView(articles: state.articles)
                    : state is SportsNewsLoading
                    ? CircularProgressIndicator()
                    : state is SportsNewsFailure
                    ? Text(state.errorMessage)
                    : Text('data'),
      ),
    );
  }
}
