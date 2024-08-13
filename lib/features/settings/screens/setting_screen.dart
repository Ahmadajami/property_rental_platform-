
import 'package:airbnb/features/auth/controller/auth_controller.dart';
import 'package:airbnb/features/settings/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {


  final  List<String> title = ["profile", "setting", "Info","Logout"];
  final  List<String> desc = [
    "Edit profile",
    "Select theme and language",
    "General Information",
    "Log out of Application "
  ];
  final  List<IconData> con = [Icons.person, Icons.settings, Icons.info,Icons.logout];

  @override
  Widget build(BuildContext context) {
    final List<void Function()?> onPress=[(){},(){},(){},(){ref.read(authControllerProvider.notifier).logout();}];

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Profile & Setting",
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (ctx, index) {
                return SettingTile(
                    prefixIcon: con[index],
                    title:title[index],
                    desc: desc[index],
                  onPress: onPress[index],
                );
              },
              separatorBuilder: (ctx, index) {
                return const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Divider(height: 1.0, color: Colors.black),
                );
              },
              itemCount: title.length,
            ),
          ),


        ],
      ),



    );
  }
}
