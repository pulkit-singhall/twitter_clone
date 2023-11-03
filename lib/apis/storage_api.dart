import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/core.dart';

// global storage api provider
final storageApiProvider = Provider((ref) {
  final appwriteStorage = ref.watch(appwriteStorageProvider);
  return StorageAPI(storage: appwriteStorage);
});

abstract class IStorageAPI{

}

class StorageAPI implements IStorageAPI{
  final Storage storage;

  StorageAPI({required this.storage});


}