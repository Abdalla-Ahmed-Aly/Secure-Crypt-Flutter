import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/RSA/custom_input_rsa_container.dart';
import 'package:secure_crypt/core/tabs/RSA/custom_output_rsa_container.dart';
import 'package:secure_crypt/features/Home/tabs/RSA/rsa_algorithm.dart';
import 'package:secure_crypt/utils/color_app.dart';

class RsaTab extends StatefulWidget {
  @override
  State<RsaTab> createState() => _RsaTabState();
}

class _RsaTabState extends State<RsaTab> {
  late TextEditingController inputTextEncrypt;
  late TextEditingController outputTextEncrypt;
  late TextEditingController inputTextDecrypt;
  late TextEditingController outputTextDecrypt;

  late final publicKey;
  late final privateKey;

  @override
  void initState() {
    super.initState();
    inputTextEncrypt = TextEditingController();
    outputTextEncrypt = TextEditingController();
    inputTextDecrypt = TextEditingController();
    outputTextDecrypt = TextEditingController();

    final keys = rsa(); 
    publicKey = keys['public']!;
    privateKey = keys['private']!;
  }

  @override
  void dispose() {
    inputTextEncrypt.dispose();
    outputTextEncrypt.dispose();
    inputTextDecrypt.dispose();
    outputTextDecrypt.dispose();
    super.dispose();
  }

  void rsa_algorithEncrypt() {
    final message = inputTextEncrypt.text;
    final encrypted = encryptTextBase64(message, publicKey);
    setState(() {
      outputTextEncrypt.text = encrypted;
    });

    print("Original Message: $message");
    print("Encrypted (base64): $encrypted");
  }

  void rsa_algorithDecrypt() {
    if (
        inputTextDecrypt.text != outputTextEncrypt.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter valid ciphertext to decrypt."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final encryptedText = inputTextDecrypt.text;
    final decrypted = decryptTextBase64(encryptedText, privateKey);
    setState(() {
      outputTextDecrypt.text = decrypted;
    });

    print("Encrypted (base64): $encryptedText");
    print("Decrypted Message: $decrypted");
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "RSA Algorithm",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 28,
              color: ColorApp.primaryDarkColor,
            ),
          ),
          SizedBox(height: height * 0.02),

          CustomInputRsaContainer(
            onPressed: rsa_algorithEncrypt,
            inputText: inputTextEncrypt,
            outputText: outputTextEncrypt,
            headerText: "Input",
            hintText: "Enter plaintext in RSA",
            inputTypeText: "PlainText",
            buttonText: "Encrypt",
            outputTypeText: "Encrypted Output",
          ),

          SizedBox(height: height * 0.02),

          CustomOutputRsaContainer(
            onPressed: rsa_algorithDecrypt,
            inputText: inputTextDecrypt,
            outputText: outputTextDecrypt,
            headerText: "Output",
            hintText: "View and decrypt ciphertext using RSA",
            buttonText: "Decrypt",
            inputTypeText: "Cipher Text",
          ),
        ],
      ),
    );
  }
}
