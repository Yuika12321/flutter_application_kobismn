import 'package:flutter/material.dart';
import 'package:flutter_application_kobismn/kobis_api.dart';

class MovieDetail extends StatelessWidget {
  final String movieCd;
  MovieDetail({super.key, required this.movieCd});
  var kobisApi = KobisApi(apiKey: '49e1567a35523dd0715681026c2fc1c0');

  @override
  Widget build(BuildContext context) {
    kobisApi.getMovieDetail(movieCd: movieCd);
    return Scaffold(
      body: Text(movieCd),
    );
  }
}
