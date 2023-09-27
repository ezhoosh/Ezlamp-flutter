// import 'package:flutter/material.dart';
// import 'package:pickmap_application_new/componenet/my_colors.dart';
// import 'package:pickmap_application_new/componenet/my_spaces.dart';
// import 'package:pickmap_application_new/componenet/my_text_hierarchy.dart';
//
// class LinkButton extends StatelessWidget {
//   Widget? right, left;
//   String? text;
//   VoidCallback? onPress;
//
//   LinkButton({
//     Key? key,
//     this.right,
//     this.left,
//     this.text,
//     this.onPress,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         onPressed: onPress,
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(MyColors.noColor),
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                   borderRadius: MyRadius.sm,
//                   side: const BorderSide(
//                     color: MyColors.noColor,
//                   ))),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             if (right != null) right!,
//             const SizedBox(
//               width: MySpaces.s10,
//             ),
//             Text(
//               text ?? '',
//               style: Light400Style.normal.copyWith(color: MyColors.primary),
//             ),
//             const SizedBox(
//               width: MySpaces.s10,
//             ),
//             if (left != null) left!,
//           ],
//         ));
//   }
// }
