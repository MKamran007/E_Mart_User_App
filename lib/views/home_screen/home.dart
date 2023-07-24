import 'package:e_mart/consts/consts.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../widgets_common/exit_dialog.dart';
import '../cart_screen/cart_screen.dart';
import '../categorie_screen/categorie_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'home_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var nabaarItem = [
      BottomNavigationBarItem(icon: Image.asset(icHome, width: 26,), label: home,),
      BottomNavigationBarItem(icon: Image.asset(icCategories, width: 26,), label: categories,),
      BottomNavigationBarItem(icon: Image.asset(icCart, width: 26,), label: cart,),
      BottomNavigationBarItem(icon: Image.asset(icProfile, width: 26,), label: account,),

    ];

    var navBody = [
      const HomeScreen(),
      const CategorieScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async{
        showDialog(
          barrierDismissible: false,
            context: context, builder: (context)=>exitDialogBox(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(()=> Expanded(child: navBody.elementAt(controller.currentNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(()=>
           BottomNavigationBar(
             currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
              backgroundColor: whiteColor,
              items: nabaarItem,
             onTap: (value){
               controller.currentNavIndex.value = value;
             },
          ),
        ),
      ),
    );
  }
}
