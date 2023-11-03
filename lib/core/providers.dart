// this is for all global providers

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/constants.dart';

// global client provider
final appWriteClientProvider = Provider((ref) {
  Client appWriteClient = Client();
  appWriteClient = Client()
      .setEndpoint(AppWriteConstants.endPoint)
      .setProject(AppWriteConstants.projectId)
      .setSelfSigned(status: true);
  return appWriteClient;
});

// global account provider
final appWriteAccountProvider = Provider((ref) {
  final client = ref.watch(appWriteClientProvider);
  Account appWriteAccount = Account(client);
  return appWriteAccount;
});

// global database provider
final appWriteDatabaseProvider = Provider((ref) {
  final client = ref.watch(appWriteClientProvider);
  Databases appWriteDatabase = Databases(client);
  return appWriteDatabase;
});

// global storage provider
final appwriteStorageProvider = Provider((ref) {
  final appwriteClient = ref.watch(appWriteClientProvider);
  return Storage(appwriteClient);
});