import 'package:flutter/material.dart';

import 'package:guin/constants/constants.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blueGrey;
    // create a path
    var path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.300,
        size.width * 0.5, size.height * 0.760);
    path.quadraticBezierTo(size.width * 0.75, size.height * 1.3, size.width * 1,
        size.height * 0.940);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onTap,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MaterialButton(
        height: 50,
        minWidth: double.infinity,
        color: const Color.fromARGB(255, 4, 4, 4),
       
        onPressed: () {
          FocusScope.of(context).unfocus();
          
          if (formKey.currentState!.validate()) {
            onTap();
          }
          
        },
        child: const Text(
          "LOGIN",
          style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
        ),
      ),
    );
  }
}

class ForgetPasswordButton extends StatelessWidget {
  final Color color;
  final double rightPadding;
  const ForgetPasswordButton(
      {Key? key, required this.color, required this.rightPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
          padding: EdgeInsets.fromLTRB(0, 5, rightPadding, 0),
          child: SizedBox(
            height: 50,
            child: TextButton(
              //style: ButtonStyle(
              //     shape: MaterialStateProperty.all(
              //   RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(50.0)),
              // )),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) =>const OtpAuthentication(),
                //     ));
              },
              child: Text("Forgot Password ?",
                  style: TextStyle(
                      fontSize: 14, color: color, fontWeight: FontWeight.w300)),
            ),
          )),
    );
  }
}

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MaterialButton(
        height: 50,
        minWidth: double.infinity,
        color: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: onPressed,
        
        child: const Text(
          "Reset Password",
          style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
        ),
      ),
    );
  }
}
