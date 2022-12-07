import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/user_model.dart';

abstract class AuthRepository{
   Future<UserCredential?> signIn({required String email , required String password});
   Future<UserCredential?> signUp({required String email ,required String password});
   Future<bool> createProfile(UserModel model);
}