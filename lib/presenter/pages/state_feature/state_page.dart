import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/state_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/input_date.dart';
import 'package:easy_lamp/core/widgets/input_export_type.dart';
import 'package:easy_lamp/core/widgets/input_group.dart';
import 'package:easy_lamp/core/widgets/input_interent_box.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/data/model/connection_type.dart';
import 'package:easy_lamp/data/model/internet_box_model.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/data/model/result_type_model.dart';
import 'package:easy_lamp/data/model/state_model.dart';
import 'package:easy_lamp/localization_service.dart';
import 'package:easy_lamp/locator.dart';
import 'package:easy_lamp/navigation_service.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/bloc/state_bloc/state_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
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
  List<InternetBoxModel>? internetsBox;
  DateTime? startDate, endDate;
  // Map type = {'value': 'power'};
  // List<Map> exportData = [
  //   {'value': 'power'},
  //   {'value': 'temperature'},
  //   {'value': 'pir'},
  //   {'value': 'light'},
  // ];

  List<ResultTypeModel> listTypeResult = [
    ResultTypeModel(name: "power", label: "power"),
    ResultTypeModel(name: "light", label: "light"),
    ResultTypeModel(name: "temperature", label: "temperature"),
    ResultTypeModel(name: "humidity", label: "humidity"),
    ResultTypeModel(name: "air_quality", label: "air_quality"),
  ];
  ResultTypeModel typeSelected = ResultTypeModel(name: LocalizationService.isLocalPersian ? "مصرف بر حسب وات": "power", label: "power");
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(GetConnectionTypeEvent());


    // BlocProvider.of<StateBloc>(context).add(GetDataStateEvent(StateParams(
    //   type['value'],
    // )));
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;

    // exportData[0].addAll({'title': al.state1});
    // exportData[1].addAll({'title': al.state2});
    // exportData[2].addAll({'title': al.state3});
    // exportData[3].addAll({'title': al.state4});
    // type.addAll({'title': al.state1});
    al = AppLocalizations.of(context)!;
    listTypeResult[0] = ResultTypeModel(name: al.state_power, label: "power");
    listTypeResult[1] = ResultTypeModel(name: al.state_light, label: "light");
    listTypeResult[2] = ResultTypeModel(name: al.state_temperature, label: "temperature");
    listTypeResult[3] = ResultTypeModel(name: al.state_humidity, label: "humidity");
    listTypeResult[4] = ResultTypeModel(name: al.state_air_quality, label: "air_quality");
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
                        InputExportType(
                          listTypeResult,
                          title: al.exportType,
                          isDate: true,
                          prevValue: typeSelected,
                          onNewDateSelected: (ResultTypeModel newValue) {
                            setState(() {
                              typeSelected = newValue;
                            });
                          },
                        ),
                        const SizedBox(
                          height: MySpaces.s24,
                        ),
                        Visibility(
                          visible: typeSelected.label == "power" ? true : false,
                          child: InputGroupSelect(
                            title: al.selectGroup,
                            isDate: true,
                            prevValue: lamps,
                            onNewDateSelected: (List<LampModel> newValue) {
                              lamps = newValue;
                            },
                          ),
                        ),
                        Visibility(
                          visible: typeSelected.label != "power" ? true : false,
                          child: InputInternetBoxSelect(
                            title: al.selectInternetBox,
                            isDate: true,
                            prevValue: internetsBox,
                            onNewDateSelected: (List<InternetBoxModel> newValue) {
                              internetsBox = [];
                              internetsBox = newValue;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: MySpaces.s24,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: BlocBuilder<StateBloc, StateState>(
                                // buildWhen: (prev, curr) {
                                //   return prev.isEnableDatePicker != curr.isEnableDatePicker;
                                // },
                                builder: (context, state) {
                                  return InputDate(
                                    title: al.startDate,
                                    prevDate: startDate,
                                    hint: '____/__/__',
                                    isDate: true,
                                    isEnabled:  state.isEnableDatePicker ,
                                    onNewDateSelected: (DateTime newDate) {
                                      setState(() {
                                        startDate = newDate;
                                      });
                                    },
                                  );
                                },
                              )
                            ),
                            const SizedBox(
                              width: MySpaces.s12,
                            ),
                            BlocBuilder<StateBloc, StateState>(
                              // buildWhen: (prev, curr) {
                              //   return prev.isEnableDatePicker != curr.isEnableDatePicker;
                              // },
                              builder: (context, state) {
                                return Expanded(
                                  child: InputDate(
                                    title: al.finishDate,
                                    prevDate: endDate,
                                    hint: '____/__/__',
                                    isDate: true,
                                    isEnabled:  state.isEnableDatePicker,
                                    onNewDateSelected: (DateTime newDate) {
                                      setState(() {
                                        endDate = newDate;
                                      });
                                    },
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: MySpaces.s24,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: BlocBuilder<StateBloc, StateState>(
                                buildWhen: (prev, curr) {
                                  return prev.isCheckDate != curr.isCheckDate;
                                },
                                builder: (context, state) {
                                  return Checkbox(
                                    activeColor: MyColors.primary,
                                    checkColor: MyColors.white,
                                    value: state.isCheckDate,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    onChanged: (value) {
                                      BlocProvider.of<StateBloc>(context)
                                          .add(OnChangeCheckBox(value!));
                                      if(value){
                                        endDate = null;
                                        startDate = null;
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: MySpaces.s8,),
                            Text(al.displayAllAvailableData,
                              style: Light300Style.sm
                                  .copyWith(color: MyColors.secondary.shade300),),
                          ],
                        ),
                        const SizedBox(
                          height: MySpaces.s24,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            text: al.show,
                            onPress: () {
                              if(typeSelected.label == "power"){
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
                                  typeSelected.label,
                                  lamps: lampsStr,
                                  timeStampGte: startDate,
                                  timeStampLte: endDate,
                                )));
                              }else {
                                BlocProvider.of<StateBloc>(context)
                                    .add(GetChartInternetBoxInformation(StateParams(
                                  typeSelected.label,
                                  lamps: internetsBox!.map((e) => e.id).join(',').toString(),
                                  timeStampGte: startDate,
                                  timeStampLte: endDate,
                                )));
                              }

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
                                  typeSelected!.name,
                                  style: DemiBoldStyle.normal
                                      .copyWith(color: MyColors.white),
                                ),
                              ),
                              if (startDate != null && endDate != null)
                                Builder(builder: (context) {
                                    Jalali startDateJalali = Jalali.fromDateTime(startDate!);
                                    Jalali endDateJalali = Jalali.fromDateTime(endDate!);
                                    DateTime startDateGregorian = startDate!;
                                    DateTime endDateGregorian = endDate!;

                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: [
                                          TextSpan(
                                            text: al.dateStart,
                                            style: Light400Style.sm.copyWith(
                                                color: MyColors.white),
                                          ),
                                          TextSpan(
                                            text: LocalizationService.isLocalPersian ?
                                            '${startDateJalali.year}/${startDateJalali.month}/${startDateJalali.day}'.toPersianDigit():
                                            '${startDateGregorian.year}/${startDateGregorian.month}/${startDateGregorian.day}',
                                            style: Light400Style.sm.copyWith(
                                                color: MyColors.primary),
                                          ),
                                          TextSpan(
                                            text: al.dateEnd,
                                            style: Light400Style.sm.copyWith(
                                                color: MyColors.white),
                                          ),
                                          TextSpan(
                                            text: LocalizationService.isLocalPersian ?
                                            '${endDateJalali.year}/${endDateJalali.month}/${endDateJalali.day}'.toPersianDigit():
                                            '${endDateGregorian.year}/${endDateGregorian.month}/${endDateGregorian.day}',
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
                              Chart(items, typeSelected!)
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

  ResultTypeModel type ;

  Chart(this.items, this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    final dataPoints = items.map((item) {
      double value = 0.0;
      switch (type.label) {
        case 'power':
          value = item.power!.toDouble();
          break;
        case 'temperature':
          value = item.temperature ?? 0.0;
          break;
        case 'humidity':
          value = item.humidity ?? 0.0;
          break;
        case 'light':
          value = item.light ?? 0.0;
          break;
        case 'airQuality':
          value = item.airQuality ?? 0.0;
          break;
        default:
          break;
      }
      String formattedDate;
      if(LocalizationService.isLocalPersian){
        Jalali jalaliDate = Jalali.fromDateTime(DateFormat("yyyy-MM-dd").parse(item.timestamp!)); // Assuming 'timestamp' is already a DateTime object
          formattedDate = "${jalaliDate.month}/${jalaliDate.day}";
      }else{
        DateTime jalaliDate = DateFormat("yyyy-MM-dd").parse(item.timestamp!); // Assuming 'timestamp' is already a DateTime object
        formattedDate = "${jalaliDate.month}/${jalaliDate.day}";
      }

      return ChartData(formattedDate, value);
    }).toList();

    return SfCartesianChart(
      margin: EdgeInsets.zero,
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.compact(),
          labelStyle: Light400Style.sm.copyWith(color: MyColors.white, fontFamily: LocalizationService.isLocalPersian ? "sans" : null),
        majorTickLines: MajorTickLines(color: MyColors.white, width: 0),
        minorTickLines: const MinorTickLines(width: 0),
        axisLine: AxisLine(width: 0),
        borderColor: MyColors.white,

      ),
        primaryXAxis:CategoryAxis(
          isVisible: true,
          labelStyle: TextStyle(color: MyColors.white, fontFamily: LocalizationService.isLocalPersian ? "sans" : null),
        ),

        // DateTimeAxis(
        //   majorGridLines: MajorGridLines(width: 0),
        //   axisLine: AxisLine(width: 0),
        //   axisBorderType: AxisBorderType.withoutTopAndBottom,
        //   labelStyle: Light400Style.sm.copyWith(color: MyColors.white, fontFamily: LocalizationService.isLocalPersian ? "sans" : null),
        //   tickPosition: TickPosition.outside,
        //   majorTickLines: MajorTickLines(color: MyColors.white, width: 0),
        //   minorTickLines: const MinorTickLines(width: 0),
        //   // dateFormat: DateFormat.Md(),
        // ),
      tooltipBehavior: TooltipBehavior(enable: true,activationMode: ActivationMode.singleTap,shouldAlwaysShow: true,textStyle:
        Light400Style.sm.copyWith(color: MyColors.primary.shade800, fontFamily: LocalizationService.isLocalPersian ? "sans" : null)
      ),

        plotAreaBorderWidth: 0,
        series:[
      // Renders line chart
      SplineSeries<ChartData, String>(
        color: MyColors.primary.shade800,

        splineType: SplineType.cardinal,
        dataSource: dataPoints,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
          animationDuration: 1000,
      ),
    ]);
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
