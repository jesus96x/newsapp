import 'package:flutter/material.dart';
import 'package:newsapp/services/news_service.dart';
import 'package:newsapp/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2View extends StatelessWidget {
  const Tab2View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: newsService.categorias.length,
                  itemBuilder: (BuildContext context, int idx) {
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              newsService.categorias[idx].icon,
                              color: newsService.selectedCat == newsService.categorias[idx].name
                                  ? Colors.pinkAccent
                                  : Colors.grey[400],
                            ),
                            onPressed: () {
                              newsService.selectedCat =newsService.categorias[idx].name;
                              //print(newsService.categorias[idx].name);
                            },
                          ),
                          SizedBox(height: 5,),
                          Text(newsService.categorias[idx].name),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                  child: ListaNoticias(articulos: newsService.articulosCatSeleccionada!),
              ),
            ],
          ),
        )
    );
  }
}

