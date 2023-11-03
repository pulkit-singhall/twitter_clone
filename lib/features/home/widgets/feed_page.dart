import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  @override
  Widget build(BuildContext context) {
    // tweet list
    final tweetModelList = ref.watch(tweetListFutureProvider);

    return tweetModelList.when(data: (tweetModelList) {
      return ListView.builder(
          itemCount: tweetModelList.length,
          itemBuilder: (context, index) {
            final tweetModel = tweetModelList[index];
            return Text(tweetModel.text);
          });
    }, error: (e, st) {
      return Center(
        child: Text(e.toString()),
      );
    }, loading: () {
      return UICommon.progressIndicator();
    });
  }
}
