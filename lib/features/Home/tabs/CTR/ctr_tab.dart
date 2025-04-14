import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/CTR/custom_input_ctr_container.dart';
import 'package:secure_crypt/core/tabs/CTR/custom_output_ctr_container.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CtrTab extends StatelessWidget {
  const CtrTab({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width; ///        412
    final height = MediaQuery.of(context).size.height; ///      917
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("CTR Mode",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 28,color: ColorApp.primaryDarkColor),),
          SizedBox(height: height * 0.02,),

          CustomInputCtrContainer(
              headerText: "Input",
              hintText: "Enter plaintext and generate encryption key",
              buttonText: "Generate Key",
              inputTypeText: "Plaintext",
              outputTypeText: ""
          ),

          SizedBox(height: height * 0.02,),

          CustomOutputCtrContainer(
              headerText: "Output",
              hintText: "View and decrypt ciphertext using CTR mode",
              buttonText: "Decrypt",
              inputTypeText: "Ciphertext")
        ],
      ),
    );
  }
}
