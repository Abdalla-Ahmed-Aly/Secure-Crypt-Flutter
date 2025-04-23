import 'package:flutter/material.dart';
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
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: 15,
      ),
      decoration: BoxDecoration(
        color: ColorApp.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
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
          SizedBox(height: 10),
          Text(
            inputTypeText,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          CustomRsaField(5, 0.2, "Enter text to Hash", false, plaintext),
          SizedBox(height: 10),
          Text(
            "Secret Key",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          CustomRsaField(1, 0.06, "Enter Secret Key", true, secretKey),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Validation to check if plaintext or secretKey are empty
              if (plaintext.text.isEmpty ) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please fill in all fields."),
                    backgroundColor: Colors.red.shade400,
                  ),
                );
                return;
              }
              // Call GenrateKey if fields are not empty
              GenrateKey();
            },
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
          SizedBox(height: 10),
          Text(
            "Encrypt Output",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          CustomRsaField(4, 0.16, "Encrypt will appear here", true, ciphertext),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Validation to check if plaintext or secretKey are empty before encryption
              if (plaintext.text.isEmpty || secretKey.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please fill in all fields."),
                    backgroundColor: Colors.red.shade400,
                  ),
                );
                return;
              }
              // Call Encrypt function if fields are not empty
              Encrypt();
            },
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
    );
  }
}
