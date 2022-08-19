import 'package:flutter/material.dart';
import 'package:newsapp/services/news_service.dart';
import 'package:newsapp/views/tab1_view.dart';
import 'package:newsapp/views/tab2_view.dart';
import 'package:provider/provider.dart';

class TabsView extends StatelessWidget {
  const TabsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _BottomNavBar(),
      ),
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navModel = Provider.of<NavModel>(context);
    final newsService = Provider.of<NewsService>(context);

    return PageView(
      controller: navModel.controller,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1View(),
        Tab2View(),
      ],
    );

  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavModel>(context);
    return BottomNavigationBar(
      onTap: (i) => navProvider.pagActual = i,
      currentIndex: navProvider.pagActual,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Para ti",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: "Encabezado",
        ),
      ],
    );
  }
}

class NavModel extends ChangeNotifier
{
  int _pagActual = 0;
  PageController _controller = PageController();

  int get pagActual => _pagActual;
  PageController get controller => _controller;
  set pagActual(int val)
  {
    _pagActual = val;
    _controller.animateToPage(val, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }
}
