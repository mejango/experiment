class PostResponse {
  final Map body;
  final Map headers;
  final int statusCode;

  PostResponse({
    required this.body,
    required this.headers,
    required this.statusCode,
  });
}
