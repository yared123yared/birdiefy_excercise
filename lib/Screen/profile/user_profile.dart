import 'package:app/Screen/profile/components/profile_widget.dart';
import 'package:app/Widget/button_widget.dart';
import 'package:app/model/user_entity.dart';
import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'components/stats_widget.dart';

class UserProfile extends StatelessWidget {
  final UserEntity? userEntity;
  const UserProfile({super.key, required this.userEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          title: Text(
            '${userEntity!.firstName} ${userEntity!.lastName}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileWidget(userEntity: userEntity!),
                  const SizedBox(
                    height: 30,
                  ),
                  const StatusWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(onPressed: () {}, text: "Detect Objects")
                ],
              ),
            ),
          ),
        ));
  }
}
