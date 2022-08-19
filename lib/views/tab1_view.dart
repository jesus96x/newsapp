import 'package:flutter/material.dart';
import 'package:newsapp/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/services/news_service.dart';

class Tab1View extends StatefulWidget {
  const Tab1View({Key? key}) : super(key: key);

  @override
  State<Tab1View> createState() => _Tab1ViewState();
}

class _Tab1ViewState extends State<Tab1View> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return Scaffold(
      body: newsService.encabezados.length == 0 ?
      const Center(child: CircularProgressIndicator(),)
      :
      ListaNoticias(articulos: newsService.encabezados),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}