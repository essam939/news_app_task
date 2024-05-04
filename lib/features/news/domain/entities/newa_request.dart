class NewsRequest {
  String? category;
  int page = 1;
  NewsRequest({this.category, required this.page});
  Map<String, dynamic> toJson() =>
      {"category":category=="All"?"":category,  "page": page};
}
