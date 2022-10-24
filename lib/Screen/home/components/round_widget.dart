import 'package:app/Screen/home/add_new_hole.dart';
import 'package:app/model/holes.dart';
import 'package:app/model/round.dart';
import 'package:app/utils/app_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoundWidget extends StatelessWidget {
  final Round round;
  final CollectionReference collectionReference;
  const RoundWidget(
      {super.key, required this.round, required this.collectionReference});

  int getTotalHits() {
    if (round.holes == null) return 0;
    int sum = 0;
    for (int i = 0; i < round.holes!.length; i += 1) {
      sum += round.holes![i].hits;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    // final DocumentSnapshot documentSnapshot;
    // print("Document ID: ${round.id}");
    // int sum = 0;

    return StreamBuilder(
        stream:
            collectionReference.doc(round.id).collection('holes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("has data");
            var doc = snapshot.data!.docs;
            print("Doc: $doc");
            List<Holes> holes = [];
            holes = List<Holes>.from(
                doc.map((hole) => Holes.fromJson(hole.data())).toList());
            // doc.map((e) {
            //   Holes hole = Holes.fromJson(e.data());
            //   print("Hole: $hole");
            //   holes.add(hole);
            // }).toList();
            print("Holes: $holes");
            round.holes = holes;
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddNewHole(
                        fromRound: true,
                        round: round,
                      ))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 150,
                                child: AutoSizeText(
                                  round.field_name ?? "Golf Field 1",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: AppTheme.primaryColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                              Text(
                                round.date ?? "Sept 3",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${getTotalHits()}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "+ ${5}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "${round.number_of_holes ?? 18} holes",
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.query_stats,
                                  color: AppTheme.primaryColor,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text("stats",
                                    style:
                                        TextStyle(color: AppTheme.primaryColor))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
