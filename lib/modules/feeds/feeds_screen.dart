import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icons_broken.dart';

class FeedsScreen extends StatelessWidget {
  var commentController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          //
          condition: SocialCubit.get(context).posts.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                // Card(
                //   elevation: 5.0,
                //   clipBehavior: Clip.antiAliasWithSaveLayer,
                //   margin: EdgeInsets.all(8.0),
                //   child: Stack(
                //     alignment: AlignmentDirectional.bottomEnd,
                //     children: [
                //       Image(
                //         image: NetworkImage(
                //             'https://img.freepik.com/free-photo/glamorous-dark-haired-woman-cute-attire-making-selfie-street-with-yellow-bicycle-background-outdoor-photo-girl-trendy-outfit-standing-near-laptop_197531-25501.jpg?w=740&t=st=1673797387~exp=1673797987~hmac=680905de8d672c18ac036a930196cef2ec7b6bc9c8ce98a02e6331772923432e'),
                //         height: 200.0,
                //         width: double.infinity,
                //         fit: BoxFit.cover,
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(10.0),
                //         child: Text(
                //           'Keep in touch with friends',
                //           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                //                 color: Colors.white,
                //               ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(context,SocialCubit.get(context).posts[index],SocialCubit.get(context).userModel!,index),
                  separatorBuilder: (context, index) => SizedBox(height: 10.0,),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(height: 10.0,),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },

    );
  }

  Widget buildPostItem(context,PostModel model,UserModel userModel,index)
  {
    return Card(
      elevation: 5.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      '${model.image}'),
                  radius: 25.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16.0,
                          )
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style:
                        Theme.of(context).textTheme.caption?.copyWith(
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: Icon(IconBroken.More_Circle)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                color: Colors.grey[300],
                height: 1.0,
                width: double.infinity,
              ),
            ),
            Text(
              '${model.text}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10.0),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 3.0,),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               onPressed: () {},
            //               child: Text(
            //                 '#Software',
            //                 style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.blue),
            //               ),
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 3.0,),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               onPressed: () {},
            //               child: Text(
            //                 '#mobile_developer',
            //                 style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.blue),
            //               ),
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 3.0,),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               onPressed: () {},
            //               child: Text(
            //                 '#Software',
            //                 style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.blue),
            //               ),
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 3.0,),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               onPressed: () {},
            //               child: Text(
            //                 '#Flutter',
            //                 style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.blue),
            //               ),
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 3.0,),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               onPressed: () {},
            //               child: Text(
            //                 '#mobile_development',
            //                 style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.blue),
            //               ),
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if(model.postImage !="")
              Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Container(
                height: 200.0,
                width: double.infinity,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(
                    5.0,
                  )),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${model.postImage}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              children:
              [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children:
                        [
                          Icon(IconBroken.Heart,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5.0,),
                          Text('${SocialCubit.get(context).likes[index]}',

                            style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                        [
                          Icon(IconBroken.Chat,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 5.0,),
                          Text('${SocialCubit.get(context).comments[index]} comments',
                               // ${SocialCubit.get(context).comments[index]}
                            style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                color: Colors.grey[300],
                height: 1.0,
                width: double.infinity,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      showDialog(context: context,
                        builder: (context) =>AlertDialog(
                            title: Text('Comment'),
                          content: TextFormField(
                              controller: commentController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(IconBroken.Edit),

                            ),
                          ),
                          actions: [
                            IconButton(onPressed: (){
                              SocialCubit.get(context).commentPost(SocialCubit.get(context).postsId[index], commentController.text);

                              Navigator.pop(context);
                            }, icon: Icon(IconBroken.Send),color: defaultColor,),
                          ],

                        ),);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                          '${userModel.image}',
                          ),
                          radius: 25.0,
                        ),
                        SizedBox(width: 10.0,),
                        Text('Write a comment ...',
                          style:Theme.of(context).textTheme.caption,
                        ),

                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                  },
                  child: Row(
                    children:
                    [
                      Icon(IconBroken.Heart,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5.0,),
                      Text('Like',
                        style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                ),
                SizedBox(width: 10.0,),
                InkWell(
                  onTap: (){},
                  child: Row(
                    children:
                    [
                      Icon(IconBroken.Upload,
                        color: Colors.green,
                      ),
                      SizedBox(width: 5.0,),
                      Text('Share',
                        style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
