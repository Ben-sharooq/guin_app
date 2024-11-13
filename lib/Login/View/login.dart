import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guin/Login/Controller/loginController.dart';
import 'package:guin/Login/View/Widgets/custom_button.dart';
import 'package:guin/Login/View/Widgets/email.dart';
import 'package:guin/Login/View/Widgets/loading_screen.dart';
import 'package:guin/Login/View/Widgets/password.dart';
import 'package:guin/constants/app_image.dart';
import 'package:guin/constants/responsive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FocusNode _usernameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool _showPassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _usernameNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return WillPopScope(
        onWillPop: () {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
          return Future.value(true);
        },
        child: Scaffold(
          // backgroundColor: Colors.white,
          body: Stack(
            children: [
              SingleChildScrollView(child: Obx(() {
                return LoadingScreen(
                    inAsyncCall: loginController.isLoading.value,
                    child: Center(
                        child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 800,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Responsive.isMobile(context)
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      // horizontal: 50,
                                      ),
                                  child: Image.asset(
                                    AppImage.navaltLogo,
                                    scale: 2,
                                  ),
                                )
                              : const Text(""),
                          // const SizedBox(
                          //   height: 25,
                          // ),
                          Responsive.isMobile(context)
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 360,
                                    width: 360,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 40, 38, 38),
                                      //border: Border.all(width: 5, color: Colors.red),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                                      boxShadow: [
                                        // BoxShadow(
                                        //     color: Colors.black12,
                                        //     offset: Offset(0, 25),
                                        //     blurRadius: 3,
                                        //     spreadRadius: -10)
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0,
                                              0), // Adjust the offset to control the shadow's position
                                          blurRadius: 3,
                                          spreadRadius:
                                              0, // Adjust the spread radius to control the size of the shadow
                                        ),
                                      ],
                                    ),
                                    child: Form(
                                      key: formKey,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 50, 20, 0),
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: <Widget>[
                                            EmailFormField(
                                                emailController:
                                                    emailController),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 50, 20, 0),
                                              child: Column(
                                                children: <Widget>[
                                                  PasswordFormField(
                                                    passwordController:
                                                        passwordController,
                                                    showPassword: _showPassword,
                                                    passwordNode: _passwordNode,
                                                    suffixIcon: IconButton(
                                                      onPressed: () {
                                                        setState(
                                                          () {
                                                            _showPassword =
                                                                !_showPassword;
                                                          },
                                                        );
                                                      },
                                                      icon: Icon(
                                                        _showPassword
                                                            ? Icons
                                                                .visibility_off
                                                            : Icons.visibility,
                                                        color: Colors.amber,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // ForgetPasswordButton(
                                                  //     color: const Color(0xFF757171),
                                                  //     rightPadding: 10.w),
                                                  // const SizedBox(
                                                  //   height: 10,
                                                  // ),
                                                  LoginButton(
                                                      onTap: () {
                                                        loginController
                                                            .userAuthentication(
                                                                emailController
                                                                    .text,
                                                                passwordController
                                                                    .text);
                                                      },
                                                      formKey: formKey,
                                                      emailController:
                                                          emailController,
                                                      passwordController:
                                                          passwordController),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 138.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AppImage.navaltLogo,
                                            scale: 2,
                                          ),
                                          Container(
                                            height: 280,
                                            width: 1,
                                            color: const Color.fromARGB(
                                                255, 127, 126, 126),
                                          ),
                                          const SizedBox(
                                            width: 60,
                                          ),
                                          // VerticalDivider(
                                          //   thickness: 8,
                                          //   color: Colors.white,
                                          // ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 360,
                                            width: 360,
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 60, 60, 60),
                                              //border: Border.all(width: 5, color: Colors.red),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                                              boxShadow: [
                                                // BoxShadow(
                                                //     color: Colors.black12,
                                                //     offset: Offset(0, 25),
                                                //     blurRadius: 3,
                                                //     spreadRadius: -10)
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(0,
                                                      0), // Adjust the offset to control the shadow's position
                                                  blurRadius: 3,
                                                  spreadRadius:
                                                      0, // Adjust the spread radius to control the size of the shadow
                                                ),
                                              ],
                                            ),
                                            child: Form(
                                              key: formKey,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 50, 20, 0),
                                                child: Column(
                                                  children: <Widget>[
                                                    EmailFormField(
                                                        emailController:
                                                            emailController),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          20, 50, 20, 0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          PasswordFormField(
                                                            passwordController:
                                                                passwordController,
                                                            showPassword:
                                                                _showPassword,
                                                            passwordNode:
                                                                _passwordNode,
                                                            suffixIcon:
                                                                IconButton(
                                                              onPressed: () {
                                                                setState(
                                                                  () {
                                                                    _showPassword =
                                                                        !_showPassword;
                                                                  },
                                                                );
                                                              },
                                                              icon: Icon(
                                                                _showPassword
                                                                    ? Icons
                                                                        .visibility_off
                                                                    : Icons
                                                                        .visibility,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          // ForgetPasswordButton(
                                                          //     color: const Color(0xFF757171),
                                                          //     rightPadding: 10.w),
                                                          // const SizedBox(
                                                          //   height: 10,
                                                          // ),
                                                          LoginButton(
                                                              onTap: () {
                                                                loginController.userAuthentication(
                                                                    emailController
                                                                        .text,
                                                                    passwordController
                                                                        .text);
                                                              },
                                                              formKey: formKey,
                                                              emailController:
                                                                  emailController,
                                                              passwordController:
                                                                  passwordController),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    )));
              })),
            ],
          ),
        ));
  }
}
