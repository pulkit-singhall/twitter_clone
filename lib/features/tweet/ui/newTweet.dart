import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/theme/theme.dart';

class NewTweet extends ConsumerStatefulWidget {
  const NewTweet({super.key});

  @override
  ConsumerState<NewTweet> createState() => _TweetState();
}

class _TweetState extends ConsumerState<NewTweet> {
  TextEditingController tweet = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUserModel = ref.watch(currentUserModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Pallete.whiteColor,
            size: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: ElevatedButton(
              onPressed: () {
                // tweet
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Pallete.blueColor),
                elevation: MaterialStateProperty.all<double>(2),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
              ),
              child: const Text(
                'Tweet',
                style: TextStyle(color: Pallete.whiteColor, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: currentUserModel.when(data: (userModel){
        final imageUrl = userModel == null ? '' : userModel.profilePic;
        return Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    imageUrl,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: tweet,
                    minLines: 5,
                    maxLines: 10,
                  ),
                ),
              ],
            ),
          ],
        );
      }, error: (e,st){
        return Center(
          child: Text(e.toString()),
        );
      }, loading: (){
        return UICommon.reusableAppBar();
      }),
    );
  }
}
