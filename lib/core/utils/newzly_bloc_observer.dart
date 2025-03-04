import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class NewzlyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log(change.toString());
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('$bloc closed');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('$bloc created successfully');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('error  $error with $bloc ');
  }
}
