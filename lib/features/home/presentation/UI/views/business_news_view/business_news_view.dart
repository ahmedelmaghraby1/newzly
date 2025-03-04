import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/features/home/presentation/UI/views/business_news_view/widgets/business_news_list_view.dart';
import 'package:newzly/features/home/presentation/manager/business_news_cubit/business_news_cubit.dart';

class BusinessNewsView extends StatefulWidget {
  const BusinessNewsView({super.key});

  @override
  State<BusinessNewsView> createState() => _BusinessNewsViewState();
}

class _BusinessNewsViewState extends State<BusinessNewsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: BlocBuilder<BusinessNewsCubit, BusinessNewsState>(
        builder:
            (context, state) =>
                state is BusinessNewsLoaded
                    ? BusinessNewsListView(articles: state.articles)
                    : state is BusinessNewsLoading
                    ? CircularProgressIndicator()
                    : state is BusinessNewsFailure
                    ? Text(state.errorMessage)
                    : Text('data'),
      ),
    );
  }
}
