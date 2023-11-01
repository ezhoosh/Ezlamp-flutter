import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/arrow_back.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_name_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/internet_box_feature/edit_internet_box_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/add_internet_box_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/lamp_feature/add_lamp_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddLampInternetBoxPage extends StatefulWidget {
  int? groupId;
  bool isInternetBox;

  AddLampInternetBoxPage({Key? key, this.groupId, required this.isInternetBox})
      : super(key: key);

  @override
  State<AddLampInternetBoxPage> createState() => _AddLampInternetBoxPageState();
}

class _AddLampInternetBoxPageState extends State<AddLampInternetBoxPage> {
  late AppLocalizations al;

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    al = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MyColors.black,
      body: SafeArea(
        child: Column(
          children: [
            TopBar(
              title: widget.isInternetBox ? al.addInternetLamp : al.addLamps,
              onTapRight: () => Navigator.pop(context),
              iconRight: ArrowBack(),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: MySpaces.s32),
              child: Column(
                children: [
                  const SizedBox(
                    height: MySpaces.s40,
                  ),
                  Text(
                    'کد را اسکن کنید یا گوشی خود را نزدیک دستگاه کنید',
                    style: Light400Style.normal
                        .copyWith(color: MyColors.white.shade100),
                  ),
                  const SizedBox(
                    height: MySpaces.s16,
                  ),
                  Container(
                    width: double.infinity,
                    height: 150,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: MyColors.secondary.shade100,
                        borderRadius: MyRadius.base),
                    child: Image.asset('assets/images/ic_round_qr_code.png'),
                  ),
                  const SizedBox(
                    height: MySpaces.s24,
                  ),
                  Text(
                    'از کد راه اندازی استفاده کنید',
                    style: Light400Style.normal
                        .copyWith(color: MyColors.white.shade100),
                  ),
                  const SizedBox(
                    height: MySpaces.s4,
                  ),
                  Text(
                    'به دنبال کد روی دستگاه یا بسته بندی آن بگردید و آن را در قاب قرار دهید',
                    textAlign: TextAlign.center,
                    style: Light400Style.normal
                        .copyWith(color: MyColors.white.shade700),
                  ),
                  const SizedBox(
                    height: MySpaces.s24,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.black.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: MyRadius.sm,
                        ),
                      ),
                      onPressed: () async {
                        var options = const ScanOptions();
                        var result =
                            await BarcodeScanner.scan(options: options);
                        if (result.type == ResultType.Barcode) {
                          if (widget.groupId != null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AddLampPage(
                                        result.rawContent.toString(),
                                        widget.groupId,
                                      )),
                            );
                          } else {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return AddInternetBoxBottomSheet(
                                    result.rawContent.toString(),
                                    groupId: widget.groupId,
                                  );
                                });
                          }
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/images/scan.svg'),
                          const SizedBox(
                            width: MySpaces.s4,
                          ),
                          Text(
                            al.scan,
                            style: DemiBoldStyle.normal
                                .copyWith(color: MyColors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
