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
  final TextEditingController plainDecyrpttext = TextEditingController();
  final TextEditingController secretKey = TextEditingController();
  final TextEditingController encryptedText = TextEditingController();
  final TextEditingController decryptedText = TextEditingController();

  Map<String, String>? result;
  void handleKey() {
    setState(() {
      result = CtrAlgorithim(plaintext.text);
      secretKey.text = result!['key']!;
    });
  }

  void handleEncrypt() {
    encryptedText.text = result!['encrypted']!;
  }

  void handleDecrypt() {
    final result = decryptCtr(
      plainDecyrpttext.text,
      secretKey.text,
      '1234567890abcdef',
    );
    setState(() {
      decryptedText.text = result;
    });
  }

  @override
  void dispose() {
    plaintext.dispose();
    secretKey.dispose();
    encryptedText.dispose();
    decryptedText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            GenrateKey: () {
              handleKey();
            },
            ciphertext: encryptedText,
            Encrypt: handleEncrypt,

            plaintext: plaintext,
            secretKey: secretKey,
            headerText: "Encrypt CTR",
            hintText: "Use secret key and message to encrypt",
            inputTypeText: "Input",
            outputTypeText: "Encrypted Text",
            buttonText: "Generate",
          ),
          SizedBox(height: height * 0.02),
          CustomOutputCtrContainer(
            Encrypt: handleDecrypt,
            headerText: "Decrypt",
            hintText: "Decrypt ciphertext using CTR mode",
            buttonText: "Decrypt",
            inputTypeText: "Decrypted Text",
            ciphertext: plainDecyrpttext,
            decryptedText: decryptedText,
            secretKey: secretKey,
          ),
        ],
      ),
    );
  }
}
