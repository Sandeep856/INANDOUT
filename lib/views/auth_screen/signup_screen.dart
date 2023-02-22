import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/material.dart';
import '../../consts/consts.dart';
import '../../consts/lists.dart';
import '../../widgets_common/applogo_widgets.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
 bool _registerFormLoading = false;

  void _submit() async {
    String? _createAccountFeedback = await createAccount();
    setState(() {
      _registerFormLoading = true;
    });
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);

      setState(() {
        _registerFormLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }
  Future<String?> createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close Dialog Box'),
              ),
            ],
          );
        });
  }
  String _name="";
  String _registerEmail = '';
  String _registerPassword = '';

   late FocusNode _passwordFocusNode;
  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Join the $appname".text.fontFamily(bold).white.size(18).make(),
          15.heightBox,
          Column(
            children: [
              customTextField(hint: nameHint, title: name,
              onChanged:(value){
                _name=value;
              },
              onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
              textInputAction: TextInputAction.next,
              isPasswordField: false,),


              customTextField(hint: emailHint, title: email,
               onChanged: (value) {
                      _registerEmail = value;
                    },
              onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
              textInputAction: TextInputAction.next,
              isPasswordField: false,),


              customTextField(hint: passwordHint, 
              title: password,
              onChanged: (value) {
                      _registerPassword = value;
                    },
              onSubmitted: (value) {
                      _submit();
                    },
                textInputAction: TextInputAction.next,
              isPasswordField: true,),


              // customTextField(hint: passwordHint, 
              // title: retypePassword,onChanged:(value){},
              // onSubmitted: (value){},
              // textInputAction: TextInputAction.done,
              // isPasswordField: true,),


              Align(
                alignment: Alignment.centerRight,
                child:
                    TextButton(onPressed: () {}, child: forgetPass.text.make()),
              ),
              Row(
                children: [
                  Checkbox(
                      activeColor: redColor,
                      checkColor: redColor,
                      value: isCheck,
                      onChanged: (newValue) {
                        setState(() {
                          isCheck = newValue;
                        });
                      }),
                  10.heightBox,
                  Expanded(
                      child: RichText(
                          text: const TextSpan(children: [
                    TextSpan(
                        text: "I agree to the ",
                        style: TextStyle(
                          fontFamily: bold,
                          color: fontGrey,
                        )),
                    TextSpan(
                        text: termAndCond,
                        style: TextStyle(
                          fontFamily: bold,
                          color: redColor,
                        )),
                    TextSpan(
                        text: " &",
                        style: TextStyle(
                          fontFamily: bold,
                          color: fontGrey,
                        )),
                    TextSpan(
                        text: privacyPolicy,
                        style: TextStyle(
                          fontFamily: bold,
                          color: redColor,
                        )),
                  ])))
                ],
              ),
              5.heightBox,
              ourButton(
                      color: isCheck == true ? redColor : lightGrey,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () {
                        _submit();
                      })
                  .box
                  .width(context.screenWidth - 50)
                  .make(),
              10.heightBox,
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: alreadyHaveAccount,
                        style: TextStyle(fontFamily: bold, color: fontGrey)),
                    TextSpan(
                        text: login,
                        style: TextStyle(fontFamily: bold, color: redColor))
                  ],
                ),
              ).onTap(() {
                Get.back();
              }),
            ],
          )
              .box
              .white
              .rounded
              .padding(const EdgeInsets.all(16))
              .width(context.screenWidth - 70)
              .shadowSm
              .make(),
        ],
      )),
    ));
  }
}
