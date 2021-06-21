import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import './widget/Indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UserScorePage extends StatefulWidget {
  const UserScorePage({Key? key}) : super(key: key);

  @override
  _UserScorePageState createState() => _UserScorePageState();
}

class _UserScorePageState extends State<UserScorePage> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('امتیازات و سوابق من'),
        // backgroundColor: Colors.blue,
      ),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            color: Colors.blue.shade50,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'میزان صرفه جویی شما نسبت به سال گذشته',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    'نسبت مصرف دوره ماه جاری با دوره ماه سال قبل',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(PieChartData(
                            pieTouchData:
                                PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                final desiredTouch = pieTouchResponse.touchInput
                                        is! PointerExitEvent &&
                                    pieTouchResponse.touchInput
                                        is! PointerUpEvent;
                                if (desiredTouch &&
                                    pieTouchResponse.touchedSection != null) {
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                } else {
                                  touchedIndex = -1;
                                }
                              });
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections())),
                      )),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Indicator(
                            color: Color(0xff0293ee),
                            text: 'اردیبهشت',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Color(0xfff8b250),
                            text: 'خرداد',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Color(0xff845bef),
                            text: 'تیر',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Color(0xff13d38e),
                            text: 'مرداد',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 28,
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'امتیازات کسب شده شما',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    'براساس میزان صرفه جویی که در مصرف برق داشتید',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 11.0),
                  child: CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: 0.7,
                    center: new Text(
                      "170 امتیاز",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    footer: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: new Text(
                        "تنها 30 امتیاز دیگر تا رسیدن به رتبه نقره ای فاصله دارید",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            color: Colors.purple.shade600),
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.purple,
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'میزان مصرف شما براساس قبوض',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    'مقایسه مصرف ماه جاری با سال گذشته',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  height: 350,
                  padding: EdgeInsets.all(8),
                  child: ListView(
                    children: [
                      Card(
                        color: Colors.lightGreen.shade50,
                        child: ListTile(
                          title: Text('فروردین 1400 - مصرف 1120 Kw/h'),
                          subtitle: Text('فروردین 1399 - مصرف 1450 Kw/h'),
                          trailing: Text(
                            "38 امتیاز",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          leading: Icon(
                            Icons.trending_up_rounded,
                            color: Colors.green,
                            size: 40,
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.red.shade50,
                        child: ListTile(
                          title: Text('اردیبهشت 1400 - مصرف 1120 Kw/h'),
                          subtitle: Text('اردیبهشت 1399 - مصرف 980 Kw/h'),
                          trailing: Text(
                            "0 امتیاز",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          leading: Icon(
                            Icons.trending_down_rounded,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.lightGreen.shade50,
                        child: ListTile(
                          title: Text('خرداد 1400 - مصرف 5809 Kw/h'),
                          subtitle: Text('خرداد 1399 - مصرف 7250 Kw/h'),
                          trailing: Text(
                            "63 امتیاز",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          leading: Icon(
                            Icons.trending_up_rounded,
                            color: Colors.green,
                            size: 40,
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.lightGreen.shade50,
                        child: ListTile(
                          title: Text('تیر 1400 - مصرف 22005 Kw/h'),
                          subtitle: Text('تیر 1399 - مصرف 51615 Kw/h'),
                          trailing: Text(
                            "70 امتیاز",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          leading: Icon(
                            Icons.trending_up_rounded,
                            color: Colors.green,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
