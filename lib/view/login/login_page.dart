import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_culture/controller/auth_controller.dart';
import 'package:urban_culture/res/constants.dart';

class LoginPage extends StatelessWidget {
   final _authController=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: IconButton(
          onPressed: (){
            _authController.signInWithGoogle();

          },
          icon: Icon(Icons.login,size: 32,color: Colors.black,),
        ),
      ),
    );
  }
}
