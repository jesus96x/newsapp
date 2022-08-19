import 'package:flutter/material.dart';
import 'package:newsapp/theme/theme.dart';

import '../models/news_model.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> articulos;
  const ListaNoticias({Key? key, required this.articulos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articulos.length,
      itemBuilder: (BuildContext context, int i) {
        return _Noticia(article: articulos[i], idx: i,);
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article article;
  final int idx;
  const _Noticia({Key? key, required this.article, required this.idx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: article.urlToImage != null ? FadeInImage(
            placeholder: AssetImage("assets/giphy.gif"),
            image: NetworkImage(article.urlToImage!),
            /*article.urlToImage == null ? AssetImage("assets/no-image.png")
                : NetworkImage(article.urlToImage!)*/
          ) :
          FadeInImage(
            placeholder: AssetImage("assets/giphy.gif"),
            image: AssetImage("assets/no-image.png"),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Text("${idx + 1}. ", style: TextStyle(color: tema.colorScheme.secondary)),
              Text(article.source.name),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(article.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(article.description == null ? "" : article.description),
        ),
        SizedBox(height: 10,),
        Divider(),
      ],
    );
  }
}

