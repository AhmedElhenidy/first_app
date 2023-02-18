import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nobel/domain/usecase/login_usecase.dart';
import 'package:nobel/presentation/component/custom_password_text_filed.dart';
import 'package:nobel/presentation/view/home_page_screen.dart';
import 'package:nobel/presentation/view/sing_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/repository_implementation/auth_repository_implementation.dart';
import '../component/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late LoginUseCase _loginUseCase;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginUseCase = LoginUseCase(AuthRepositoryImplementation());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text(
          "signIn".tr(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: (){
              if(context.locale.languageCode=="en"){
                context.setLocale(Locale("ar"));
              }else{
                context.setLocale(Locale("en"));
              }
            },
            child: Icon(Icons.language_rounded,color: Colors.blue,),
          )
        ],
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
              Text("don't_have_account".tr(),
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
               child:  Text("singUp".tr(),
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
            onTap: ()async{
              final result = await _loginUseCase.loginUseCase(emailController.text, passwordController.text);
              if(result ==null){
                print("Error");
              }else{
                print(result.user?.uid);
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder)=>HomePageScreen()),
                      (route) => false,
                );
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child:  Center(
                child: Text(
                  "login".tr(),
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

}
