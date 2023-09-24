import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ElevatedButton(
          onPressed: () {
            Get.toNamed('/home');
            //username:akash
            //password:adesh
          },
          child: Text('data')),
    );
  }
}
