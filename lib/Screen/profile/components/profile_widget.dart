import 'package:app/model/user_entity.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final UserEntity userEntity;
  const ProfileWidget({super.key, required this.userEntity});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      // child: Container(
      //  ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              // padding: EdgeInsets.only(top: 1),
              width: MediaQuery.of(context).size.width * 0.85,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Positioned(
              top: 20,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/user/cover_image.jpg'),
              )),
          Positioned(
            bottom: 20,
            child: Column(
              children: [
                const Text(
                  "HANDICAP",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  userEntity.handicap,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
