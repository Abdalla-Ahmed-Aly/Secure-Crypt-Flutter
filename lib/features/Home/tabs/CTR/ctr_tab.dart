import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/CTR/custom_input_ctr_container.dart';
import 'package:secure_crypt/core/tabs/CTR/custom_output_ctr_container.dart';
import 'package:secure_crypt/features/Home/tabs/CTR/ctr_algorithm.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CtrTab extends StatefulWidget {
  const CtrTab({super.key});

  @override
  State<CtrTab> createState() => _CtrTabState();
}

class _CtrTabState extends State<CtrTab> {
  final TextEditingController plaintext = TextEditingController();
  final TextEditingController secretKey = TextEditingController();

  @override
  void dispose() {
    plaintext.dispose();
    secretKey.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CtrAlgorithim();
    // CtrDecryption();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "CTR Mode",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 28,
              color: ColorApp.primaryDarkColor,
            ),
          ),
          SizedBox(height: height * 0.02),
          CustomInputCtrContainer(
            plaintext: plaintext,
            secretKey: secretKey,
            headerText: "Encrypt CTR",
            hintText: "Use secret key and message to encrypt",
            inputTypeText: "Input",
            outputTypeText: "Output",
            buttonText: "Start Encrypt",
          ),
          SizedBox(height: height * 0.02),
          CustomOutputCtrContainer(
            headerText: "Output",
            hintText: "View and decrypt ciphertext using CTR mode",
            buttonText: "Decrypt",
            inputTypeText: "Ciphertext",
          ),
        ],
      ),
    );
  }
}
