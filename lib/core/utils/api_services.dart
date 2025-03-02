abstract class ApiServices<Type> {
  Future<Type> get({Map<String, String>? queryParameters});
}
