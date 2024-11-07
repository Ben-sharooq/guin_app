import 'package:flutter/material.dart';

import 'package:guin/Login/View/validator.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    super.key,
    required this.passwordController,
    required bool showPassword,
    required FocusNode passwordNode,
    required this.suffixIcon,
  })  : _showPassword = showPassword,
        _passwordNode = passwordNode;

  final TextEditingController passwordController;
  final bool _showPassword;
  final FocusNode _passwordNode;
  final Widget suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      style: const TextStyle(color: Colors.white),
      textAlign: TextAlign.left,
      obscureText: _showPassword,
      focusNode: _passwordNode,
      validator: (value) => Validator.valueExists(value),
      autocorrect: false,
      cursorColor: Colors.red,
      maxLines: 1,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: const Icon(Icons.lock, color: Colors.white),
        hintText: "Enter Password",
        hintStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
      ),
    );
  }
}

// // import 'dart:io';

// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_dashboard/constant/app_image.dart';
// // import 'package:flutter_dashboard/dashboard.dart';
// // import 'package:flutter_dashboard/loading_screen.dart';
// // import 'package:flutter_dashboard/pages/login/custom_button.dart';
// // import 'package:flutter_dashboard/pages/login/email.dart';
// // import 'package:flutter_dashboard/pages/login/password.dart';
// // import 'package:flutter_dashboard/service/login_service.dart';
// // import 'package:flutter_dashboard/widgets/profile/bloc/notification_bloc.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';

// // import 'bloc/login_bloc.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final FocusNode _usernameNode = FocusNode();
//   final FocusNode _passwordNode = FocusNode();
//   final formKey = GlobalKey<FormState>();
//   bool _showPassword = true;

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     _usernameNode.dispose();
//     _passwordNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         if (Platform.isAndroid) {
//           SystemNavigator.pop();
//         } else if (Platform.isIOS) {
//           exit(0);
//         }
//         return Future.value(true);
//       },
//       child: BlocProvider(
//         create: (context) =>
//             LoginBloc(RepositoryProvider.of<LoginService>(context)),
//         child: Scaffold(
//             backgroundColor: Colors.white,
//             body: BlocListener<LoginBloc, LoginState>(
//               listener: (context, state) {
//                 if (state is LoginFinishedState) {
//                   BlocProvider.of<NotificationBloc>(context)
//                       .add(LoadNotificationEvent());

//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DashBoard(),
//                       ));
//                 } else if (state is LoginErrorState) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       duration: Duration(seconds: 2),
//                       backgroundColor: Color.fromARGB(255, 90, 9, 3),
//                       content: Text("Incorrect username or password"),
//                     ),
//                   );
//                 } else if (state is LoginLoadingState) {}
//               },
//               child: BlocBuilder<LoginBloc, LoginState>(
//                 builder: (context, state) {
//                   bool inAsyncCall = false;
//                   if (state is LoginProgressingState) {
//                     inAsyncCall = true;
//                   }

//                   return LoadingScreen(
//                     inAsyncCall: inAsyncCall,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           // CustomPaint(
//                           //   painter: CurvePainter(),
//                           //   child: Container(
//                           //     height: 250.0.h,
//                           //   ),
//                           // ),
//                           Container(
//                               height: 300.h,
//                               width: double.infinity,
//                               decoration: const BoxDecoration(
//                                   boxShadow: [
//                                     // BoxShadow(
//                                     //     color:
//                                     //         Color.fromARGB(255, 140, 138, 138),
//                                     //     blurRadius: 50.0,
//                                     //     spreadRadius: 1.0,
//                                     //     offset: Offset(
//                                     //       3.0, // horizontal, move right 10
//                                     //       3.0, // vertical, move down 10
//                                     //     )),
//                                   ],
//                                   borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular((150)),
//                                     // bottomRight: Radius.circular((10))
//                                   ),
//                                   color: Colors.indigo),
//                               child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 50,
//                                   ), // const EdgeInsets.fromLTRB(40, 130, 0, 0),
//                                   child: Image.asset(
//                                     AppImage.navaltIconLogoWhite,
//                                     scale: 6,
//                                   ))),
//                           const SizedBox(
//                             height: 25,
//                           ),
//                           Container(
//                             height: 400,
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               //border: Border.all(width: 5, color: Colors.red),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(50)),
//                               // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
//                               boxShadow: [
//                                 // BoxShadow(
//                                 //     color: Colors.black12,
//                                 //     offset: Offset(0, 25),
//                                 //     blurRadius: 3,
//                                 //     spreadRadius: -10)
//                                 BoxShadow(
//                                   color: Colors.black12,
//                                   offset: Offset(0,
//                                       0), // Adjust the offset to control the shadow's position
//                                   blurRadius: 3,
//                                   spreadRadius:
//                                       0, // Adjust the spread radius to control the size of the shadow
//                                 ),
//                               ],
//                             ),
//                             child: Form(
//                               key: formKey,
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.fromLTRB(20, 50, 20, 0),
//                                 child: Column(
//                                   children: <Widget>[
//                                     EmailFormField(
//                                         emailController: emailController),
//                                     Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           20, 50, 20, 0),
//                                       child: Column(
//                                         children: <Widget>[
//                                           PasswordFormField(
//                                             passwordController:
//                                                 passwordController,
//                                             showPassword: _showPassword,
//                                             passwordNode: _passwordNode,
//                                             suffixIcon: IconButton(
//                                               onPressed: () {
//                                                 setState(
//                                                   () {
//                                                     _showPassword =
//                                                         !_showPassword;
//                                                   },
//                                                 );
//                                               },
//                                               icon: Icon(
//                                                 _showPassword
//                                                     ? Icons.visibility_off
//                                                     : Icons.visibility,
//                                                 color: Colors.amber,
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           // ForgetPasswordButton(
//                                           //     color: const Color(0xFF757171),
//                                           //     rightPadding: 10.w),
//                                           // const SizedBox(
//                                           //   height: 10,
//                                           // ),
//                                           LoginButton(
//                                               formKey: formKey,
//                                               emailController: emailController,
//                                               passwordController:
//                                                   passwordController),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             )),
//       ),
//     );
//   }
// }
