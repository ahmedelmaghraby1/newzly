import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> initializeApp() async {
  dotenv.load(fileName: 'assets/.env');
}
