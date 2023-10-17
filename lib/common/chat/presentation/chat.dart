// import 'package:flutter/material.dart';
// import 'package:matma/common/chat/presentation/message.dart';
// import 'package:matma/common/colors.dart';
// import 'package:matma/menu/level_icon/level_icon.dart';

// class Chat extends StatelessWidget {
//   const Chat({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       right: 100,
//       bottom: 0,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: DefaultTextStyle(
//           style: const TextStyle(
//               color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),
//           child: Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Container(
//                   color: defaultEquator,
//                   width: 410,
//                   height: 450,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Container(
//                     color: defaultBackground,
//                     width: 400,
//                     height: 440,
//                     child: const Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Ukończyłeś poziom',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Spacer(),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Message(),
//                             Message(),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
