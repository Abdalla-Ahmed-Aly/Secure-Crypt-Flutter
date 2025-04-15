import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/SHA-1/custom_sha_container.dart';
import 'package:secure_crypt/utils/color_app.dart';


class Sha1Tab extends StatelessWidget {
  static const String shaRouteName = "/sha";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("SHA-1 Hash",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 28,color: ColorApp.primaryDarkColor),),
          SizedBox(height: height * 0.02,),
          CustomAlgoContainer("Generate Hash",
              "Create SHA-1 hash from input text",
              "Generated SHA-1 Hash",
              "Generate Hash",
              0.55
          ),
          SizedBox(height: height * 0.02,),
          CustomAlgoContainer(
            "Verify Hash",
            "Verify if a hash matches the input text",
            "SHA-1 Hash to Verify",
            "Verify Hash",
            0.55
          ),
        ],
      )
    );
  }
}
