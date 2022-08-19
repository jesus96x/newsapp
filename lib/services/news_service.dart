import 'package:flutter/material.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:http/http.dart' as http;

final endpoint = "newsapi.org";
final apiKey = "5c3559a604dd4ac0b90a33d0ad2f0055";

class NewsService extends ChangeNotifier
{
  List<Article> encabezados = [];

  NewsService()
  {
    getHeadlines();
  }

  getHeadlines() async
  {
    const path = "v2/top-headlines";
    final res = await http.get(Uri.https(endpoint, path, {
      'apiKey': apiKey,
      'country': 'co',
    }));

    final news = NewsResponse.fromJson(res.body);
    encabezados.addAll(news.articles);
    notifyListeners();

  }
}