import 'package:easy_lamp/core/widgets/dot_navigation/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'DotNavigationBarItem.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.curve,
    required this.duration,
    required this.selectedItemColor,
    required this.theme,
    required this.unselectedItemColor,
    required this.onTap,
    required this.itemPadding,
    required this.dotIndicatorColor,
    required this.enablePaddingAnimation,
    this.splashBorderRadius,
    this.splashColor,
  });

  final List<DotNavigationBarItem> items;
  final int currentIndex;
  final Curve curve;
  final Duration duration;
  final Color? selectedItemColor;
  final ThemeData theme;
  final Color? unselectedItemColor;
  final Function(int index) onTap;
  final EdgeInsets itemPadding;
  final Color? dotIndicatorColor;
  final bool enablePaddingAnimation;
  final Color? splashColor;
  final double? splashBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final item in items)
          TweenAnimationBuilder<double>(
            tween: Tween(
              end: items.indexOf(item) == currentIndex ? 0.0 : 0.0,
            ),
            curve: curve,
            duration: duration,
            builder: (context, t, _) {
              final _selectedColor =
                  item.selectedColor ?? selectedItemColor ?? theme.primaryColor;

              final _unselectedColor = item.unselectedColor ??
                  unselectedItemColor ??
                  theme.iconTheme.color;

              return Material(
                color: Color.lerp(Colors.transparent, Colors.transparent, t),
                borderRadius: BorderRadius.circular(splashBorderRadius ?? 8),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => onTap.call(items.indexOf(item)),
                  focusColor: splashColor ?? _selectedColor.withOpacity(0.1),
                  highlightColor:
                      splashColor ?? _selectedColor.withOpacity(0.1),
                  splashColor: splashColor ?? _selectedColor.withOpacity(0.1),
                  hoverColor: splashColor ?? _selectedColor.withOpacity(0.1),
                  child: Padding(
                    padding: itemPadding -
                        (enablePaddingAnimation
                            ? EdgeInsets.only(right: itemPadding.right * t)
                            : EdgeInsets.zero),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          item.path,
                          color: items.indexOf(item) == currentIndex
                              ? _selectedColor
                              : _unselectedColor,
                        ),
                        if (items.indexOf(item) == currentIndex)
                          Container(
                            width: 5,
                            height: 5,
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                color: _selectedColor, shape: BoxShape.circle),
                          )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
