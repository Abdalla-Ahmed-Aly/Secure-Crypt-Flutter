import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/RSA/custom_rsa_test_field.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CustomKeyContainer extends StatelessWidget {
  const CustomKeyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;

    return Container(
      // width: width,
      // // height: height* 0.55, // Use for height
      // height: 310,
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), // Use for border radius
        color: ColorApp.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Generate RSA keys",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20, // Use for font size
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Public Key",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16, // Use for font size
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          CustomRsaField(1, 0.06, "Public Key value", true, null),
          SizedBox(height: 10),
          Text(
            "Private Key",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16, // Use for font size
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          CustomRsaField(1, 0.06, "Private Key value", true, null),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: ColorApp.primarySemiDarkColor,
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 85),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Generate Key",
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
