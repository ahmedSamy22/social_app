import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/messageModel.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icons_broken.dart';

class ChatDetails extends StatelessWidget {
  
  UserModel? userModel;
  ChatDetails({this.userModel});
  
  var messageController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Builder(
      builder:(context) {

        SocialCubit.get(context).getMessages(receiverId: userModel?.uId);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userModel!.image!),
                      radius: 20.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      userModel!.name!,
                    ),
                  ],
                ),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              var message=SocialCubit.get(context).messages[index];
                              if(SocialCubit.get(context).userModel?.uId == message.senderId)
                                return buildMyMessage(message);
                              return buildReceiverMessage(message);
                            },
                            separatorBuilder: (context, index) => SizedBox(height: 10.0,),
                            itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your message ...',

                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                SocialCubit.get(context).sendMessage(
                                  receiverId: userModel?.uId,
                                  text: messageController.text,
                                  dateTime: DateTime.now().toString(),
                                );
                                messageController.text='';
                              },
                              icon: Icon(
                                  IconBroken.Send),
                              color: defaultColor,
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

            );
          },
        );
      },

    );
  }


  Widget buildReceiverMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
      decoration:  BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          )
      ),
      child: Text(model.text!),
    ),
  );
  Widget buildMyMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
      decoration:  BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          )
      ),
      child: Text(model.text!),
    ),
  );

}
