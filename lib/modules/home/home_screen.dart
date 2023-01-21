import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/add_post/add_post_screen.dart';
import 'package:social_app/modules/notifications/notifications_screen.dart';
import 'package:social_app/modules/search/search_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import 'package:social_app/shared/styles/icons_broken.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getUserData();
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            var cubit = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(cubit.titles[cubit.currentIndex]),
                titleSpacing: 20.0,
                actions: [
                  IconButton(
                    onPressed: ()
                    {
                      navigateTo(context, NotificationsScreen());
                    },
                    icon: Icon(IconBroken.Notification),
                  ),
                  IconButton(
                    onPressed: ()
                    {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(IconBroken.Search),
                  ),
                ],
              ),
              body: cubit.screens[cubit.currentIndex],

              floatingActionButton:FloatingActionButton(
                onPressed: (){
                  navigateTo(context, AddPostScreen());
                },
                child: Icon(IconBroken.Upload),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeBNav(index);
                },
                currentIndex: cubit.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home),
                    label: 'Feeds',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat),
                    label: 'Chats',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.User),
                    label: 'Users',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Profile),
                    label: 'Profile',
                  ),
                ],
              ),
            );
          },
        );
      },

    );
  }
}
