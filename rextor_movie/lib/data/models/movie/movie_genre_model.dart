import 'package:rextor/domain/entities/movie/genre.dart';
import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {
  final int id;
  final String name;
  GenreModel({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  Genre toEntity() {
    return Genre(id: this.id, name: this.name);
  }


}
