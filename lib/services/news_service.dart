import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:http/http.dart' as http;

import '../models/category_model.dart';

final endpoint = "newsapi.org";
final apiKey = "5c3559a604dd4ac0b90a33d0ad2f0055";

class NewsService extends ChangeNotifier
{
  List<Article> encabezados = [];
  Map<String, List<Article>> catArticulos = {};
  String _selectedCat = "business";
  List<Category> categorias = [
    Category(FontAwesomeIcons.building, "business"),
    Category(FontAwesomeIcons.vials, "science"),
    Category(FontAwesomeIcons.headSideVirus, "health"),
    Category(FontAwesomeIcons.addressCard, "general"),
    Category(FontAwesomeIcons.football, "sports"),
    Category(FontAwesomeIcons.memory, "technology"),
    Category(FontAwesomeIcons.tv, "entertainment"),
  ];

  String get selectedCat => _selectedCat;
  List<Article>? get articulosCatSeleccionada => catArticulos[_selectedCat];

  set selectedCat(String val)
  {
    _selectedCat = val;
    getArticlesByCats();
    notifyListeners();
  }

  NewsService()
  {
    getHeadlines();

    categorias.forEach((element) {
      catArticulos[element.name] = <Article>[];
    });
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

  getArticlesByCats() async
  {
    if(catArticulos[_selectedCat]!.isNotEmpty)
    {
      // NO REALIZA NADA. LA INFORMACION YA EXISTE Y SE MANTIENE INTACTA
      // SI SE LIMPIA DE Cache SE VUELVE A PEDIR LA INFO
    }
    else
    {
      const path = "v2/top-headlines";
      final res = await http.get(Uri.https(endpoint, path, {
        'apiKey': apiKey,
        'country': 'co',
        "category": _selectedCat,
      }));

      final news = NewsResponse.fromJson(res.body);
      catArticulos[_selectedCat]!.addAll(news.articles);
      notifyListeners();
    }
  }
}