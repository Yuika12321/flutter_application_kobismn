import 'package:flutter/material.dart';
import 'package:flutter_application_kobismn/movie_detail.dart';
import 'kobis_api.dart';

class RankPage extends StatefulWidget {
  const RankPage({
    super.key,
  });

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  final kobisApi = KobisApi(apiKey: '49e1567a35523dd0715681026c2fc1c0');
  dynamic body = const Center(
    child: Text(
      '날짜 선택',
      style: TextStyle(fontSize: 30),
    ),
  );

  void showCal() async {
    var dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(const Duration(days: 1)),
        firstDate: DateTime(2022),
        lastDate: DateTime.now().subtract(const Duration(days: 1)));
    if (dt != null) {
      // 2022-02-02 00:00:00
      var targetDt = dt.toString().split(' ')[0].replaceAll('-', '');
      var movies = kobisApi.getDailyBoxOffic(targetDt: targetDt);
      showList(movies);
    }
  }

  void showList(Future<List<dynamic>> movies) {
    setState(() {
      body = FutureBuilder(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // 데이터가 넘어옴
            var movies = snapshot.data;
            return ListView.separated(
                itemBuilder: (context, index) {
                  var rankColor = Colors.black;
                  if (index == 0) {
                    rankColor = Colors.red;
                  } else if (index == 1) {
                    rankColor = Colors.blue;
                  } else if (index == 2) {
                    rankColor = Colors.green;
                  }

                  return ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: rankColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        movies[index]['rank'],
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                    title: Text(movies[index]['movieNm']),
                    subtitle: Text('누적 관객수 : ${movies[index]['audiAcc']}명'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetail(movieCd: movies[index]['movieCd']),
                        )),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: movies!.length);
          } else {
            // 로딩중 ...
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: showCal,
        child: const Icon(Icons.calendar_month),
      ),
    );
  }
}
