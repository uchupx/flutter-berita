import 'package:berita/clients/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News {
  static Future<ResponseNews> getHeadlines() async {
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=128136c38985480ab63e7a2a6baf9330');
    var body = await _client(url);
    var res = ResponseNews.fromJson(body);
    print(res);
    return res;
  }

  static Future<Map<String, dynamic>> _client(Uri url) async {
    var req = await http.get(url);
    var jsonBody = json.decode(req.body);
    return jsonBody;
  }
}

class ResponseNews {
  String status;
  int totalResults;
  List<Article> article;

  ResponseNews({this.status, this.totalResults, this.article});

  ResponseNews.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      article = new List<Article>();
      json['articles'].forEach((v) {
        article.add(new Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.article != null) {
      data['articles'] = this.article.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
