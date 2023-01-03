import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MovieDetailsInfo extends StatelessWidget {
  const MovieDetailsInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _TopPosterWidget(),
        _MovieNameWidget(),
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
    return Stack(
      children: const [
        Image(image: AssetImage('assets/images/avatar.jpg')),
        Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: Image(image: AssetImage('assets/images/avatar_mini.jpg')))
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: RichText(
          text: const TextSpan(children: [
        TextSpan(
            text: 'Avatar: The Way of Water',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        TextSpan(
            text: ' (2022)',
            style: TextStyle(
                fontSize: 16, color: Color.fromRGBO(255, 255, 255, 0.8)))
      ])),
    );
  }
}

class _TotalScore extends StatelessWidget {
  const _TotalScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
            onPressed: () {},
            child: Row(
              children: [
                CircularPercentIndicator(
                  radius: 25.0,
                  lineWidth: 4,
                  percent: 0.81,
                  center: const Text(
                    "81%",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  progressColor: const Color(0xff21d07a),
                  backgroundColor: const Color(0xff204529),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('User score', style: TextStyle(color: Colors.white)),
              ],
            )),
        Container(
          color: const Color.fromRGBO(255, 255, 155, 0.3),
          height: 24,
          width: 1,
        ),
        TextButton(
            onPressed: () {},
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
            )),
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({Key? key}) : super(key: key);
  final TextStyle textStyle =
      const TextStyle(color: Colors.white, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff1d1d1d),
          border: Border(
              top: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2), width: 1),
              bottom:
                  BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2), width: 1))),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            '12/15/2022 (CZ) 3h 12m',
            style: textStyle,
          ),
          Text('Science Fiction, Action, Adventure', style: textStyle),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
              text: TextSpan(
                  text:
                      'Set more than a decade after the events of the first film, learn the story of the Sully family (Jake, Neytiri, and their kids), the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive, and the tragedies they endure.',
                  style: TextStyle(color: Colors.white, fontSize: 16)))
        ],
      ),
    );
  }
}

class _FilmCrew extends StatelessWidget {
  const _FilmCrew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'James Cameron',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  Text('Characters, Director, Screenplay, Story',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rick Jaffa',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  Text('Screenplay, Story',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amanda Silver',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  Text('Screenplay, Story',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Josh Friedman',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  Text('Story',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
