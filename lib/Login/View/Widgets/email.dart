import 'package:flutter/material.dart';
import 'package:guin/Login/View/validator.dart';


class EmailFormField extends StatelessWidget {
  const EmailFormField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: TextFormField(
        controller: emailController,
        validator: (value) => Validator.validatePhoneNumber(value),
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.left,
        obscureText: false,
        autocorrect: false,
        cursorColor: Colors.red,
        keyboardType: TextInputType.phone,
        maxLines: 1,
        decoration: const InputDecoration(
          focusColor: Colors.amber,
          prefixIcon: Icon(Icons.email, color: Colors.white),
          hintText: "Enter mobile number",
          hintStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }
}
