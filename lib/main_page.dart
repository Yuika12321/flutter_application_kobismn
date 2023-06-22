import 'package:flutter/material.dart';
import 'package:flutter_application_kobismn/rank_page.dart';
import 'package:flutter_application_kobismn/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _idx = 1;
  dynamic loadPage = const Text('검색하세용');

  @override
  Widget build(BuildContext context) {
    var menus = [
      const RankPage(),
      const RankPage(),
      const SearchPage(),
    ];
    List<BottomNavigationBarItem> items = [];

    items.add(
        const BottomNavigationBarItem(label: 'home', icon: Icon(Icons.home)));
    items.add(
        const BottomNavigationBarItem(label: '박스오피스', icon: Icon(Icons.stars)));
    items.add(
        const BottomNavigationBarItem(label: '영화검색', icon: Icon(Icons.search)));

    return Scaffold(
      body: loadPage,
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: _idx,
        onTap: (value) {
          setState(() {
            _idx = value;
            loadPage = menus[value];
          });
        },
      ),
    );
  }
}
