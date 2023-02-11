import 'package:flutter/material.dart';
import 'package:movies_mobile/domain/api_client/api_client.dart';
import 'package:movies_mobile/domain/entity/movie/movie_details_credits.dart';
import 'package:movies_mobile/library/widgets/inherited/provider.dart';
import 'package:movies_mobile/ui/navigation/main_navigation.dart';
import 'package:movies_mobile/ui/widgets/actor_details/ActorDetailsModel.dart';
import 'package:movies_mobile/ui/widgets/movie_details/movie_details_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MovieDetailsCast extends StatelessWidget {
  const MovieDetailsCast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var cast = model?.movieDetails?.credits.cast;
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Billed Cast',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 270,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: 1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: cast
                        .map((item) => _Card(
                              cast: item,
                            ))
                        .toList(),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Actor cast;

  const _Card({
    Key? key,
    required this.cast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(MainNavigationRouteNames.actorDetails, arguments: cast.id);
      },
      child: Container(
        width: 120,
        height: 270,
        margin: const EdgeInsets.only(right: 10),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cast.profilePath != null
                ? Image.network(
                    ApiClient.imageUrl(cast.profilePath),
                  )
                : SizedBox(
                    width: 120,
                    height: 177,
                    child: SvgPicture.network(
                      'https://www.themoviedb.org/assets/2/v4/glyphicons/basic/glyphicons-basic-36-user-female-grey-d9222f16ec16a33ed5e2c9bbdca07a4c48db14008bbebbabced8f8ed1fa2ad59.svg',
                      fit: BoxFit.contain,
                    )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                  maxLines: 2,
                  text: TextSpan(children: [
                    TextSpan(
                      text: cast.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                cast.character,
                maxLines: 2,
                style: const TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
