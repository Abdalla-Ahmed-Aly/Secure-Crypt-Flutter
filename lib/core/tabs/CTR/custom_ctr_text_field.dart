import 'package:flutter/material.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CustomCtrField extends StatelessWidget {
  final int? maxLines;
  final bool showIcon;
  final double? height;
  final String? hintText;
  final TextEditingController? controller;

  CustomCtrField({
    this.maxLines = 1,
    this.height,
    this.hintText,
    this.showIcon = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height != null ? height! : 60,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        cursorColor: ColorApp.primaryDarkColor,
        style: TextStyle(fontSize: 14,),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
          suffixIcon:
              showIcon
                  ? Padding(
                    padding: EdgeInsets.all(8),
                    child: Image.asset("assets/images/copy.png", width: 18),
                  )
                  : null,
          filled: true,
          fillColor: ColorApp.colorBg,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: ColorApp.primaryDarkColor,
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: ColorApp.primaryDarkColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
