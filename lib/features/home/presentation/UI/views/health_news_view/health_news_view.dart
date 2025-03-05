import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/features/home/presentation/UI/views/health_news_view/widgets/health_news_list_view.dart';
import 'package:newzly/features/home/presentation/controller/health_news_cubit/health_news_cubit.dart';

class HealthNewsView extends StatefulWidget {
  const HealthNewsView({super.key});

  @override
  State<HealthNewsView> createState() => _HealthNewsViewState();
}

class _HealthNewsViewState extends State<HealthNewsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: BlocBuilder<HealthNewsCubit, HealthNewsState>(
        builder:
            (context, state) =>
                state is HealthNewsLoaded
                    ? HealthNewsListView(articles: state.articles)
                    : state is HealthNewsLoading
                    ? CircularProgressIndicator()
                    : state is HealthNewsFailure
                    ? Text(state.errorMessage)
                    : Text('data'),
      ),
    );
  }
}
