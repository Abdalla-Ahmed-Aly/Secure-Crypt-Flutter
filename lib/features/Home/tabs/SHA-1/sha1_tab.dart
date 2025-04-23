import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/SHA-1/custom_sha_container.dart';
import 'package:secure_crypt/utils/color_app.dart';

class Sha1Tab extends StatelessWidget {
  static const String shaRouteName = "/sha";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width; // العرض
    final height = MediaQuery.sizeOf(context).height; // الارتفاع

    return SingleChildScrollView(
      child: Column(
        children: [
          // العنوان
          Text(
            "SHA-1 Hash",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 28,
              color: ColorApp.primaryDarkColor,
            ),
          ),
          SizedBox(height: height * 0.02), // مسافة باستخدام ScreenUtil
          // حاوية توليد الهاش
          CustomAlgoContainer.req(
            headerText: "Generate Hash",
            hintText: "Create SHA-1 hash from input text",
            enabled: false,
            secTextFieldHint: "Hash will appear here",
            secTextFieldDescription: "Generated SHA-1 Hash",
            height: 0.55,
            buttonText: "Generate Hash",
          ),
          SizedBox(height: height * 0.02), // مسافة باستخدام ScreenUtil
          // حاوية التحقق من الهاش
          CustomAlgoContainer.req(
            headerText: "Verify Hash",
            hintText: "Verify if a hash matches the input text",
            enabled: true,
            secTextFieldHint: "Enter hash to verify against",
            secTextFieldDescription: "SHA-1 Hash to Verify",
            height: 0.55,
            buttonText: "Verify Hash",
          ),
        ],
      ),
    );
  }
}
