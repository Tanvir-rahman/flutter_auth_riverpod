class ListAPI {
  ListAPI._(); // coverage:ignore-line

  // Base URL
  static const String _baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://example.xyz',
  );
  static const String _apiVersion = '/api/v1';
  static const String _baseApiUrl = _baseUrl + _apiVersion;

  // Auth Endpoints
  static const String user = "$_apiVersion/admin/me";
  static const String login = "$_apiVersion/auth/oauth/token";
  static const String refreshToken = "$_apiVersion/auth/oauth/refresh";
  static const String logout = "$_apiVersion/admin/logout";
  static const String subscribe = "$_apiVersion/admin/me/subscribe";
  static const String updatePassword = "$_apiVersion/me/info-update";
}
