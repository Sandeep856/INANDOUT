// ignore_for_file: use_build_context_synchronously
import 'package:food/consts/consts.dart';
import 'package:food/services/auth.dart';
import 'package:food/views/auth_screen/signup_screen.dart';
import 'package:food/views/home_screen/home_screen.dart';
import 'package:food/widgets_common/applogo_widgets.dart';
import 'package:food/widgets_common/bg_widget.dart';
import 'package:food/widgets_common/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../consts/lists.dart';
import '../../widgets_common/our_button.dart';

class LoginScreen extends StatefulWidget {
 const LoginScreen({Key? key, required this.auth }):super(key:key);
final AuthBase auth;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  

  Future<void> _signinWithgoogle() async
  {
    try{
      await widget.auth.signInWithGoogle();
     
    }
    catch(e)
    {
      print(e.toString());
    }
  }
  void _Login() async {
    String? _userLoggedIn = await LoginState();
    if (_userLoggedIn != null) {
      _alertDialogBuilder(_userLoggedIn);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }
  late String _Email,_Password;
  Future<String?> LoginState() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _Email, password: _Password);
      return null;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that Email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong Password';
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
            title: const Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text('Close Dialog Box'),
              ),
            ],
          );
        });
  }
  late FocusNode _passwordFocusNode;
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
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
          "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
          15.heightBox,
          Column(
            children: [
              customTextField(
              hint: emailHint, 
              title: email,
              onChanged: (value)
              {
                  _Email=value;
              },
              onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
              isPasswordField: false,
                    textInputAction: TextInputAction.next,
              ),
              
              customTextField(hint: passwordHint, 
              title: password,
              onChanged: (value)
              {
                  _Password=value;
              },
               onSubmitted: (value) {},
                    textInputAction: TextInputAction.done,
                    isPasswordField: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child:
                    TextButton(onPressed: () {}, child: forgetPass.text.make()),
              ),
              5.heightBox,
              ourButton(
                  color: redColor,
                  title: login,
                  textColor: whiteColor,
                  onPress: () {
                      _Login();
                  }).box.width(context.screenWidth - 50).make(),
              5.heightBox,
              createNewAccount.text.color(fontGrey).make(),
              5.heightBox,
              ourButton(
                  color: lightGolden,
                  title: signup,
                  textColor: redColor,
                  onPress: () {
                    Get.to(() => const SignupScreen());
                  }).box.width(context.screenWidth - 50).make(),
              10.heightBox,
              loginWith.text.color(fontGrey).make(),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                    (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: lightGolden,
                          radius: 25,
                          child: Image.asset(socialIconList[index], width: 30),
                        ))),
              ),
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
