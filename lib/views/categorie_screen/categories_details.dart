import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/widgets_common/bg_widget.dart';

import '../../controllers/product_controller.dart';
import '../../services/firestore_services.dart';
import 'item_details.dart';
class CategoriesDetails extends StatefulWidget {
  final String? title;
  const CategoriesDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategery(widget.title);
  }
  switchCategery(title){
    if(controller.subcat.contains(title)){
      productMethod = FireStoreServices.getSubCategoryProducts(title);
    }else{
      productMethod = FireStoreServices.getProduct(title);
    }
  }

  var controller = Get.find<ProductController>();
  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        appBar: AppBar(
          title: widget.title!.text.white.fontFamily(semibold).make(),
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(controller.subcat.length, (index) =>
                    "${controller.subcat[index]}".text.size(12).fontFamily(semibold)
                        .color(darkFontGrey).makeCentered().box
                        .white.size(120, 60).rounded
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .make().onTap(() { 
                          switchCategery("${controller.subcat[index]}");
                          setState(() {});
                    })),
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream: productMethod,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData){
                   return const Expanded(
                     child: Center(
                       child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),),
                     ),
                   );
                  }else if(snapshot.data!.docs.isEmpty){
                    return Expanded(
                      child: Center(
                        child: "Not products found".text.color(darkFontGrey).make(),
                      ),
                    );
                  }else{
                    var data= snapshot.data!.docs;
                    return Expanded(
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: data.length,
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 250, crossAxisSpacing: 8, mainAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(data[index]['p_image'][0], width: 200,height: 150,fit: BoxFit.cover,),
                                      10.heightBox,
                                      "${data[index]['p_name']}".text.fontFamily(semibold).color(redColor).make(),
                                      10.heightBox,
                                      "${data[index]['p_price']}".numCurrency.text.color(darkFontGrey).fontFamily(bold).size(16).make(),
                                    ],
                                  ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4))
                                      .roundedSM.outerShadowSm.padding(const EdgeInsets.all(12)).make().onTap(() {
                                        controller.checkIfFav(data[index]);
                                    Get.to(()=> ItemDetails(title: "${data[index]['p_name']}",data: data[index]));
                                  });
                                }
                            ));
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}
