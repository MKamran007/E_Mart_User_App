import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/views/auth_screens/login_screen.dart';
import 'package:e_mart/views/home_screen/home.dart';
import 'package:e_mart/widgets_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  changeScreen(){
    Future.delayed(const Duration(seconds: 3), (){
      auth.authStateChanges().listen((User? user){
        if(user == null && mounted){
          Get.to(()=>const LoginScreen());
        }else{
          Get.to(()=>const Home());
        }
      });
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
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(alignment: Alignment.topLeft,child: Image.asset(icSplashBg, width: 300,)),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.white.size(22).fontFamily(bold).make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
