
import 'package:airbnb/models/user_model/model.dart';
import 'package:flutter/material.dart';

class OwnerDetails extends StatelessWidget {
  const OwnerDetails({
    super.key, required this.owner,
  });

  final UserModel owner;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0))),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              softWrap: true,
              text: TextSpan(
                  text: owner.name,
                  style: const TextStyle(
                      fontSize: 20.0, color: Colors.black),
                  children: const [
                    TextSpan(text: "\n"),
                    TextSpan(
                        text: "Location",
                        style:
                        TextStyle(color: Colors.grey))
                  ]),
            ),
          ),
          const Spacer(),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0))),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.call,
                    color: Colors.black,
                  )),
            ),
          ),
        ]);
  }
}