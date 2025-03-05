import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/features/home/presentation/controller/general_news_cubit/general_news_cubit.dart';
import 'package:newzly/features/home/presentation/UI/views/general_news_view/widgets/general_news_list_view.dart';

class GeneralNewsView extends StatefulWidget {
  const GeneralNewsView({super.key});

  @override
  State<GeneralNewsView> createState() => _GeneralNewsViewState();
}

class _GeneralNewsViewState extends State<GeneralNewsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: BlocBuilder<GeneralNewsCubit, GeneralNewsState>(
        builder:
            (context, state) =>
                state is GeneralNewsLoaded
                    ? GeneralNewsListView(articles: state.articles)
                    : state is GeneralNewsLoading
                    ? CircularProgressIndicator()
                    : state is GeneralNewsFailure
                    ? Text(state.errorMessage)
                    : Text('data'),
      ),
    );
  }
}
