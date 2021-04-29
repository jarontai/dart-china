// import 'package:flutter/material.dart';

// import '../../../constants.dart';
// import 'widgets/widgets.dart';

// class TopicListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color(0xFF435AE4),
//       ),
//       child: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: kMainGradient,
//           ),
//           child: Scaffold(
//             backgroundColor: Colors.transparent,
//             appBar: buildAppBar(),
//             body: Column(
//               children: [
//                 WelcomeSection(),
//                 SizedBox(height: 15),
//                 Expanded(child: TopicSection()),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   AppBar buildAppBar() {
//     return AppBar(
//       toolbarHeight: 72,
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       leading: IconButton(
//         icon: Icon(Icons.menu),
//         splashRadius: 25,
//         onPressed: () {},
//       ),
//       actions: [
//         IconButton(
//           splashRadius: 30,
//           icon: CircleAvatar(
//             backgroundColor: kTagColr,
//             child: Icon(
//               Icons.person_outlined,
//               color: Colors.grey,
//             ),
//           ),
//           onPressed: () {},
//         )
//       ],
//     );
//   }
// }
