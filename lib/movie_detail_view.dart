import 'package:flutter/material.dart';
import 'package:flutter_application_kobismn/kobis_api.dart';

class MovieDetailView extends StatefulWidget {
  Map<String, dynamic> movie;
  MovieDetailView({super.key, required this.movie});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  void showPopup() async {
    var kobisApi = KobisApi(apiKey: '49e1567a35523dd0715681026c2fc1c0');
    var company = await kobisApi.getCompanyDetail(
        companyCd: widget.movie['companys'][0]['companyCd']);

    var msg = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('${company['companyNm']}'),
              content: const Text('company info'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('닫기')),
              ],
            )

        // Center(
        //   child: Container(
        //       width: 100,
        //       height: 100,
        //       color: Colors.white,
        //       child: const Text('hello')),
        // ),
        );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.movie);
    // 19동그라미 모양
    var grade = widget.movie['audits'][0]['watchGradeNm'].toString();
    Map<String, dynamic> gradeStyle = {};
    if (grade == '15세이상관람가') {
      // var grade_color = Colors.blue;
      // var grade_text = '15';
      gradeStyle['color'] = Colors.blue;
      gradeStyle['text'] = '15';
    }

    return Column(
      // 제목(제작연도)
      children: [
        Text('${widget.movie['movieNm']}(${widget.movie['prdtYear']})'),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: gradeStyle['color'], shape: BoxShape.circle),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: Center(child: Text(gradeStyle['text'])),
            )
          ],
        ),
        GestureDetector(
            onTap: () {
              // 영화 회사 정보를 검색해서, dialog로 띄우기
              showPopup();
            },
            child: Text('${widget.movie['companys'][0]['companyCd']}'))
      ],
    );
  }
}
