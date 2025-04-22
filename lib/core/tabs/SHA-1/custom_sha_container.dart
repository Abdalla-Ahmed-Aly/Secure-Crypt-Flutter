import 'package:flutter/material.dart';
import 'package:secure_crypt/core/tabs/SHA-1/custom_test_field.dart';
import 'package:secure_crypt/features/Home/tabs/SHA-1/sha1_algorithms.dart';
import 'package:secure_crypt/utils/color_app.dart';

class CustomAlgoContainer extends StatefulWidget {
  late String headerText;
  late String hintText;
  late String secTextFieldHint;
  late String secTextFieldDescription;
  late String buttonText;
  late bool enabled;
  late double height;

  CustomAlgoContainer(
    this.headerText,
    this.hintText,
    this.secTextFieldDescription,
    this.buttonText,
    this.height,
  );

  CustomAlgoContainer.req({
    required this.headerText,
    required this.hintText,
    required this.enabled,
    required this.secTextFieldHint,
    required this.secTextFieldDescription,
    required this.buttonText,
    required this.height,
  });

  @override
  State<CustomAlgoContainer> createState() => _CustomAlgoContainerState();
}

class _CustomAlgoContainerState extends State<CustomAlgoContainer> {


  TextEditingController textEditingController = TextEditingController();
  TextEditingController hashController = TextEditingController();
  String hashedText = "Hash will appear here";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height * widget.height,
      padding: EdgeInsets.only(
        left: width * 0.05,
        right: width * 0.05,
        top: height * 0.02,
      ),
      decoration: BoxDecoration(
        color: ColorApp.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.headerText,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          Text(
            widget.hintText,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black45,
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(
            "Input Text",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(height: height * 0.005),
          CustomTestField.controller(
            textEditingController,
            5,
            0.2,
            "Enter text to Hash",
            false,true
          ),
          Text(
            widget.secTextFieldDescription,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          CustomTestField.controller(
            hashController,
            1,
            0.06,
            widget.secTextFieldHint,
            widget.enabled == true ? false : true,true
          ),
          SizedBox(height: height * 0.02),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // todo: here What you will generate
                if(widget.buttonText == "Generate Hash"){
                  String hash = Sha1_Algorithms.sha1_algorithm(
                    textEditingController.text,
                  );
                  hashController.text = hash;
                  setState(() {});
                }else{
                  String hash = Sha1_Algorithms.sha1_algorithm(
                    textEditingController.text,
                  );
                  if(hash == hashController.text){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green.shade500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        content: Row(
                          children: [
                            Icon(Icons.check_circle_outline, color: Colors.white),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Form submitted successfully!',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        content: Row(
                          children: [
                            Icon(Icons.error_outline, color: Colors.white),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Form is invalid',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                  setState(() {});
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shadowColor: Colors.redAccent.shade200,
                backgroundColor: ColorApp.primarySemiDarkColor,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                widget.buttonText,
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
