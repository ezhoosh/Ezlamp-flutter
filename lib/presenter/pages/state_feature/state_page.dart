import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/state_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/input_date.dart';
import 'package:easy_lamp/core/widgets/input_export_type.dart';
import 'package:easy_lamp/core/widgets/input_select.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/state_model.dart';
import 'package:easy_lamp/presenter/bloc/state_bloc/state_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';

class StatePage extends StatefulWidget {
  const StatePage({Key? key}) : super(key: key);

  @override
  State<StatePage> createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  late AppLocalizations al;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StateBloc>(context).add(GetDataStateEvent(StateParams()));
  }

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MyColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(
                title: al.informationData,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: MySpaces.s40,
                  horizontal: MySpaces.s24,
                ),
                child: Column(
                  children: [
                    InputGroupSelect(
                      [],
                      title: al.selectGroup,
                      isDate: true,
                      onNewDateSelected: (String newDate) {},
                    ),
                    const SizedBox(
                      height: MySpaces.s24,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InputDate(
                            title: al.startDate,
                            onNewDateSelected: (String newDate) {},
                            isDate: true,
                          ),
                        ),
                        const SizedBox(
                          width: MySpaces.s12,
                        ),
                        Expanded(
                          child: InputDate(
                            title: al.finishDate,
                            isDate: true,
                            onNewDateSelected: (String newDate) {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: MySpaces.s24,
                    ),
                    InputExportType(
                      [],
                      title: al.exportType,
                      isDate: true,
                      onNewDateSelected: (String newDate) {},
                    ),
                    const SizedBox(
                      height: MySpaces.s24,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        text: al.show,
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<StateBloc, StateState>(
                buildWhen: (prev, curr) {
                  // if (prev.getDataStateStatus is BaseSuccess &&
                  //     curr.getDataStateStatus is BaseNoAction) {
                  //   return false;
                  // }
                  // return false;
                  return (prev.getDataStateStatus is BaseSuccess &&
                          curr.getDataStateStatus is BaseNoAction)
                      ? false
                      : true;
                },
                builder: (context, state) {
                  if (state.getDataStateStatus is BaseSuccess) {
                    List<StateModel> items =
                        (state.getDataStateStatus as BaseSuccess).entity;
                    return Container(
                      decoration: BoxDecoration(
                        color: MyColors.black.shade800,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 30),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'نام چارت',
                              style: DemiBoldStyle.normal
                                  .copyWith(color: MyColors.white),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                                  TextSpan(
                                    text: 'شروع تاریخ ',
                                    style: Light400Style.sm
                                        .copyWith(color: MyColors.white),
                                  ),
                                  TextSpan(
                                    text: '۱۴۰۲/۰۱/۰۷',
                                    style: Light400Style.sm
                                        .copyWith(color: MyColors.primary),
                                  ),
                                  TextSpan(
                                    text: ' تا تاریخ ',
                                    style: Light400Style.sm
                                        .copyWith(color: MyColors.white),
                                  ),
                                  TextSpan(
                                    text: '۱۴۰۲/۰۱/۰۷',
                                    style: Light400Style.sm
                                        .copyWith(color: MyColors.primary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          LineChartSample2(items)
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LineChartSample2 extends StatefulWidget {
  List<StateModel> data;

  LineChartSample2(this.data, {super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    MyColors.primary,
    MyColors.primary,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = Light400Style.sm.copyWith(color: MyColors.secondary);
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = Text('3/10', style: style);
        break;
      case 5:
        text = Text('3/10', style: style);
        break;
      case 8:
        text = Text('3/10', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10';
        break;
      case 3:
        text = '30';
        break;
      case 5:
        text = '50';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: MyColors.black.shade400,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: MyColors.noColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: MyColors.noColor),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: widget.data
              .map(
                (e) => FlSpot(
                  e.timestamp.millisecondsSinceEpoch.toDouble(),
                  e.humidity.toDouble(),
                ),
              )
              .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          // belowBarData: BarAreaData(
          //   show: true,
          //   gradient: LinearGradient(
          //     colors: gradientColors
          //         .map((color) => color.withOpacity(0.3))
          //         .toList(),
          //   ),
          // ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
