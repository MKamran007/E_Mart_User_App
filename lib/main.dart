import 'package:e_mart/views/splash_screen/splash_screen.dart';
import 'consts/consts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E Mart App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme:  const AppBarTheme(
            iconTheme: IconThemeData(
              color: darkFontGrey,
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
        ),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}

