import 'package:json_annotation/json_annotation.dart';

part 'actor_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ActorDetails {
  String? birthday;
  String knownForDepartment;
  String? deathday;
  int id;
  String name;
  List<String> alsoKnownAs;
  int gender;
  String biography;
  double popularity;
  String? placeOfBirth;
  String? profilePath;
  bool adult;
  String imdbId;
  String? homepage;
  SocialLinks externalIds;

  ActorDetails({
    this.birthday,
    required this.knownForDepartment,
    this.deathday,
    required this.id,
    required this.name,
    required this.alsoKnownAs,
    required this.gender,
    required this.biography,
    required this.popularity,
    this.placeOfBirth,
    this.profilePath,
    required this.adult,
    required this.imdbId,
    this.homepage,
    required this.externalIds
  });

  factory ActorDetails.fromJson(Map<String, dynamic> json) => _$ActorDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$ActorDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SocialLinks {
  String? imdbId;
  String? facebookId;
  String? twitterId;
  String? freebaseMid;
  String? freebaseId;
  String? instagramId;
  @JsonKey(name: 'tvrage_id')
  int? rageId;

  SocialLinks({
    this.facebookId,
    this.freebaseId,
    this.freebaseMid,
    this.imdbId,
    this.rageId,
    this.twitterId,
    this.instagramId
  });

  factory SocialLinks.fromJson(Map<String, dynamic> json) => _$SocialLinksFromJson(json);
  Map<String, dynamic> toJson() => _$SocialLinksToJson(this);
}