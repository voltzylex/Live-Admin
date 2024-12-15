class EndPoints {
  const EndPoints._();

  static const String baseUrl = 'https://iptv.sunilflutter.in/api/';
  static const String login = "admin/login";
  static const String user = "userdata";

  static const Duration timeout = Duration(seconds: 30);

  static const String token = 'authToken';
}

enum LoadDataState { initialize, loading, loaded, error, timeout, unknownerror }
