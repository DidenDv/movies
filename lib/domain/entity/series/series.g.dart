// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Series _$SeriesFromJson(Map<String, dynamic> json) => Series(
      posterPath: json['poster_path'] as String?,
      overview: json['overview'] as String,
      releaseDate: parseDateFromString(json['first_air_date'] as String?),
      genreIds:
          (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
      originCountry: (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      id: json['id'] as int,
      originalName: json['original_name'] as String,
      originalLanguage: json['original_language'] as String,
      backdropPath: json['backdrop_path'] as String?,
      popularity: (json['popularity'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      voteAverage: (json['vote_average'] as num).toDouble(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$SeriesToJson(Series instance) => <String, dynamic>{
      'poster_path': instance.posterPath,
      'overview': instance.overview,
      'first_air_date': instance.releaseDate?.toIso8601String(),
      'genre_ids': instance.genreIds,
      'origin_country': instance.originCountry,
      'id': instance.id,
      'original_name': instance.originalName,
      'original_language': instance.originalLanguage,
      'backdrop_path': instance.backdropPath,
      'popularity': instance.popularity,
      'vote_count': instance.voteCount,
      'vote_average': instance.voteAverage,
      'name': instance.name,
    };
