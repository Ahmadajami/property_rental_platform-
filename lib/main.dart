

import 'package:airbnb/core/constants/pocketbase_constants.dart';
import 'package:airbnb/core/providers/pocketbase.dart';
import 'package:airbnb/core/providers/secure_sharedpref/secure_sharedpref.dart';
import 'package:airbnb/features/auth/controller/auth_controller.dart';
import 'package:airbnb/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocketbase/pocketbase.dart';



AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  final store = AsyncAuthStore(
    save: (String data) async => await storage.write(key: PocketBaseConstants.pocketBaseAuthStoreKey, value: data),
    initial: await storage.read(key: PocketBaseConstants.pocketBaseAuthStoreKey),
    clear: () async => await storage.delete(key: PocketBaseConstants.pocketBaseAuthStoreKey),
  );
  return runApp( ProviderScope(
      overrides: [
        secureStorageProvider.overrideWithValue(storage),
      authStoreProvider.overrideWithValue(store),
      ],
      child: const MyApp()
  ));
}




class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState createState() => _MyAppState();
}
class _MyAppState extends ConsumerState<MyApp> {


  @override
  Widget build(BuildContext context) {
    ref.read(secureStorageProvider);
    ref.read(authStoreProvider);
    ref.read(pocketBaseProvider);
    ref.read(authControllerProvider);
    final router =ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'AirbnbSyria',
      routerConfig: router,
      theme: oldTheme,
    );




  }
}


ThemeData oldTheme=ThemeData(

  scaffoldBackgroundColor:const Color.fromARGB(255, 237, 238, 238) ,
  colorScheme: const ColorScheme.light(
    primary: Colors.black,
    onPrimary: Colors.white,
    brightness: Brightness.light,



    /*brightness: Brightness.light,
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Colors.black,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    onBackground:Colors.white24 ,
    surface: Colors.white,
    onSurface: Colors.black,

*/
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
    textStyle: const TextStyle(color: Colors.white),
    backgroundColor: Colors.black,
    foregroundColor: Colors.white

  )),

  useMaterial3: true,
);

