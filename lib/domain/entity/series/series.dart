import 'package:json_annotation/json_annotation.dart';
import 'package:movies_mobile/domain/entity/series/parse_date.dart';
part 'series.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Series {
  final String? posterPath;
  final String overview;
  @JsonKey(fromJson: parseDateFromString, name: 'first_air_date')
  final DateTime? releaseDate;
  final List<int> genreIds;
  final List<String> originCountry;
  final int id;
  final String originalName;
  final String originalLanguage;
  final String? backdropPath;
  final double popularity;
  final int voteCount;
  // final bool video;
  final double voteAverage;
  final String name;


  factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);

  Series({
        this.posterPath,
        required this.overview,
        required this.releaseDate,
        required this.genreIds,
        required this.originCountry,
        required this.id,
        required this.originalName,
        required this.originalLanguage,
        required this.backdropPath,
        required this.popularity,
        required this.voteCount,
        // required this.video,
        required this.voteAverage,
        required this.name,
      });
  Map<String, dynamic> toJson() => _$SeriesToJson(this);
}