import 'package:equatable/equatable.dart';
import 'package:app/model/holes.dart';

class Round extends Equatable {
  Round(
      { this.id,
      required this.field_name,
      required this.date,
       this.holes,
      required this.number_of_holes});

  String? id;
  String? field_name;
  String? date;
  int? number_of_holes;
  List<Holes>? holes;

  Round.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    field_name = json['field_name'] ?? "";
    date = json['date'] ?? "";
    number_of_holes = json['number_of_holes'] ?? "";
    if (json['Holes'] != null) {
      holes = <Holes>[];
      json['Holes'].forEach((v) {
        holes!.add(Holes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['field_name'] = field_name;
    data['date'] = date;
    data['number_of_holes'] = number_of_holes;
    if (holes != null) {
      data['Holes'] = holes!.map((v) => v.toJson()).toList();
    }

    return data;
  }

  // 'holes': holes != null ? holes!.toJson() : null,

  @override
  List<Object?> get props => [id, field_name, date, number_of_holes, holes];
}
