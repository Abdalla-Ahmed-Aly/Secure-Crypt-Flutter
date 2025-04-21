import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/CTR/custom_ctr_text_field.dart';
import 'package:secure_crypt/core/tabs/RSA/custom_rsa_test_field.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CustomInputCtrContainer extends StatelessWidget {
  final TextEditingController plaintext;
  final TextEditingController secretKey;
  final TextEditingController ciphertext;
  final Function() GenrateKey;
  final Function() Encrypt;
  final String headerText;
  final String hintText;
  final String inputTypeText;
  final String outputTypeText;
  final String buttonText;

  CustomInputCtrContainer({
    required this.ciphertext,
    required this.Encrypt,
    required this.GenrateKey,
    required this.plaintext,
    required this.secretKey,
    required this.headerText,
    required this.hintText,
    required this.buttonText,
    required this.inputTypeText,
    required this.outputTypeText,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.88,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.02,
      ),
      decoration: BoxDecoration(
        color: ColorApp.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headerText,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            Text(
              hintText,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black45,
              ),
            ),
            SizedBox(height: height * 0.02),

            Text(
              inputTypeText,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(height: height * 0.005),
            CustomCtrField(5, 0.2, "Enter text to Hash", false, plaintext),

            SizedBox(height: height * 0.01),
            Text(
              "Secret Key",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            CustomRsaField(1, 0.06, "Enter Secret Key", true, secretKey),

            SizedBox(height: height * 0.02),
            ElevatedButton(
              onPressed: GenrateKey,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.primarySemiDarkColor,
                padding: EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 20,
                      color: ColorApp.primaryDarkColor,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: height * 0.02),
            Text(
              "Encrypt Output",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(height: height * 0.005),
            CustomRsaField(
              4,
              0.16,
              "Encrypt will appear here",
              true,
              ciphertext,
            ),

            SizedBox(height: height * 0.02),
            ElevatedButton(
              onPressed: Encrypt,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.primarySemiDarkColor,
                padding: EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Encrypt",
                    style: TextStyle(
                      fontSize: 20,
                      color: ColorApp.primaryDarkColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
