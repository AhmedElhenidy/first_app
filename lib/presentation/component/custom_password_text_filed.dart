import 'package:flutter/material.dart';

class CustomPasswordTextFiled extends StatefulWidget{
  final String label;
  final TextEditingController? controller;
  CustomPasswordTextFiled({required this.label,this.controller});
  @override
  State<CustomPasswordTextFiled> createState() {
    return _CustomPasswordTextFiledState();
  }
}

class _CustomPasswordTextFiledState extends State<CustomPasswordTextFiled>{
  bool secure = true;// initial value
  @override
  Widget build (BuildContext context){
    return  TextField(
      controller: widget.controller,
      obscureText: secure,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(
              color: Colors.red,
            )
        ),
        labelText: widget.label,
        suffixIcon: InkWell(
          onTap: (){
            secure=!secure;
            print(secure);
            setState(() {});
            // if(secure==true){
            //   secure = false;
            // }else{
            //   secure = true;
            // }
          },
          child: Icon(
            secure
                ?
            Icons.visibility_off
                :
            Icons.visibility,
            color: Colors.black,
            size: 22,
          ),
        ),
      ),
    );
  }
}
