import 'package:app/Screen/round/components/round_widget.dart';
import 'package:app/model/round.dart';
import 'package:app/model/user_entity.dart';
import 'package:app/preference/user_preference_data.dart';
import 'package:app/service/injection.dart';
import 'package:app/utils/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_new_round.dart';

class RoundListPage extends StatefulWidget {
  const RoundListPage({super.key});

  @override
  State<RoundListPage> createState() => _RoundListPageState();
}

class _RoundListPageState extends State<RoundListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text(
          "My Round",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: FutureBuilder<UserEntity?>(
        future: getIt<UserPreferences>().getUserInformation(),
        builder: (BuildContext context, AsyncSnapshot<UserEntity?> snapshot) {
          if (snapshot.hasData) {
            print("User Object: ${snapshot.data}");

            final db = FirebaseFirestore.instance
                .collection('users')
                .doc(snapshot.data!.id)
                .collection("rounds");

            return StreamBuilder(
                stream: db.snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    var doc = snapshot.data!.docs;

                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Round round = Round.fromJson(doc[index].data());
                        round.id = doc[index].id;
                        print("Id of round: ${round.field_name}");
                        return RoundWidget(
                          round: round,
                          collectionReference: db,
                        );
                      },
                      itemCount: doc.length,
                    );
                  }
                  return const CircularProgressIndicator();
                });
          } else {
            return Text('Calculating answer...');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.black.withOpacity(1),
          size: 30,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNewRound()));
        },
      ),
    );
  }
}
