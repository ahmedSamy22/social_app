import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icons_broken.dart';

class AddPostScreen extends StatelessWidget {
  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            actions: [
              TextButton(
                onPressed: () {
                  var now=DateTime.now();
                  if(SocialCubit.get(context).postImage == null)
                  {
                    SocialCubit.get(context).createPost(
                      text: textController.text,
                      dateTime: now.toString(),
                    );
                  }
                  else
                  {
                    SocialCubit.get(context).uploadPostImage(
                      text: textController.text,
                      dateTime: now.toString(),
                    );
                  }
                  if(state is SocialCreatePostSuccessState)
                    navigateAndFinish(context, FeedsScreen());
                },
                child: Text(
                  'POST',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: defaultColor),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
            title: 'Create Post',
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 10.0,),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${userModel?.image}'),
                      radius: 25.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        '${userModel?.name}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage !=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 210.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image:FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: CircleAvatar(
                          child: Icon(Icons.close, size: 20.0),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 10.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Add photos'),
                            ],
                          )),
                    ),
                    Expanded(
                        child: TextButton(onPressed: () {}, child: Text('# Tags'))),
                  ],
                ),

              ],
            ),
          ),
        );
      },

    );
  }
}
