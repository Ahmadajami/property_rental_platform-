import 'dart:developer';
import 'package:airbnb/common/Loading.dart';
import 'package:airbnb/features/auth/controller/auth_controller.dart';
import 'package:airbnb/features/home/widgets/avatar.dart';
import 'package:airbnb/features/home/widgets/house_card.dart';
import 'package:airbnb/features/property/controller/property_controller.dart';
import 'package:airbnb/models/user_model/model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
class HomeScreen extends ConsumerStatefulWidget {
  static String get homePath => '/home';
  static String get homeName => 'home';
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    final user = ref.read(authControllerProvider.notifier).userModel!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfoRow(user),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildDreamHomeSection(),
            ),
          _buildNewAddedSection(context),
            Flexible(
              child: ref.watch(latestProvider).when(
                  data: (data) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(right: 4.0),
                      physics: BouncingScrollPhysics()
                      ,///const PageScrollPhysics(),
                      itemCount: data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) =>
                          HouseCard(prop: data[index]),
                    ),
                  ),
                  error: (error, stackTrace) => const Text("error"),
                  loading: () => const Loading()),
            ),
          ],),
      ),
    );

    /*return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User information row
            _buildUserInfoRow(user),

            const SizedBox(height: 20.0), // Spacing

            // Find Your Dream Home section
            _buildDreamHomeSection(),

            const SizedBox(height: 40.0), // Spacing

            // New Added section with See All button
            _buildNewAddedSection(context),

            const SizedBox(height: 20.0), // Spacing

            // Horizontal list of HouseCard widgets

            Expanded(
              child: ref.watch(latestProvider).when(
                  data: (data) => ListView.builder(
                    physics: const PageScrollPhysics(),
                    itemCount: data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) =>
                        HouseCard(prop: data[index]),
                  ),
                  error: (error, stackTrace) {
                    log(error.toString());
                    return const Text("error");
                  },
                  loading: () => const Expanded(child: Loading())),
            ),
          ],
        ),
      ),
    );*/
  }

// Helper methods for building reusable sections
  Row _buildUserInfoRow(UserModel user) {
    return Row(
      children: [
        Avatar(avatarUrl: user.avtarUrl, gender: user.gender),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: [
              Text(user.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      letterSpacing: 1.5)),
              const Text(
                "Location",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDreamHomeSection() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "Find Your\nDream Home",
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 50.0,
          height: 0.8,
          fontWeight: FontWeight.bold,
        ),
        softWrap: true,
      ),
    );
  }

  Row _buildNewAddedSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "New Added",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        TextButton(
          onPressed: () => context.go("/all"),
          child: const Text(
            "See All",
            style: TextStyle(fontSize: 25.0, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
