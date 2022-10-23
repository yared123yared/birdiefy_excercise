// import 'dart:convert';

// import 'package:app/Repository/repository.dart';
// import 'package:firebase_service/round.dart';
// import 'package:http/http.dart';
// import 'package:injectable/injectable.dart';
// import 'package:rxdart/rxdart.dart';

// @lazySingleton
// class RoundStream {
//   RoundStream(this.repository);

//   final Repository repository;
//   var subject = BehaviorSubject<List<Round>>();
//   Stream<List<Round>> get responseData => subject.stream;

//   ///Call this method to get the Address List.
//   Future<List<String>> getRounds() async {
//     ///We are using addError for displaying loading in the UI.
//     subject.sink.addError('loading');
//     Response response = await repository.getNearbyCourse();
//     if (response.statusCode != 200) {
//       subject.sink.addError("Failed to load places");
//       return [];
//     } else {
//       List<String> place = [];
//       final extractedData = json.decode(response.body);
//       final data = extractedData["results"] as List;
//       place=List<String>.from(data.map((place) => place["name"]).toList());
//       subject.sink.add(place);
//       return place;
//     }
//   }
// }
