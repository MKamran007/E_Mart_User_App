import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controllers/product_controller.dart';
import 'package:e_mart/widgets_common/bg_widget.dart';

import 'categories_details.dart';

class CategorieScreen extends StatelessWidget {
  const CategorieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
      Scaffold(
        appBar: AppBar(
          title: categories.text.white.fontFamily(semibold).make(),
        ),
        body: Container(
       padding: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 3,crossAxisSpacing: 8,mainAxisExtent: 200),
              itemBuilder: (context, index){
                return Column(
                  children: [
                    Image.asset(categoryImages[index],height: 120,width: 200, fit: BoxFit.cover,),
                    10.heightBox,
                    categoriesList[index].text.align(TextAlign.center).color(darkFontGrey).make(),
                  ],
                ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
                 controller.getSubCategories(categoriesList[index]);
                  Get.to(()=>CategoriesDetails(title: categoriesList[index]));
                });
              }
          ),
        ),
      ),
    );
  }
}
