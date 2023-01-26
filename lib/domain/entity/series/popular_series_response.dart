import 'package:json_annotation/json_annotation.dart';
import 'package:movies_mobile/domain/entity/series/series.dart';
part 'popular_series_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularSeriesResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<Series> series;
  final int totalResults;
  final int totalPages;

  factory PopularSeriesResponse.fromJson(Map<String, dynamic> json) => _$PopularSeriesResponseFromJson(json);

  PopularSeriesResponse(this.page, this.series, this.totalResults, this.totalPages);
  Map<String, dynamic> toJson() => _$PopularSeriesResponseToJson(this);
}