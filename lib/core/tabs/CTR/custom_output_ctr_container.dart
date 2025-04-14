import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/RSA/custom_rsa_test_field.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CustomOutputCtrContainer extends StatelessWidget {
  late String headerText;
  late String hintText;
  late String inputTypeText;
  late String outputTypeText;
  late String buttonText;

  CustomOutputCtrContainer(
      {required this.headerText,required this.hintText,
        required this.buttonText,required this.inputTypeText});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.78,
      padding: EdgeInsets.only(
          left: width * 0.05,
          right: width * 0.05,
          top: height * 0.02
      ),
      decoration: BoxDecoration(
        color: ColorApp.primaryColor,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(headerText,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 24,color: Colors.black),),
          Text(hintText,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.black45),),

          SizedBox(height: height * 0.01,),
          Text(inputTypeText,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.black),),
          CustomRsaField(5,0.2,"Enter Encrypted Text to Decrypt",false),

          SizedBox(height: height * 0.005,),
          Text("Secret Key",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.black)),
          CustomRsaField(1,0.06,"Enter Secret Key",true),

          SizedBox(height: height * 0.02,),
          Text("Decrypted Output",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.black)),
          CustomRsaField(4,0.16,"Decrypted Output",false),

          SizedBox(height: height * 0.02,),
          Center(
            child: ElevatedButton(
                onPressed: (){
                  // todo: here What you will generate
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorApp.primarySemiDarkColor,
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 109),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
                child: Text(buttonText,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: ColorApp.primaryDarkColor),)),
          )
        ],
      ),

    );
  }
}
