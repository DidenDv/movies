import 'package:json_annotation/json_annotation.dart';
import 'package:movies_mobile/domain/entity/series/parse_date.dart';
import 'package:movies_mobile/domain/entity/series/series_details_credits.dart';
import 'package:movies_mobile/domain/entity/series/series_details_videos.dart';
part 'series_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SeriesDetails {
  final bool? adult;
  final String? backdropPath;
  final List<CreatedBy>? createdBy;
  final List<int>? episodeRunTime;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? firstAirDate;
  final List<Genres>? genres;
  final String? homepage;
  final int? id;
  final bool? inProduction;
  final List<String>? languages;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? lastAirDate;
  final LastEpisodeToAir? lastEpisodeToAir;
  final NextEpisodeToAir? nextEpisodeToAir;
  final String? name;
  final List<Networks>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompanies>? productionCompanies;
  final List<ProductionCountries>? productionCountries;
  final List<Seasons>? seasons;
  final List<SpokenLanguages>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;
  final SeriesDetailsCredits credits;
  final SeriesDetailsVideos videos;

  SeriesDetails({
    this.adult,
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.nextEpisodeToAir,
    this.name,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
    required this.credits,
    required this.videos
  });

  factory SeriesDetails.fromJson(Map<String, dynamic> json) => _$SeriesDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountries {
  @JsonKey(name: 'iso_3166_1')
  String? iso31661;
  String? name;

  ProductionCountries({
    this.iso31661,
    this.name,
  });

  factory ProductionCountries.fromJson(Map<String, dynamic> json) => _$ProductionCountriesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionCountriesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompanies {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) => _$ProductionCompaniesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionCompaniesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Genres {
  final int id;
  final String name;

  Genres({
    required this.id,
    required this.name,
  });

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);
  Map<String, dynamic> toJson() => _$GenresToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguages {
  String? englishName;
  @JsonKey(name: 'iso_639_1')
  String? iso6391;
  String? name;

  SpokenLanguages({
    this.englishName,
    this.iso6391,
    this.name,
  });

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) => _$SpokenLanguagesFromJson(json);
  Map<String, dynamic> toJson() => _$SpokenLanguagesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Seasons {
  String? airDate;
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;

  Seasons({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });

  factory Seasons.fromJson(Map<String, dynamic> json) => _$SeasonsFromJson(json);
  Map<String, dynamic> toJson() => _$SeasonsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Networks {
  String? name;
  int? id;
  String? logoPath;
  String? originCountry;

  Networks({
    this.name,
    this.id,
    this.logoPath,
    this.originCountry,
  });

  factory Networks.fromJson(Map<String, dynamic> json) => _$NetworksFromJson(json);
  Map<String, dynamic> toJson() => _$NetworksToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LastEpisodeToAir {
  @JsonKey(fromJson: parseDateFromString)
  DateTime? airDate;
  int? episodeNumber;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? seasonNumber;
  int? showId;
  String? stillPath;
  double? voteAverage;
  int? voteCount;

  LastEpisodeToAir({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.showId,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) => _$LastEpisodeToAirFromJson(json);
  Map<String, dynamic> toJson() => _$LastEpisodeToAirToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class NextEpisodeToAir {
  @JsonKey(fromJson: parseDateFromString)
  DateTime? airDate;
  int? episodeNumber;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? seasonNumber;
  int? showId;
  String? stillPath;
  double? voteAverage;
  int? voteCount;

  NextEpisodeToAir({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.showId,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  factory NextEpisodeToAir.fromJson(Map<String, dynamic> json) => _$NextEpisodeToAirFromJson(json);
  Map<String, dynamic> toJson() => _$NextEpisodeToAirToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CreatedBy {
  int? id;
  String? creditId;
  String? name;
  int? gender;
  String? profilePath;

  CreatedBy({
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => _$CreatedByFromJson(json);
  Map<String, dynamic> toJson() => _$CreatedByToJson(this);
}
