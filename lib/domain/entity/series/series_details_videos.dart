import 'package:json_annotation/json_annotation.dart';
part 'series_details_videos.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SeriesDetailsVideos {
  List<Videos>? results;

  SeriesDetailsVideos({this.results});

  factory SeriesDetailsVideos.fromJson(Map<String, dynamic> json) => _$SeriesDetailsVideosFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesDetailsVideosToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Videos {
  @JsonKey(name: 'iso_639_1')
  final String iso6391;
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;

  Videos({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => _$VideosFromJson(json);
  Map<String, dynamic> toJson() => _$VideosToJson(this);
}
