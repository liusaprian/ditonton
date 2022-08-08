import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;
  final String type;

  TVTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
    required this.type
  });

  factory TVTable.fromEntity(TVDetail tv) => TVTable(
    id: tv.id,
    name: tv.name,
    posterPath: tv.posterPath,
    overview: tv.overview,
    type: 'tv'
  );

  factory TVTable.fromMap(Map<String, dynamic> map) => TVTable(
    id: map['id'],
    name: map['title'],
    posterPath: map['posterPath'],
    overview: map['overview'],
    type: map['type']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': name,
    'posterPath': posterPath,
    'overview': overview,
    'type': type
  };

  TV toEntity() => TV.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: name,
    type: type
  );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, posterPath, overview, type];
}
