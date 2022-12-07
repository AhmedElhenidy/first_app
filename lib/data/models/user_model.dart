class UserModel{
  String? name;
  String? phone;
  String? email;
  String? id;

  UserModel({
    this.name,
    this.phone,
    this.email,
    this.id,
});
  ///todo: add fromMap method here

  Map<String,dynamic> toMap(){
    return {
      "userEmail": email,
      "userID":id,
      "userName":name,
      "userPhone":phone,
    };
  }
}