import 'package:flutter/material.dart';
import 'package:movies_mobile/ui/navigation/main_navigation.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({ Key? key }) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(
        id: 1,
        img: 'assets/images/test.jpg',
        title: 'House of dragon',
        time: 'Aug 21, 2022',
        description: 'Set more than a decade after the events of the first film, learn the story of the Sully family (Jake, Neytiri, and their kids), the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive, and the tragedies they endure.'
    ),
    Movie(
        id: 2,
        img: 'assets/images/test.jpg',
        title: 'Avatar: The Way of Water',
        time: 'December 14, 2022',
        description: 'Set more than a decade after the events of the first film, learn the story of the Sully family (Jake, Neytiri, and their kids), the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive, and the tragedies they endure.'
    ),
    Movie(
        id: 3,
        img: 'assets/images/test.jpg',
        title: 'Black Adam',
        time: 'October 19, 2022',
        description: 'Nearly 5,000 years after he was bestowed with the almighty powers of the Egyptian gods—and imprisoned just as quickly—Black Adam is freed from his earthly tomb, ready to unleash his unique form of justice on the modern world.'
    ),
    Movie(
        id: 4,
        img: 'assets/images/test.jpg',
        title: 'Troll',
        time: 'December  1, 2022',
        description: 'Deep inside the mountain of Dovre, something gigantic awakens after being trapped for a thousand years. Destroying everything in its path, the creature is fast approaching the capital of Norway. But how do you stop something you thought only existed in Norwegian folklore?'
    ),
    Movie(
        id: 5,
        img: 'assets/images/test.jpg',
        title: 'The Woman King',
        time: 'September 15, 2022',
        description: 'The story of the Agojie, the all-female unit of warriors who protected the African Kingdom of Dahomey in the 1800s with skills and a fierceness unlike anything the world has ever seen, and General Nanisca as she trains the next generation of recruits and readies them for battle against an enemy determined to destroy their way of life.'
    )
  ];

  var _filterMovies = <Movie>[];
  final _searchController = TextEditingController();

  void _searchMovies() {
    final query = _searchController.text;
    if(query.isNotEmpty) {
      _filterMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
    _filterMovies = _movies;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _filterMovies = _movies;
    _searchController.addListener(_searchMovies);
  }

  void _onMovieTap(int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(MainNavigationRouteNames.mainDetails, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 70.0),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _filterMovies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final movie = _filterMovies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black.withOpacity(0.2)),
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                      // menuRow.map((data) => _MenuWidgetItem(data: data)).toList()
                    child: Row(
                      children: [
                        Image(image: AssetImage(movie.img),),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                  ),),
                                Text(movie.time, style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff999999),
                                    fontWeight: FontWeight.w400
                                )),
                                const SizedBox(height: 20,),
                                Text(movie.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      onTap: () => _onMovieTap(index),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
                labelText: 'Search',
                filled: true,
                fillColor: Colors.white.withAlpha(235)
            ),
          ),
        )
      ],
    );
  }
}

class Movie {
  final int id;
  final String img;
  final String title;
  final String time;
  final String description;

  Movie({
    required this.id,
    required this.img,
    required this.title,
    required this.time,
    required this.description
  });
}