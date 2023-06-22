import 'package:flutter/material.dart';
import 'package:flutter_application_kobismn/kobis_api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var controller = TextEditingController();
  var _searchType = 'movieNm';
  var kobisApi = KobisApi(apiKey: '49e1567a35523dd0715681026c2fc1c0');

  void getMovieList() async {
    // 검색을 눌렀을 때 동작
    var movies = await kobisApi.getSearchMovieList(
        searchType: _searchType, searchValue: controller.text);
    for (var movie in movies) {
      print(movie);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        DropdownButton(
          itemHeight: 63,
          items: const [
            DropdownMenuItem(value: 'movieNm', child: Text('영화제목')),
            DropdownMenuItem(value: 'directorNm', child: Text('감독명')),
          ],
          onChanged: (value) {
            _searchType = value.toString();
          },
        ),
        Expanded(
          child: TextFormField(
            autofocus: true,
            controller: controller,
          ),
        ),
        ElevatedButton(onPressed: getMovieList, child: const Text('검색'))
      ],
    ));
  }
}
