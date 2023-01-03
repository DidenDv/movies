import 'package:flutter/material.dart';
import 'package:movies_mobile/ui/widgets/movie_details/movie_details_cast_widget.dart';
import 'package:movies_mobile/ui/widgets/movie_details/movie_details_info_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  final int movieId;
  const MovieDetailsWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avatar: The Way of Water'),
        centerTitle: true,
      ),
      body: ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1),
        child: ListView(
          children: const [
            MovieDetailsInfo(),
            SizedBox(height: 10,),
            MovieDetailsCast()
          ],
        ),
      ),
    );
  }
}

