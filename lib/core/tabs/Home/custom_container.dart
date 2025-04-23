import 'package:flutter/material.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CustomContainer extends StatefulWidget {
  final String headText;
  final String topicText;
  final Function callFunction;
  final int index;

  CustomContainer(this.headText, this.topicText, this.index, this.callFunction);

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  bool _isArrowMoved = false;

  void _triggerFunction() {
    setState(() {
      _isArrowMoved = true;
    });
    Future.delayed(Duration(milliseconds: 300), () {
      widget.callFunction(widget.index);
      setState(() {
        _isArrowMoved = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width :double.infinity ,
      // height: height * 0.2,
      // height: 300,
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.only(left: 9,right: 9,top: 9,bottom: 9),
      decoration: BoxDecoration(
        color: ColorApp.primaryColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.headText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 24,
              color: ColorApp.primaryDarkColor,
            ),
          ),
          SizedBox(height:  10),
          Text(
            // maxLines: 7,
            // overflow: TextOverflow.ellipsis,
            widget.topicText,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: _triggerFunction,
            child: Row(
              children: [
                Text(
                  "Try",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: ColorApp.primaryDarkColor,
                  ),
                ),

                SizedBox(width: 7),
                AnimatedSlide(
                  offset: _isArrowMoved ? Offset(0.3, 0) : Offset.zero,
                  duration: Duration(milliseconds: 300),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 23,
                    color: ColorApp.primaryDarkColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    
    );
  }
}
