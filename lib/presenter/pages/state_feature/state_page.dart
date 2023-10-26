import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/state_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/input_date.dart';
import 'package:easy_lamp/core/widgets/input_export_type.dart';
import 'package:easy_lamp/core/widgets/input_group.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
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
  List<LampModel>? lamps;
  DateTime? startDate, endDate;
  Map type = {'title': 'مصرف بر حسب وات', 'value': 'power'};
  List<Map> exportData = [
    {'title': 'مصرف بر حسب وات', 'value': 'power'},
    {'title': 'دما رطوبت', 'value': 'temperature'},
    {'title': 'سنسور حرکتی', 'value': 'pir'},
    {'title': 'سنسور نور', 'value': 'light'},
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StateBloc>(context).add(GetDataStateEvent(StateParams(
      type['value'],
    )));
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
                      title: al.selectGroup,
                      isDate: true,
                      prevValue: lamps,
                      onNewDateSelected: (List<LampModel> newValue) {
                        lamps = newValue;
                      },
                    ),
                    const SizedBox(
                      height: MySpaces.s24,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InputDate(
                            title: al.startDate,
                            prevDate: startDate,
                            onNewDateSelected: (DateTime newDate) {
                              startDate = newDate;
                            },
                            isDate: true,
                          ),
                        ),
                        const SizedBox(
                          width: MySpaces.s12,
                        ),
                        Expanded(
                          child: InputDate(
                            title: al.finishDate,
                            prevDate: endDate,
                            isDate: true,
                            onNewDateSelected: (DateTime newDate) {
                              endDate = newDate;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: MySpaces.s24,
                    ),
                    InputExportType(
                      exportData,
                      title: al.exportType,
                      isDate: true,
                      prevValue: type,
                      onNewDateSelected: (Map newValue) {
                        type = newValue;
                      },
                    ),
                    const SizedBox(
                      height: MySpaces.s24,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        text: al.show,
                        onPress: () {
                          String? lampsStr;
                          if (lamps != null) {
                            lampsStr = lamps!
                                .map((e) => e.id)
                                .toList()
                                .join(',')
                                .toString();
                          }
                          BlocProvider.of<StateBloc>(context)
                              .add(GetDataStateEvent(StateParams(
                            type['value'],
                            lamps: lampsStr,
                            timeStampGte: startDate,
                            timeStampLte: endDate,
                          )));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<StateBloc, StateState>(
                buildWhen: (prev, curr) {
                  if (prev.getDataStateStatus is BaseSuccess &&
                      curr.getDataStateStatus is BaseNoAction) {
                    return false;
                  }
                  return true;
                  // return (prev.getDataStateStatus is BaseSuccess &&
                  //         curr.getDataStateStatus is BaseNoAction)
                  //     ? false
                  //     : true;
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
                          Chart(items)
                        ],
                      ),
                    );
                  } else if (state.getDataStateStatus is BaseLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: MyColors.primary,
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

class Chart extends StatelessWidget {
  List<Color> gradientColors = [
    MyColors.primary,
    MyColors.primary,
  ];
  List<StateModel> items;

  Chart(this.items, {super.key});

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
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('3/10', style: style);
        break;
      case 5:
        text = const Text('3/10', style: style);
        break;
      case 8:
        text = const Text('3/10', style: style);
        break;
      default:
        text = const Text('', style: style);
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
      titlesData: const FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: MyColors.noColor),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: items
              .map(
                (e) => FlSpot(
                    e.power ?? 0.toDouble(), e.timestamp.second.toDouble()),
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
