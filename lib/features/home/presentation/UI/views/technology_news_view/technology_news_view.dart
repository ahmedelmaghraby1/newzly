import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/features/home/presentation/UI/views/technology_news_view/widgets/technology_news_list_view.dart';
import 'package:newzly/features/home/presentation/controller/technology_news_cubit/technology_news_cubit.dart';

class TechnologyNewsView extends StatefulWidget {
  const TechnologyNewsView({super.key});

  @override
  State<TechnologyNewsView> createState() => _TechnologyNewsViewState();
}

class _TechnologyNewsViewState extends State<TechnologyNewsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: BlocBuilder<TechnologyNewsCubit, TechnologyNewsState>(
        builder:
            (context, state) =>
                state is TechnologyNewsLoaded
                    ? TechnologyNewsListView(articles: state.articles)
                    : state is TechnologyNewsLoading
                    ? CircularProgressIndicator()
                    : state is TechnologyNewsFailure
                    ? Text(state.errorMessage)
                    : Text('data'),
      ),
    );
  }
}
