import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CustomTestField extends StatelessWidget {
  final int? _maxLines;
  final bool? showIcon;
  final double? _height;
  final String? _hintText;
  final bool? enabled;
  final TextEditingController? controller;

  // CustomTestField(this._maxLines, this._height, this._hintText, this.showIcon, {this.controller, this.enabled});

  CustomTestField.req({
    required int maxLines,
    required bool showIcon,
    required double height,
    required String hintText,
    this.controller,
  })  : _maxLines = maxLines,
        showIcon = showIcon,
        _height = height,
        _hintText = hintText,
        enabled = true;

  CustomTestField.controller(
    this.controller,
    this._maxLines,
    this._height,
    this._hintText,
    this.showIcon,
    this.enabled,
  );

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
        textAlign: TextAlign.start, 
        cursorColor: ColorApp.primaryDarkColor,
        style: TextStyle(
          fontSize: 16,
          color: ColorApp.primaryDarkColor,
          fontWeight: FontWeight.w400,
          letterSpacing: width * 0.001,
        ),
        decoration: InputDecoration(
          hintText: _hintText,
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: (showIcon ?? false)
              ? IconButton(
                  icon: Icon(Icons.copy_rounded, color: ColorApp.primaryDarkColor),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: controller?.text ?? ""));
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        Future.delayed(Duration(milliseconds: 100), () {
                          Navigator.of(context).pop();
                        });
                        return AlertDialog(content: Text("Copied to clipboard"));
                      },
                    );
                  },
                )
              : null,
          filled: true,
          fillColor: ColorApp.colorBg,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ColorApp.primaryDarkColor,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ColorApp.primaryDarkColor,
              width: 1.5,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ColorApp.primaryDarkColor,
              width: 1.5,
            ),
          ),
        ),
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      ),
    );
  }
}
