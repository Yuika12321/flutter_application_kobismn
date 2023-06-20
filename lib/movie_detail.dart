import 'package:flutter/material.dart';
import 'package:flutter_application_kobismn/kobis_api.dart';
import 'package:flutter_application_kobismn/movie_detail_view.dart';

class MovieDetail extends StatelessWidget {
  final String movieCd;
  MovieDetail({super.key, required this.movieCd});
  var kobisApi = KobisApi(apiKey: '49e1567a35523dd0715681026c2fc1c0');

  @override
  Widget build(BuildContext context) {
    var movieData = kobisApi.getMovieDetail(movieCd: movieCd);
    return Scaffold(
      body: FutureBuilder(
        future: movieData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var movie = snapshot.data; // ['movieNm']
            return MovieDetailView(movie: movie);
          } else {
            var msg = '데이터 로딩중 입니다.';
            return Center(child: Text(msg));
          }
        },
      ),
    );
  }
}
