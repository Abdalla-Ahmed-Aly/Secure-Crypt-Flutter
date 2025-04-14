import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/RSA/custom_input_rsa_container.dart';
import 'package:secure_crypt/core/tabs/RSA/custom_key_container.dart';
import 'package:secure_crypt/core/tabs/RSA/custom_output_rsa_container.dart';
import 'package:secure_crypt/utils/color_app.dart';

class RsaTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("RSA Algorithm",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 28,color: ColorApp.primaryDarkColor),),
          SizedBox(height: height * 0.02,),
          CustomKeyContainer(),
          SizedBox(height: height * 0.02,),
          CustomInputRsaContainer(
              headerText: "Input",
              hintText: "Enter plaintext in RSA",
              inputTypeText: "PlainText",
              buttonText: "Encrypt",
              outputTypeText: "Encrypted Output",
              ),
          SizedBox(height: height * 0.02,),
          CustomOutputRsaContainer(
              headerText: "Output",
              hintText: "View and decrypt ciphertext using RSA",
              buttonText: "Decrypt",
              inputTypeText: "Cipher Text",
              )
        ],
      ),
    );
  }
}
