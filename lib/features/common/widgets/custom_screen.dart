// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:keyboard_dismisser/keyboard_dismisser.dart';
// import 'package:uzbek_club/features/common/bloc/show_pop_up/show_pop_up_bloc.dart';
// import 'package:uzbek_club/features/common/widgets/error_message_container.dart';
//
// class CustomScreen extends StatelessWidget {
//   final Widget child;
//
//   const CustomScreen({required this.child, Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ShowPopUpBloc, ShowPopUpState>(
//       builder: (context, state) => Material(
//         color: Colors.transparent,
//         child: Stack(
//           children: [
//             KeyboardDismisser(child: child),
//             AnimatedPositioned(
//               top: state.showPopUp
//                   ? MediaQuery.of(context).padding.top + 12
//                   : -(MediaQuery.of(context).padding.top + 12 + 56),
//               left: 16,
//               right: 16,
//               duration: const Duration(milliseconds: 150),
//               child: ErrorMessageContainer(
//                 message: state.message,
//                 isSuccess: state.isSuccess,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
