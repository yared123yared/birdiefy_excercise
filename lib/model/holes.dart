import 'package:equatable/equatable.dart';

class Holes extends Equatable {
  Holes({
    this.id,
    required this.hits,
    required this.pars
  });

  String? id;
  final int pars;
  final int hits;

  factory Holes.fromJson(Map<String, dynamic> json) => Holes(
        id: json['id'] ?? "",
        pars: json['pars'] ?? "",
        hits: json['hits'] ?? "",
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'pars': pars,
        'hits': hits,
      };
  // factory Holes.empty() {
  //   // ignore: prefer_const_constructors
  //   return Holes(
  //     id: "",
  //     pars: ""
  //     hits: "",
  //   );
  // }

  @override
  List<Object?> get props => [id, pars, hits];
}
