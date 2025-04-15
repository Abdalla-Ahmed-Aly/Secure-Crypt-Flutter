import 'package:flutter/material.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CustomRsaField extends StatelessWidget {
  int? _maxLines;
  bool showIcon;
  double? _height;
  String? _hintText;
  CustomRsaField(this._maxLines,this._height,this._hintText,this.showIcon);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: _height! * height,
      child: TextFormField(
              onTapOutside: (_)=>FocusManager.instance.primaryFocus?.unfocus(),

        maxLines: _maxLines,
        cursorColor: ColorApp.primaryDarkColor,
        decoration: InputDecoration(
          hintText: _hintText,
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: Visibility(child: Container(padding: EdgeInsets.all(5),child: Icon(Icons.copy_rounded),),visible: showIcon,),
          filled: true,
          fillColor: ColorApp.colorBg,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorApp.primaryDarkColor,width: 1.5),
            ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorApp.primaryDarkColor,width: 1.5),
          ),
        ),
      ),
    );
  }
}
