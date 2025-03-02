// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:newzly/core/utils/api_services.dart';
// import 'package:newzly/core/utils/enums.dart';

// class DioHelper extends ApiServices<Map<String, dynamic>> {
//   final Dio _dio;
//   DioHelper(this._dio);

//   @override
//   Future<Map<String, dynamic>> get({
//     String? endPoint,
//     int page = 1,
//     int pageSize = 10,
//     NewsCategory? category,
//   }) async {
//     late String newsCategory = 'general';
//     switch (category) {
//       case NewsCategory.general:
//         newsCategory = 'general';

//       case NewsCategory.health:
//         newsCategory = 'health';

//       case NewsCategory.sports:
//         newsCategory = 'sports';

//       case NewsCategory.technoogy:
//         newsCategory = 'technoogy';

//       case NewsCategory.business:
//         newsCategory = 'business';

//       case NewsCategory.entertainment:
//         newsCategory = 'entertainment';
//       case null:
//         newsCategory = 'general';
//     }
//     String baseUrl =
//         dotenv.env['base_url'] ?? 'https://newsapi.org/v2/top-headlines?';

//     Response response = await _dio.get(
//       '$baseUrl page=$page &pageSize=$pageSize category=$newsCategory',
//     );
//     return response.data as Map<String, dynamic>;
//   }
// }
