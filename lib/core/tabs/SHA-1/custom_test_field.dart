import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CustomTestField extends StatelessWidget {
  int? _maxLines;
  bool? showIcon;
  double? _height;
  String? _hintText;
  bool? enabled;
  TextEditingController? controller;

  CustomTestField(this._maxLines,this._height,this._hintText,this.showIcon);

  CustomTestField.req({
    required int maxLines,
    required bool showIcon,
    required double height,
    required String hintText,
    this.controller
});

  CustomTestField.controller(this.controller,this._maxLines,this._height,this._hintText,this.showIcon,this.enabled);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: _height! * height,
      child: TextFormField(
        controller: controller,
        maxLines: _maxLines,
        enabled: enabled ?? true,
        cursorColor: ColorApp.primaryDarkColor,
        decoration: InputDecoration(
          hintText: _hintText,
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: Visibility(
            child: IconButton(
                icon: Icon(Icons.copy_rounded,color: ColorApp.primaryDarkColor,),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: controller!.text ?? ""));
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      Future.delayed(Duration(milliseconds: 100), () {
                        Navigator.of(context).pop(); // close the dialog
                      });
                      return AlertDialog(
                        content: Text("Copied to clipboard"),
                      );
                    },
                  );
                },
            ),
            visible: showIcon!,),
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorApp.primaryDarkColor,width: 1.5),
          ),
        ),
        onTapOutside: (_)=>FocusManager.instance.primaryFocus?.unfocus(),
      ),
    );
  }
}
