import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/edit_profile/edit_profile.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icons_broken.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
        if (state is SocialSignOutSuccessState) {
          navigateAndFinish(context, LoginScreen());
          uId='';
        }
      },
      builder: (context, state) {

        var userModel=SocialCubit.get(context).userModel;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 240.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: 210.0,
                        width: double.infinity,
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            topLeft: Radius.circular(5.0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                                '${userModel?.cover}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 48.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 45.0,
                        backgroundImage: NetworkImage(
                            '${userModel?.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              Text('${userModel?.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 10.0,),
              Text('${userModel?.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('115',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(height: 10.0,),
                            Text('Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('246',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(height: 10.0,),
                            Text('Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('4k',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(height: 10.0,),
                            Text('Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('86',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(height: 10.0,),
                            Text('Followings',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: (){}, child: Text('Add photos')),
                  ),
                  SizedBox(width: 10.0,),
                  OutlinedButton(
                      onPressed: (){
                        navigateTo(context, EditProfileScreen());
                      }, child: Icon(IconBroken.Edit)),
                ],
              ),
              SizedBox(height: 10.0,),
              MaterialButton(onPressed: (){
                SocialCubit.get(context).logOut();
              },
                child: Text('Logout',style: TextStyle(color: Colors.white),),
              color: defaultColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
