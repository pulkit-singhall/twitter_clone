import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/models/user_model.dart';

// home controller provider
final homeControllerProvider = StateNotifierProvider<HomeController,bool>((ref) {
  final userApi = ref.watch(userApiProvider);
  return HomeController(userApi: userApi);
});

// future provider for searching a user by name
final userListBySearchProvider = FutureProvider.family((ref, String name) {
  final homeController = ref.watch(homeControllerProvider.notifier);
  return homeController.getUsersByName(name);
});

// home controller class
class HomeController extends StateNotifier<bool>{
  UserAPI userApi;
  HomeController({required this.userApi}) : super(false);

  // get all the users model from database
  Future<List<UserModel>> getAllUsers() async {
    final userDocumentsList = await userApi.getAllUsers();
    List<UserModel> allUsersList = [];
    for(var userDocument in userDocumentsList){
      allUsersList.add(UserModel.fromMap(userDocument.data));
    }
    return allUsersList;
  }

  // get all users by searching their name
  Future<List<UserModel>> getUsersByName(String name) async {
      final userDocuments = await userApi.getUsersByName(name);
      List<UserModel> usersBySearch = [];
      for(var userDocument in userDocuments){
        usersBySearch.add(UserModel.fromMap(userDocument.data));
      }
      return usersBySearch;
  }

}