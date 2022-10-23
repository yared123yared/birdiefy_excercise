import 'package:app/utils/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoundWidget extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  final CollectionReference collectionReference;
  const RoundWidget(
      {super.key,
      required this.documentSnapshot,
      required this.collectionReference});

  @override
  Widget build(BuildContext context) {
    // final DocumentSnapshot documentSnapshot;
    print("Document ID: ${documentSnapshot.id}");
    return StreamBuilder(
        stream: collectionReference
            .doc(documentSnapshot.id)
            .collection('Holes')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("has data");
            var doc = snapshot.data!.docs;
            doc.map((e) => print("Had Data $e")).toList();
          }
          return Padding(
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
                          Text(
                            documentSnapshot['field_name'] ?? "Golf Field 1",
                            style: const TextStyle(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          Text(
                            documentSnapshot['date'] ?? "Sept 3",
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
                            "${documentSnapshot['total_hits'] ?? 76}",
                            style: const TextStyle(
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
                                "+ ${documentSnapshot['score'] ?? 5}",
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                "${documentSnapshot['number_of_holes'] ?? 18} holes",
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
                                style: TextStyle(color: AppTheme.primaryColor))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
