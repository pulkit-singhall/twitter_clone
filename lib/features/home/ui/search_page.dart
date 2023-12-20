import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/home/controller/home_controller.dart';
import 'package:twitter_clone/features/home/widgets/searchUser_tile.dart';
import 'package:twitter_clone/theme/pallete.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  // search controller
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // list of users by search
    final usersListBySearch =
        ref.watch(userListBySearchProvider(searchController.toString()));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        centerTitle: true,
        title: Container(
          height: 55,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Pallete.searchBarColor,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                maxLines: 1,
                minLines: 1,
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  hintText: "Search Twitter",
                  hintStyle: TextStyle(
                    color: Pallete.greyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: usersListBySearch.when(data: (userListBySearch){
        return ListView.builder(
          itemCount: userListBySearch.length,
            itemBuilder: (context, index){
              final user = userListBySearch[index];
              return SearchTile(user: user);
            });
      }, error: (e,st){
        return Center(
          child: Text(e.toString()),
        );
      }, loading: (){
        return UICommon.progressIndicator();
      }),
    );
  }
}
