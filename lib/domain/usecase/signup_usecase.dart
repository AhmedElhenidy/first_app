import 'package:firebase_auth/firebase_auth.dart';
import 'package:nobel/domain/repository/auth_repository.dart';

class SignupUseCase{
  AuthRepository repoImpl ;
  SignupUseCase({required this.repoImpl});

  Future<UserCredential?> signupUseCase(String email,String password){
     return repoImpl.signUp(email: email, password: password);
  }
}