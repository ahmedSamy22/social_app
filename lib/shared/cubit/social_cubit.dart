import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/messageModel.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/profile/profile_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    var test = CacheHelper.getData(key: 'uId');

    FirebaseFirestore.instance
        .collection('users')
        .doc(test)
        .get()
        .then((value) {
      print('hereeeeeeee ${value.data()}');
      userModel = UserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print('errrrrror is ${error.toString()}');

      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    ProfileScreen(),
  ];

  List<String> titles = [
    'Feeds',
    'Chats',
    'Users',
    'Profile',
  ];

  int currentIndex = 0;
  void changeBNav(index) {
    currentIndex = index;
    if (index == 1) getAllUsers();
    emit(SocialBNavState());
  }

  File? profileImage;
  var profilepicker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile =
        await profilepicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      emit(SocialGetProfileImageSuccessState());
    } else {
      print('no image selected');
      emit(SocialGetProfileImageErrorState());
    }
  }

  File? coverImage;
  var coverpicker = ImagePicker();

  Future getProfileCover() async {
    final pickedFile = await coverpicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      uploadProfileCover();
      emit(SocialGetProfileCoverSuccessState());
    } else {
      print('no image selected');
      emit(SocialGetProfileCoverErrorState());
    }
  }

  String? profileImageUrl;

  void uploadProfileImage() {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        updateUser(
          image: value,
        );
        emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }

  String? profileCoverUrl;
  void uploadProfileCover() {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileCoverUrl = value;
        updateUser(cover: value);

        emit(SocialUploadProfileCoverSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileCoverErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileCoverErrorState());
    });
  }

  void updateUser({
    String? name,
    String? phone,
    String? bio,
    String? cover,
    String? image,
  }) {
    emit(SocialUpdateUserLoadingState());

    UserModel model = UserModel(
      name: name ?? userModel?.name,
      email: userModel?.email,
      phone: phone ?? userModel?.phone,
      uId: userModel?.uId,
      bio: bio ?? userModel?.bio,
      cover: cover ?? userModel?.cover,
      image: image ?? userModel?.image,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateUserErrorState());
    });
  }

  File? postImage;
  var postImagePicker = ImagePicker();

  Future getPostImage() async {
    final pickedFile =
        await postImagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);

      emit(SocialGetPostImageSuccessState());
    } else {
      print('no image selected');
      emit(SocialGetPostImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    String? dateTime,
    String? text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);

        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    String? dateTime,
    String? text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel?.name,
      uId: userModel?.uId,
      image: userModel?.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    //emit(SocialGetPostsLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true,)
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        element.reference
            .collection('likes')
            .snapshots()
            .listen((eventLike) {
          element.reference
              .collection('comments')
              .snapshots()
              .listen((event) {
            likes.add(eventLike.docs.length);
            comments.add(event.docs.length);
            postsId.add(element.id);
            posts.add(PostModel.fromJson(element.data()));
            emit(SocialGetPostsSuccessState());
          });

        });
      }
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel?.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState());
    });
  }

  void commentPost(String postId, String comment) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel?.uId)
        .set({
      'comment': comment,
    }).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState());
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    emit(SocialGetAllUsersLoadingState());

    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel?.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        });

        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String? receiverId,
    required String? text,
    required String? dateTime,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: userModel?.uId,
      receiverId: receiverId,
      text: text,
      dateTime: dateTime,
    );

    // set chat for me
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    // set chat for receiver
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String? receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }
}
