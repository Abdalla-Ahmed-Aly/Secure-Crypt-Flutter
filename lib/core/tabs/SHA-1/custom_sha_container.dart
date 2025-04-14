import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/SHA-1/custom_test_field.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CustomAlgoContainer extends StatelessWidget {

  late String headerText;
  late String hintText;
  late String desTxeFieldDoText;
  late String buttonText;
  double? _height;

  CustomAlgoContainer(this.headerText,this.hintText,this.desTxeFieldDoText,this.buttonText,this._height);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * _height!,
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
          SizedBox(height: height * 0.02,),
          Text("Input Text",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.black),),
          SizedBox(height: height * 0.005,),
          CustomTestField(5,0.2,"Enter text to Hash",false),
          Text(desTxeFieldDoText,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.black)),
          CustomTestField(1,0.06,"Hash will appear here",true),
          SizedBox(height: height * 0.02,),
          Center(
            child: ElevatedButton(
                onPressed: (){
                  // todo: here What you will generate
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorApp.primarySemiDarkColor,
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
                child: Text(buttonText,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: ColorApp.primaryDarkColor),)),
          )
        ],
      ),

    );
  }
}
