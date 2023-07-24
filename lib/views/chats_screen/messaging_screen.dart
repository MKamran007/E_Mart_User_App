import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/views/chats_screen/chat_screen.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getAllMessages(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            }else if(snapshot.data!.docs.isEmpty){
              return Center(
                child: "No Messages".text.color(darkFontGrey).makeCentered(),
              );
            }else{
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder:(BuildContext context, int index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: ListTile(
                              onTap: (){
                                Get.to(()=>ChatScreen(),
                                arguments: [
                                     data[index]['friend_name'],
                                     data[index]['toId'],
                                ]
                                );
                              },
                              leading: const CircleAvatar(
                                backgroundColor: redColor,
                                child: Icon(Icons.person,color: whiteColor,),
                              ),
                              title: "${data[index]['friend_name']}".text.fontFamily(semibold).size(16).make(),
                              subtitle: "${data[index]['last_msg']}".text.make(),
                            ),
                          ),
                        );
                      }
                  )),
                ],
              );
            }
          }

      ),
    );
  }
}
