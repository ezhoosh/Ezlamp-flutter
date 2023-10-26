import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:easy_lamp/data/model/connection_type.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/pages/home_feature/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  late AppLocalizations al;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(GetConnectionTypeEvent());
  }

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return Material(
      child: Container(
        padding: const EdgeInsets.all(MySpaces.s24),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/bg_connection.png',
              ),
            ),
            const SizedBox(
              height: MySpaces.s24,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                al.selectYourConnection,
                style: Light300Style.normal
                    .copyWith(color: MyColors.black.shade100),
              ),
            ),
            const SizedBox(
              height: MySpaces.s24,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                int current =
                    state.connectionType == ConnectionType.Bluetooth ? 1 : 0;

                return Row(
                  children: [
                    getCard(Iconsax.global, al.internet, MyColors.primary, 0,
                        current),
                    const SizedBox(
                      width: 10,
                    ),
                    getCard(
                        Iconsax.bluetooth, al.blue, MyColors.info, 1, current),
                  ],
                );
              },
            ),
            const SizedBox(
              height: MySpaces.s40,
            ),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                onPress: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      ModalRoute.withName("/"));
                },
                text: al.login,
              ),
            )
          ],
        ),
      ),
    );
  }

  getCard(IconData iconData, String title, Color enabledColor, int index,
      int current) {
    return Expanded(
      child: ClickableContainer(
        onTap: () {
          BlocProvider.of<AuthBloc>(context).add(ChangeConnectionTypeEvent(
              index == 1 ? ConnectionType.Bluetooth : ConnectionType.Internet));
        },
        padding: const EdgeInsets.symmetric(
          vertical: MySpaces.s24,
        ),
        border: index == current ? Border.all(color: MyColors.primary) : null,
        color: MyColors.black.shade600,
        borderRadius: MyRadius.base,
        child: Column(
          children: [
            Icon(
              iconData,
              color: enabledColor,
              size: MySpaces.s24,
            ),
            const SizedBox(
              height: MySpaces.s12,
            ),
            Text(
              title,
              style: DemiBoldStyle.lg.copyWith(color: MyColors.white),
            )
          ],
        ),
      ),
    );
  }
}
