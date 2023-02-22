import 'package:firebase_core/firebase_core.dart';
import 'package:food/consts/consts.dart';
import 'package:food/services/auth.dart';
import 'package:food/views/Landing_page.dart';
import 'package:food/widgets_common/applogo_widgets.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => LandingPage(auth: Auth(),));
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreen,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg, width: 300),
            ),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            Spacer(),
            credits.text.fontFamily(semibold).make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
