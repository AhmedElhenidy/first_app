import 'package:firebase_auth/firebase_auth.dart';
import 'package:nobel/data/models/user_model.dart';
import 'package:nobel/data/services/auth_service.dart';
import 'package:nobel/data/services/create_profile_service.dart';
import 'package:nobel/domain/repository/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository{
  @override
  Future<bool> createProfile(UserModel model)async {
    try {
      final userCredentialResult = await CreateProfileService.createProfile(model);
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  @override
  Future<UserCredential?> signIn({required String email, required String password}) async{
    try {
      final userCredentialResult = await AuthService.signIn(email, password);
      return userCredentialResult;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  @override
  Future<UserCredential?> signUp({required String email, required String password}) async{
    try {
      final userCredentialResult = await AuthService.signUp(email, password);
      return userCredentialResult;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}