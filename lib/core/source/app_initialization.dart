import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newzly/core/injection/injector.dart';
import 'package:newzly/core/utils/hive_helper.dart';
import 'package:newzly/core/utils/newzly_bloc_observer.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await HiveHelper.initHive();
  initGetIt();
  Bloc.observer = NewzlyBlocObserver();
}
