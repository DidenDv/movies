// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_series_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularSeriesResponse _$PopularSeriesResponseFromJson(
        Map<String, dynamic> json) =>
    PopularSeriesResponse(
      json['page'] as int,
      (json['results'] as List<dynamic>)
          .map((e) => Series.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total_results'] as int,
      json['total_pages'] as int,
    );

Map<String, dynamic> _$PopularSeriesResponseToJson(
        PopularSeriesResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.series.map((e) => e.toJson()).toList(),
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
    };
