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
import 'package:easy_lamp/data/model/connection_type.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/data/model/state_model.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/bloc/state_bloc/state_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class StatePage extends StatefulWidget {
  const StatePage({Key? key}) : super(key: key);

  @override
  State<StatePage> createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  late AppLocalizations al;
  List<LampModel>? lamps;
  DateTime? startDate, endDate;
  Map type = {'value': 'power'};
  List<Map> exportData = [
    {'value': 'power'},
    {'value': 'temperature'},
    {'value': 'pir'},
    {'value': 'light'},
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(GetConnectionTypeEvent());
    BlocProvider.of<StateBloc>(context).add(GetDataStateEvent(StateParams(
      type['value'],
    )));
  }

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    exportData[0].addAll({'title': al.state1});
    exportData[1].addAll({'title': al.state2});
    exportData[2].addAll({'title': al.state3});
    exportData[3].addAll({'title': al.state4});
    type.addAll({'title': al.state1});
    return Scaffold(
      backgroundColor: MyColors.black,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          bool isBlue = state.connectionType == ConnectionType.Bluetooth;
          if (isBlue) {
            EasyLoading.showToast(al.needInternetError);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocListener<StateBloc, StateState>(
              listener: (context, state) {
                if (state.getChartInformation is BaseSuccess) {
                  List<LampModel> aa =
                      (state.getChartInformation as BaseSuccess).entity;
                  setState(() {
                    lamps = aa;
                  });
                }
              },
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
                                hint: '____/__/__',
                                prevDate: startDate,
                                onNewDateSelected: (DateTime newDate) {
                                  setState(() {
                                    startDate = newDate;
                                  });
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
                                hint: '____/__/__',
                                isDate: true,
                                onNewDateSelected: (DateTime newDate) {
                                  setState(() {
                                    endDate = newDate;
                                  });
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
                                  type['title'],
                                  style: DemiBoldStyle.normal
                                      .copyWith(color: MyColors.white),
                                ),
                              ),
                              if (startDate != null && endDate != null)
                                Builder(builder: (context) {
                                  Jalali s = Jalali.fromDateTime(startDate!);
                                  Jalali e = Jalali.fromDateTime(endDate!);
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: [
                                          TextSpan(
                                            text: 'شروع تاریخ ',
                                            style: Light400Style.sm.copyWith(
                                                color: MyColors.white),
                                          ),
                                          TextSpan(
                                            text:
                                                '${s.year}/${s.month}/${s.day}',
                                            style: Light400Style.sm.copyWith(
                                                color: MyColors.primary),
                                          ),
                                          TextSpan(
                                            text: ' تا تاریخ ',
                                            style: Light400Style.sm.copyWith(
                                                color: MyColors.white),
                                          ),
                                          TextSpan(
                                            text:
                                                '${e.year}/${e.month}/${e.day}',
                                            style: Light400Style.sm.copyWith(
                                                color: MyColors.primary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              const SizedBox(
                                height: 20,
                              ),
                              Chart(items, type)
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

  Map type = {'value': 'power'};

  Chart(this.items, this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(series: <ChartSeries>[
      // Renders line chart
      LineSeries<ChartData, int>(
        color: MyColors.primary,
        dataSource: items.map((e) {
          double a;
          switch (type['value']) {
            case 'power':
              a = e.power ?? 0.0;
            case 'temperature':
              a = e.temperature ?? 0.0;
            case 'pir':
              a = e.pir ?? 0.0;
            case 'light':
              a = e.airQuality ?? 0.0;
            default:
              a = 0.0;
          }

          return ChartData(e.timestamp.day, a);
        }).toList(),
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
      ),
    ]);
    return SfSparkLineChart(
      color: MyColors.primary,
      axisLineColor: MyColors.secondary,
      data: items.map((e) {
        // {'value': 'power'},
        // {'value': 'temperature'},
        // {'value': 'pir'},
        // {'value': 'light'},
        switch (type['value']) {
          case 'power':
            return e.power ?? 0.0;
          case 'temperature':
            return e.temperature ?? 0.0;
          case 'pir':
            return e.pir ?? 0.0;
          case 'light':
            return e.airQuality ?? 0.0;
          default:
            return 0.0;
        }
      }).toList(),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final int x;
  final double y;
}
