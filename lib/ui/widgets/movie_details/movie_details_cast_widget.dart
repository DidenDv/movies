import 'package:flutter/material.dart';

class MovieDetailsCast extends StatelessWidget {
  const MovieDetailsCast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            height: 230,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      const _Card(img: 'assets/images/actor.jpg', name: 'Sam Worthington', actorImage: 'Neytiri',),
                      const _Card(img: 'assets/images/actor1.jpg', name: 'Zoe Saldaña', actorImage: 'Neytiri',),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String img;
  final String name;
  final String actorImage;
  const _Card({Key? key, required this.name, required this.img, required this.actorImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 230,
      margin: const EdgeInsets.only(right: 10),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(image: AssetImage(img)),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
            ])),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(actorImage, style: const TextStyle(fontSize: 14),),
          )
        ],
      ),
    );
  }
}
