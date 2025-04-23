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
    // استخدام ScreenUtil بدلاً من MediaQuery
    final width = MediaQuery.sizeOf(context).width; // عرض الشاشة
    final height = MediaQuery.sizeOf(context).height; // ارتفاع الشاشة
    
    return Container(
      width: width,  // استخدام ScreenUtil
      height: _height! * height, // استخدام ScreenUtil
      child: TextFormField(
        controller: controller,
        maxLines: _maxLines,
        enabled: enabled ?? true,
        textAlign: TextAlign.start,
        cursorColor: ColorApp.primaryDarkColor,
        style: TextStyle(
          fontSize: 16,  // استخدم sp بدلاً من px للحصول على حجم نص مرن
          color: ColorApp.blackColor,
          fontWeight: FontWeight.w400,
          letterSpacing: width * 0.001, // يمكن أيضًا استخدام ScreenUtil هنا
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
            borderRadius: BorderRadius.circular(10),  // استخدام r للحصول على زاوية مرنة
            borderSide: BorderSide(
              color: ColorApp.primaryDarkColor,
              width: 1.5,  // استخدام w للحصول على سمك مرن
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
