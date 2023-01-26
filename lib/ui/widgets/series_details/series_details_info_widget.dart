import 'package:flutter/material.dart';
import 'package:movies_mobile/domain/api_client/api_client.dart';
import 'package:movies_mobile/domain/entity/series/series_details_credits.dart';
import 'package:movies_mobile/library/widgets/inherited/provider.dart';
import 'package:movies_mobile/ui/navigation/main_navigation.dart';
import 'package:movies_mobile/ui/widgets/series_details/series_details_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SeriesDetailsInfo extends StatelessWidget {
  const SeriesDetailsInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _TopPosterWidget(),
        _SeriesNameWidget(),
        _TotalScore(),
        _SummaryWidget(),
        _Description(),
        _FilmCrew()
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SeriesDetailsModel>(context);
    final backdropPath = model?.seriesDetails?.backdropPath;
    final posterPath = model?.seriesDetails?.posterPath;
    final IconData icon =
        model?.isFavorite == true ? Icons.favorite : Icons.favorite_outline;

    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ApiClient.imageUrl(backdropPath))
              : const SizedBox.shrink(),
          Positioned(
            top: 20,
            left: backdropPath != null ? 20 : 0,
            right: backdropPath != null ? null : 0,
            bottom: 20,
            child: posterPath != null
                ? Image.network(ApiClient.imageUrl(posterPath))
                : const SizedBox.shrink(),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(icon),
              onPressed: () => model?.toggleFavorite(),
            ),
          )
        ],
      ),
    );
  }
}

class _SeriesNameWidget extends StatelessWidget {
  const _SeriesNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SeriesDetailsModel>(context);
    final backdropPath = model?.seriesDetails?.backdropPath;
    final title = model?.seriesDetails?.originalName ?? '';
    var year = model?.seriesDetails?.firstAirDate?.year.toString();
    year = year != null ? ' ($year)' : '';
    return Container(
      color: backdropPath == null ? const Color(0xffdddd20) : null,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            TextSpan(
              text: year,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(255, 255, 255, 0.8),
              ),
            )
          ])),
        ),
      ),
    );
  }
}

class _TotalScore extends StatelessWidget {
  const _TotalScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seriesDetails =
        NotifierProvider.watch<SeriesDetailsModel>(context)?.seriesDetails;
    var voteAverage = seriesDetails?.voteAverage ?? 0;
    final backdropPath = seriesDetails?.backdropPath;
    voteAverage = voteAverage * 10;
    final percent = voteAverage / 100;
    final videos = seriesDetails?.videos.results
        ?.where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;
    final mainAxisAlignment = trailerKey != null
        ? MainAxisAlignment.spaceAround
        : MainAxisAlignment.center;

    return Container(
      color: backdropPath == null ? const Color(0xffdddd20) : null,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Color(0xff18171b),
                    ),
                    child: CircularPercentIndicator(
                      radius: 25.0,
                      lineWidth: 4,
                      percent: percent,
                      progressColor: const Color(0xff21d07a),
                      backgroundColor: const Color(0xff204529),
                      center: Text(
                        voteAverage.toStringAsFixed(0),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('User score',
                      style: TextStyle(color: Colors.white)),
                ],
              )),
          trailerKey != null
              ? Container(
                  color: const Color.fromRGBO(255, 255, 155, 0.3),
                  height: 24,
                  width: 1,
                )
              : const SizedBox.shrink(),
          trailerKey != null
              ? TextButton(
                  onPressed: () => Navigator.of(context).pushNamed(
                      MainNavigationRouteNames.seriesTrailer,
                      arguments: trailerKey),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Play trailer',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({Key? key}) : super(key: key);
  final TextStyle textStyle =
      const TextStyle(color: Colors.white, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SeriesDetailsModel>(context);
    final backdropPath = model?.seriesDetails?.backdropPath;
    final Color bgColor = backdropPath != null
        ? const Color(0xff1d1d1d)
        : const Color(0xffdddd20);
    if (model == null) return const SizedBox.shrink();
    var texts = <String>[];
    var genreNamesText = '';

    final releaseDate = model.seriesDetails?.firstAirDate;
    if (releaseDate != null) {
      texts.add(model.stringFromDate(releaseDate));
    }

    final productionCountries = model.seriesDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      texts.add('(${productionCountries.first.iso31661})');
    }

    final episodeRunTime = model.seriesDetails?.episodeRunTime;

    if (episodeRunTime!.isNotEmpty) {
      final runtime = model.seriesDetails?.episodeRunTime![0] ?? 0;
      final duration = Duration(minutes: runtime);
      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);
      texts.add('${hours}h ${minutes}m');
    }

    final genres = model.seriesDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      var genreNames = <String>[];
      for (var genre in genres) {
        genreNames.add(genre.name);
      }

      genreNamesText = genreNames.join(', ');
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgColor,
          border: const Border(
              top: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2), width: 1),
              bottom:
                  BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2), width: 1))),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            texts.join(' '),
            style: textStyle,
          ),
          Text(genreNamesText, style: textStyle),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SeriesDetailsModel>(context);
    final backdropPath = model?.seriesDetails?.backdropPath;
    final overview = model?.seriesDetails?.overview ?? '';
    return Container(
      color: backdropPath == null ? const Color(0xffdddd20) : null,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Overview',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
                text: TextSpan(
                    text: overview,
                    style: const TextStyle(color: Colors.white, fontSize: 16)))
          ],
        ),
      ),
    );
  }
}

class _FilmCrew extends StatelessWidget {
  const _FilmCrew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SeriesDetailsModel>(context);
    var crew = model?.seriesDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;
    var crewChunks = <List<Employee>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks
          .add(crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2));
    }

    return Column(
      children: crewChunks
          .map(
            (item) => _CrewRowWidget(employees: item),
          )
          .toList(),
    );
  }
}

class _CrewRowWidget extends StatelessWidget {
  final List<Employee> employees;

  const _CrewRowWidget({Key? key, required this.employees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: employees
          .map(
            (employee) => _CrewItemWidget(employeeItem: employee),
          )
          .toList(),
    );
  }
}

class _CrewItemWidget extends StatelessWidget {
  final Employee employeeItem;

  const _CrewItemWidget({
    Key? key,
    required this.employeeItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = employeeItem.name;
    final job = employeeItem.job;

    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(job, style: const TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
