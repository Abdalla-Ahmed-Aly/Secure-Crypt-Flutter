import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/Home/custom_container.dart';

class HomeTab extends StatelessWidget {
  static const String HomeRouteTab = "/hometab";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width; ///    412
    final height = MediaQuery.of(context).size.height; ///  917
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomContainer("SHA-1 Hash Function","SHA-1 (Secure Hash Algorithm 1) is a cryptographic hash function that converts data into a fixed 160-bit hash. It's primarily used for verifying data integrity. Though outdated for secure applications, it's still useful for educational purposes and understanding hash behavior.",1,callFunction),SizedBox(height: height * 0.02,),
          CustomContainer("RSA Algorithm","RSA is a widely-used public key encryption algorithm that ensures secure communication over the internet. It uses two keys public and private for encryption and decryption. In our implementation, key generation is supported by a linear congruential generator.",2,callFunction),SizedBox(height: height * 0.02,),
          CustomContainer("CTR Cipher Block","CTR (Counter) mode is a block cipher encryption technique that turns a block cipher into a stream cipher. It uses a counter value for each block, ensuring fast and parallel encryption. The key is generated using a linear congruential generator for enhanced randomness.",3,callFunction),SizedBox(height: height * 0.02,)
        ],
      ),
    );
  }
  static int callFunction(int index){

    return index;
  }
}
