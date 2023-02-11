// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorDetails _$ActorDetailsFromJson(Map<String, dynamic> json) => ActorDetails(
      birthday: json['birthday'] as String?,
      knownForDepartment: json['known_for_department'] as String,
      deathday: json['deathday'] as String?,
      id: json['id'] as int,
      name: json['name'] as String,
      alsoKnownAs: (json['also_known_as'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      gender: json['gender'] as int,
      biography: json['biography'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      placeOfBirth: json['place_of_birth'] as String?,
      profilePath: json['profile_path'] as String?,
      adult: json['adult'] as bool,
      imdbId: json['imdb_id'] as String,
      homepage: json['homepage'] as String?,
      externalIds:
          SocialLinks.fromJson(json['external_ids'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ActorDetailsToJson(ActorDetails instance) =>
    <String, dynamic>{
      'birthday': instance.birthday,
      'known_for_department': instance.knownForDepartment,
      'deathday': instance.deathday,
      'id': instance.id,
      'name': instance.name,
      'also_known_as': instance.alsoKnownAs,
      'gender': instance.gender,
      'biography': instance.biography,
      'popularity': instance.popularity,
      'place_of_birth': instance.placeOfBirth,
      'profile_path': instance.profilePath,
      'adult': instance.adult,
      'imdb_id': instance.imdbId,
      'homepage': instance.homepage,
      'external_ids': instance.externalIds.toJson(),
    };

SocialLinks _$SocialLinksFromJson(Map<String, dynamic> json) => SocialLinks(
      facebookId: json['facebook_id'] as String?,
      freebaseId: json['freebase_id'] as String?,
      freebaseMid: json['freebase_mid'] as String?,
      imdbId: json['imdb_id'] as String?,
      rageId: json['tvrage_id'] as int?,
      twitterId: json['twitter_id'] as String?,
      instagramId: json['instagram_id'] as String?,
    );

Map<String, dynamic> _$SocialLinksToJson(SocialLinks instance) =>
    <String, dynamic>{
      'imdb_id': instance.imdbId,
      'facebook_id': instance.facebookId,
      'twitter_id': instance.twitterId,
      'freebase_mid': instance.freebaseMid,
      'freebase_id': instance.freebaseId,
      'instagram_id': instance.instagramId,
      'tvrage_id': instance.rageId,
    };
