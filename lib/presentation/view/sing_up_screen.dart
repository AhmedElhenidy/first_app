import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nobel/data/models/user_model.dart';
import 'package:nobel/data/repository_implementation/auth_repository_implementation.dart';
import 'package:nobel/domain/usecase/create_profile_usecase.dart';
import 'package:nobel/domain/usecase/signup_usecase.dart';
import 'package:nobel/presentation/component/custom_password_text_filed.dart';
import 'package:nobel/presentation/component/custom_text_field.dart';
import 'package:nobel/presentation/view/home_page_screen.dart';

class SignUpScreen extends StatefulWidget{
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  // initialize repo impl
  final  _authRepositoryImplementation = AuthRepositoryImplementation();
  // declare use cases
  late SignupUseCase _signupUseCase;
  late CreateProfileUseCase _createProfileUseCase;
  @override
  initState(){
    super.initState();
    // initialize use cases
    _signupUseCase = SignupUseCase(repoImpl: _authRepositoryImplementation);
    _createProfileUseCase = CreateProfileUseCase(repoImpl: _authRepositoryImplementation);
  }

  @override
  Widget build (BuildContext context){
    return  WillPopScope(
      onWillPop: (){
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding:  const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              const Icon(
                Icons.arrow_back_rounded,
                size: 42,
                color: Colors.black,
              ),
              const Text(
                "Sign\nUp",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32,),
              CustomTextFiled(
                customController: nameController,
                label: "Name",
              ),
              CustomTextFiled(
                label: "Email",
                customController: emailController,
              ),
              CustomTextFiled(
                customController: phoneController,
                label: "Phone",
              ),
              CustomPasswordTextFiled(
                label: "password",
                controller: passwordController,
              ),
              const SizedBox(height: 16,),
              CustomPasswordTextFiled(
                label: "confirm password",
              ),
              const SizedBox(height: 16,),
              // TextButton(
              //   style:ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(Colors.red),
              //   ) ,
              //   onPressed:(){
              //     print("from elevated button");
              //     Navigator.pop(context);
              //   },
              //   child: Center(child: Text("Back")),
              // ),
              const SizedBox(height: 16,),
              TextButton(
                style:ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ) ,
                onPressed:()async{
                  final userCredentialResult = await _signupUseCase.signupUseCase(emailController.text, passwordController.text);
                  if(userCredentialResult ==null){
                    print("error");
                  }else{
                    print(userCredentialResult.user?.uid);
                    final createProfileResult = await _createProfileUseCase.createProfileUseCase(
                        UserModel(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          id: userCredentialResult.user?.uid
                        ),
                    );
                    if(createProfileResult == true){
                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder)=>HomePageScreen()),
                            (route) => false,
                      );
                    }
                  }
                  // register(context,emailController.text, passwordController.text);
                },
                child: const Center(
                    child: Text("Register",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register(BuildContext context,String userEmail , String userPassword)async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    ).then((value) {
      // when success
      print("result from registeration${value.user?.uid}");
      CollectionReference usersRef = FirebaseFirestore.instance.collection("users");
      usersRef.doc(value.user?.uid).set({
        "userID":value.user?.uid,
        "userName":nameController.text,
        "userPhone":phoneController.text,
        "userEmail":emailController.text,
      }).then((value) {
        print("user added");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder:(co)=>HomePageScreen()),
              (route)=>false,
        );
      },onError: (err){print(err.toString());});
    },onError: (errorMessage){
     // when error
      print("result from ron error ${errorMessage.toString()}");
    });

  }
}