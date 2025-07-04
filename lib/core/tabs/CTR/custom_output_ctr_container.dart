import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/RSA/custom_rsa_test_field.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CustomOutputCtrContainer extends StatelessWidget {
  late String headerText;
  late String hintText;
  late String inputTypeText;
  late String outputTypeText;
  late String buttonText;
  final Function()? Encrypt;
  TextEditingController? ciphertext;
  TextEditingController? secretKey;
  TextEditingController? decryptedText;

  CustomOutputCtrContainer({
    required this.ciphertext,
    required this.decryptedText,
    required this.secretKey,
    required this.Encrypt,
    required this.headerText,
    required this.hintText,
    required this.buttonText,
    required this.inputTypeText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 9,
        right: 9,
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
          SizedBox(height: 0.01),
          Text(
            inputTypeText,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          CustomRsaField(
            5,
            0.2,
            "Enter Encrypted Text to Decrypt",
            false,
            ciphertext,
          ),
          SizedBox(height: 0.005),
          Text(
            "Secret Key",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          CustomRsaField(1, 0.06, "Enter Secret Key", true, secretKey),
          SizedBox(height: 0.02),
          Text(
            "Decrypted Output",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          CustomRsaField(4, 0.16, "Decrypted Output", false, decryptedText),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Validation to check if ciphertext or secretKey are empty
                if (ciphertext?.text.isEmpty == true
                    ) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please fill in all fields."),
                      backgroundColor: Colors.red.shade400,
                    ),
                  );
                  return;
                }
                // Call Encrypt function if fields are not empty
                Encrypt?.call();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.primarySemiDarkColor,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 109),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
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
