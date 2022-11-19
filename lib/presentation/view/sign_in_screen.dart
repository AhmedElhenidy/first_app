import 'package:flutter/material.dart';
import 'package:nobel/presentation/component/custom_password_text_filed.dart';
import 'package:nobel/presentation/view/home_page_screen.dart';
import 'package:nobel/presentation/view/sing_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../component/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Sign In",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 64),
        children: [
          CustomTextFiled(
            label: "email",
            customController: emailController,
          ),
          const SizedBox(height: 8,),
          CustomPasswordTextFiled(
              label: "password",
            controller: passwordController,
          ),
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
           children:  [
             const Text("don't have account?\t",
               style: TextStyle(
                   fontSize: 22,
                   color: Colors.black,
                   decoration: TextDecoration.underline
               ),
             ),
             const SizedBox(width: 8,),
             InkWell(
               onTap: (){
                 Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context)=>SignUpScreen(),
                     ),
                 );
               },
               child: const Text("sign up",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                  decoration: TextDecoration.underline
                ),
               ),
             ),
           ],
          ),
          const SizedBox(height: 32,),
          InkWell(
            onTap: (){
              signIn(emailController.text,passwordController.text,context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  void signIn(String mail,String password, BuildContext context)async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mail,
          password: password
      ).then((value) {
        print("logged in ${value.user?.uid}");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder:(co)=>HomePageScreen()),
              (route)=>false,
        );
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }else{
        print(e.message);
      }
    }
  }
}
