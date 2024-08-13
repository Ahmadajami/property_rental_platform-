

import 'package:airbnb/core/constants/pocketbase_constants.dart';
import 'package:airbnb/core/providers/secure_sharedpref/secure_sharedpref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';


final pocketBaseProvider = Provider((ref){
  final store= ref.watch(authStoreProvider);
  final pb = PocketBase(PocketBaseConstants.apiUrl,authStore:store);
  return  pb;
}
);

