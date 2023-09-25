import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/presenter/pages/group_feature/add_group_bottom_sheet.dart';
import 'package:easy_lamp/presenter/pages/group_feature/edit_group_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class AddLampPage extends StatefulWidget {
  const AddLampPage({Key? key}) : super(key: key);

  @override
  State<AddLampPage> createState() => _AddLampPageState();
}

class _AddLampPageState extends State<AddLampPage> {
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset("assets/icons/arrow_right.svg")),
                  Center(
                    child: Text(
                      al.addLamps,
                      textAlign: TextAlign.center,
                      style: TitleStyle.t4.copyWith(
                        color: MyColors.white,
                      ),
                    ),
                  ),
                ],
              ),
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
                        var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SimpleBarcodeScannerPage(),
                            ));
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
