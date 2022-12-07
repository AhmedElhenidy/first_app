import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nobel/data/models/user_model.dart';

class CreateProfileService{

  static Future<bool> createProfile(UserModel userModel)async{
    try{
      final result = await FirebaseFirestore.instance.collection("users").add(
          userModel.toMap()
      );
      //data added successfully
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }
}