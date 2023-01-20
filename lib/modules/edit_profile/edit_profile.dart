import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icons_broken.dart';
import 'dart:io';

class EditProfileScreen extends StatelessWidget {

  dynamic nameController= TextEditingController();
  dynamic bioController= TextEditingController();
  dynamic phoneController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text=userModel?.name;
        bioController.text=userModel?.bio;
        phoneController.text=userModel?.phone;


        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            TextButton(
              onPressed: () {
                SocialCubit.get(context)
                    .updateUser(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                );

              },
              child: Text('UPDATE',
              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: defaultColor),),
            ),
            SizedBox(
              width: 10.0,
            ),
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUpdateUserLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialUpdateUserLoadingState)
                    SizedBox(height: 20.0,),

                  Container(
                    height: 240.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 210.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5.0),
                                    topLeft: Radius.circular(5.0),
                                  ),
                                  image: DecorationImage(
                                    image:coverImage == null? NetworkImage('${userModel?.cover}') : FileImage(coverImage) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileCover();
                                },
                                icon: CircleAvatar(
                                  child: Icon(IconBroken.Camera, size: 20.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 48.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 45.0,
                                backgroundImage: profileImage ==null?  NetworkImage('${userModel?.image}') :FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                child: Icon(IconBroken.Camera, size: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  defaultFormField(
                      controller: nameController,
                      keyboardTybe: TextInputType.name,
                      prefixIcon: IconBroken.Profile,
                      label: 'Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name can\'t be empty';
                        }
                        return null;
                      }),
                  SizedBox(height: 20.0,),
                  defaultFormField(
                      controller: bioController,
                      keyboardTybe: TextInputType.text,
                      prefixIcon: IconBroken.Info_Circle,
                      label: 'Bio',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bio can\'t be empty';
                        }
                        return null;
                      }),
                  SizedBox(height: 20.0,),
                  defaultFormField(
                      controller: phoneController,
                      keyboardTybe: TextInputType.phone,
                      prefixIcon: IconBroken.Call,
                      label: 'Phone Number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone Number can\'t be empty';
                        }
                        return null;
                      }),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
