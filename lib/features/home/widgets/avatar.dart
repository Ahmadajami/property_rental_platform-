
import 'package:airbnb/models/user_model/model.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.gender,
    required this.avatarUrl,
  });

  final Gender gender;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {

    final assets = gender == Gender.male
        ? 'assets/avatars/male.jpg'
        : 'assets/avatars/female.jpg';

    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: SizedBox(
        height: 60.0,
        width: 60.0,
        child: avatarUrl !=null
            ? Image.network(avatarUrl!)
            : Image.asset(assets),
      ),
    );
  }
}