import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/RSA/custom_rsa_test_field.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CustomOutputRsaContainer extends StatelessWidget {
  late String headerText;
  late String hintText;
  late String inputTypeText;
  late String buttonText;
  Function()? onPressed;
  late TextEditingController inputText;
  late TextEditingController outputText;

  CustomOutputRsaContainer({
    required this.headerText,
    required this.hintText,
    required this.buttonText,
    required this.inputTypeText,
    required this.onPressed,
    required this.inputText,
    required this.outputText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width,
      // height: 0.75,
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 15),
      decoration: BoxDecoration(
        color: ColorApp.primaryColor,
        borderRadius: BorderRadius.circular(12), // Use for border radius
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerText,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 24, // Use for font size
              color: Colors.black,
            ),
          ),
          Text(
            hintText,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16, // Use for font size
              color: Colors.black45,
            ),
          ),
          SizedBox(height: 10),
          Text(
            inputTypeText,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20, // Use for font size
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          CustomRsaField(
            5,
            0.2,
            "Enter Encrypted Text to Decrypt",
            false,
            inputText,
          ),
          SizedBox(height: 10),
          Text(
            "Decrypted Key",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20, // Use for font size
              color: Colors.black,
            ),
          ),
          CustomRsaField(4, 0.16, "Decrypted Output", false, outputText),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Validation to check if the input field is empty
                if (inputText.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter the encrypted text."),
                      backgroundColor: Colors.red.shade400,
                    ),
                  );
                  return;
                }
                // Call onPressed function if the input field is not empty
                if (onPressed != null) {
                  onPressed!();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.primarySemiDarkColor,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 109,
                ), // Use for padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // Use for border radius
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20, // Use for font size
                  color: ColorApp.primaryDarkColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
