// import 'package:easy_lamp/core/resource/my_colors.dart';
// import 'package:easy_lamp/core/resource/my_spaces.dart';
// import 'package:flutter/material.dart';
//
// class DisableButton extends StatelessWidget {
//   Widget? right, left;
//   String? text;
//   VoidCallback? onPress;
//
//   DisableButton({
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
//           backgroundColor:
//               MaterialStateProperty.all(MyColors.blueGrey.shade200),
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                   borderRadius: MyRadius.sm,
//                   side: BorderSide(
//                     color: MyColors.blueGrey.shade200,
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
//               style: Light400Style.normal
//                   .copyWith(color: MyColors.blueGrey.shade400),
//             ),
//             const SizedBox(
//               width: MySpaces.s10,
//             ),
//             if (left != null) left!,
//           ],
//         ));
//   }
// }
