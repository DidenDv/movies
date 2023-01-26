import 'package:json_annotation/json_annotation.dart';
import 'package:movies_mobile/domain/entity/movie/movie.dart';
part 'popular_movie_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularMovieResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<Movie> movies;
  final int totalResults;
  final int totalPages;

  factory PopularMovieResponse.fromJson(Map<String, dynamic> json) => _$PopularMovieResponseFromJson(json);

  PopularMovieResponse(this.page, this.movies, this.totalResults, this.totalPages);
  Map<String, dynamic> toJson() => _$PopularMovieResponseToJson(this);
}