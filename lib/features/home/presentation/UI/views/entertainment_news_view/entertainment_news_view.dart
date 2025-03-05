import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/features/home/presentation/UI/views/Entertainment_news_view/widgets/Entertainment_news_list_view.dart';
import 'package:newzly/features/home/presentation/controller/entertainment_news_cubit/entertainment_news_cubit.dart';

class EntertainmentNewsView extends StatefulWidget {
  const EntertainmentNewsView({super.key});

  @override
  State<EntertainmentNewsView> createState() => _EntertainmentNewsViewState();
}

class _EntertainmentNewsViewState extends State<EntertainmentNewsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: BlocBuilder<EntertainmentNewsCubit, EntertainmentNewsState>(
        builder:
            (context, state) =>
                state is EntertainmentNewsLoaded
                    ? EntertainmentNewsListView(articles: state.articles)
                    : state is EntertainmentNewsLoading
                    ? CircularProgressIndicator()
                    : state is EntertainmentNewsFailure
                    ? Text(state.errorMessage)
                    : Text('data'),
      ),
    );
  }
}
