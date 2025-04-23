import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/RSA/custom_rsa_test_field.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CustomInputRsaContainer extends StatelessWidget {
  late String headerText;
  late String hintText;
  late String inputTypeText;
  late String outputTypeText;
  late String buttonText;
  late TextEditingController inputText;
  late TextEditingController outputText;
  Function()? onPressed;

  CustomInputRsaContainer({
    required this.headerText,
    required this.hintText,
    required this.buttonText,
    required this.inputTypeText,
    required this.outputTypeText,
    required this.inputText,
    required this.outputText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;

    return Container(
      // width: width,
      // // height: height* 0.96, // Use for height
      // height: 570,
      padding: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 20),
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
          CustomRsaField(5, 0.2, "Enter text to Hash", false, inputText),

          Text(
            outputTypeText,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20, // Use for font size
              color: Colors.black,
            ),
          ),
          CustomRsaField(5, 0.2, "Encrypt will appear here", true, outputText),

          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Validation to check if the input field is empty
                if (inputText.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter a value in the input field."),
                      backgroundColor: Colors.red.shade400,
                    ),
                  );
                  return;
                }
                // Validation to check if the output field is empty
                // if (outputText.text.isEmpty) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Please enter a value in the output field."),
                //       backgroundColor: Colors.red.shade400,
                //     ),
                //   );
                //   return;
                // }
                // Call onPressed function if fields are not empty
                if (onPressed != null) {
                  onPressed!();
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: ColorApp.primarySemiDarkColor,
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
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
