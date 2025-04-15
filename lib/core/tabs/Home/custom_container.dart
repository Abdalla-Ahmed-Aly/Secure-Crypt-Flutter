import 'package:flutter/material.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CustomContainer extends StatelessWidget {

  late String headText;
  late String topicText;
  late Function callFunction;
  late int index;
  CustomContainer(this.headText,this.topicText,this.index,this.callFunction);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width; ///    412
    final height = MediaQuery.of(context).size.height; ///  917
    return Container(
      width: width ,
      height: height * 0.32,
      padding: EdgeInsets.only(
          left: width * 0.05,
          right: width * 0.05,
          top: height * 0.02
      ),
      decoration: BoxDecoration(
        color: ColorApp.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(headText,textAlign: TextAlign.center,style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 24,
            color: ColorApp.primaryDarkColor
          ),),
          SizedBox(height: height * 0.02,),
          Text(topicText),
          SizedBox(height: height * 0.01,),
          InkWell(
            onTap: (){
              callFunction(index);
            },
            child: Row(
              children: [
                Text("Show More",style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: ColorApp.primaryDarkColor
                ),),SizedBox(width: width * 0.001,),
                Icon(Icons.arrow_forward_rounded,size: 20,color: ColorApp.primaryDarkColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
