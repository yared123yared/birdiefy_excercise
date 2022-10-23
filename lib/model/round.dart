import 'package:equatable/equatable.dart';
import 'package:app/model/holes.dart';

class Round extends Equatable {
  Round(
      {required this.id,
      required this.field_name,
      required this.date,
      required this.holes,
      required this.number_of_holes});

  String? id;
  final String field_name;
  final String date;
  final int number_of_holes;
  final Holes? holes;

  factory Round.fromJson(Map<String, dynamic> json) => Round(
        id: json['id'] ?? "",
        field_name: json['field_name'] ?? "",
        date: json['date'] ?? "",
        number_of_holes: json['number_of_holes'] ?? "",
        holes: json["Holes"] != null ? Holes.fromJson(json['holes']) : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'field_name': field_name,
        'date': date,
        'number_of_holes': number_of_holes,
        'holes': holes != null ? holes!.toJson() : null,
      };

  @override
  List<Object?> get props => [id, field_name, date, number_of_holes, holes];
}
