import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key});

  @override
  ConsumerState<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  @override
  Widget build(BuildContext context) {

    final currentUserModel = ref.watch(currentUserModelProvider);

    Widget userProfile = currentUserModel.when(data: (userModel){
      if(userModel != null){
        final profilePic = userModel.profilePic;
        return Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage(profilePic),
          ),
        );
      }
      else{
        return UICommon.progressIndicator();
      }
    }, error: (e,st){
      return Center(
        child: Text(e.toString()),
      );
    }, loading: (){
      return UICommon.progressIndicator();
    });

    return userProfile;
  }
}
