import 'package:e_mart/consts/consts.dart';

import 'components/order_place_details.dart';
import 'components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({Key? key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: "Order Details".text.color(redColor).fontFamily(semibold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(color: redColor, title: "Placed order", icon: Icons.done, showDone: data['order_placed']),
              orderStatus(color: Colors.blue, title: "Confirmed", icon: Icons.thumb_up, showDone: data['order_confirmed']),
              orderStatus(color: Colors.yellow, title: "On Delivery", icon: Icons.car_crash, showDone: data['order_on_delivered']),
              orderStatus(color: Colors.purple, title: "Delivered", icon: Icons.done_all, showDone: data['order_delivered']),
              const Divider(),
              10.heightBox,
              orderPlaceDetails(
                d1: data['order_code'],
                d2: data['shipping_method'],
                title1: "Order Code",
                title2: "Shipping Method",
              ),
              // //  /
              orderPlaceDetails(
                d1: intl.DateFormat().add_yMd().format((data['order_date'].toDate())),
                d2: data['payment_method'],
                title1: "Order Date",
                title2: "Payment Method",
              ),
              // //  ////
              orderPlaceDetails(
                d1: "Unpaid",
                d2: "Order Placed",
                title1: "Payment Status",
                title2: "delivery Status",
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                            "${data['order_by_postalcode']}".text.make(),

                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              "${data['total_amount']}".text.make(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).box.outerShadowMd.white.make(),

              10.heightBox,
              const Divider(),
              "Ordered Product".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
              10.heightBox,
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(data['order'].length, (index) {
                  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                        title1: data['order'][index]['title'],
                        title2: data['order'][index]['tprice'],
                        d1: "${data['order'][index]['qty']}x",
                        d2: "Refundable",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: Color(data['order'][index]['color']),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                }
                ).toList(),
              ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
