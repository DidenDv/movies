import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_mobile/domain/action_links/action_links.dart';
import 'package:movies_mobile/domain/api_client/api_client.dart';
import 'package:movies_mobile/library/widgets/inherited/provider.dart';
import 'package:movies_mobile/ui/widgets/actor_details/ActorDetailsModel.dart';
import 'package:readmore/readmore.dart';


class ActorDetailsWidget extends StatefulWidget {
  const ActorDetailsWidget({Key? key}) : super(key: key);

  @override
  State<ActorDetailsWidget> createState() => _ActorDetailsWidgetState();
}

class _ActorDetailsWidgetState extends State<ActorDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.read<ActorDetailsModel>(context)?.setupLocal(context);
  }

  String parseDateYearsOld(String? date) {
    if(date == null || date.isEmpty) return '';
    final start = DateTime.now();
    final end = DateTime.parse(date);
    final yearsOld = (start.year - end.year);

    return '$date ($yearsOld years old)';
  }

  @override
  Widget build(BuildContext context) {
    final actor = NotifierProvider.watch<ActorDetailsModel>(context)?.actorDetails;
    if(actor == null) return const SizedBox.shrink();
    final externalIds = actor.externalIds;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actor details'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 200,
              height: 200,
              child: actor.profilePath != null
                  ? Image.network(
                ApiClient.imageUrl(actor.profilePath),
              )
                  : SvgPicture.network(
                'https://www.themoviedb.org/assets/2/v4/glyphicons/basic/glyphicons-basic-36-user-female-grey-d9222f16ec16a33ed5e2c9bbdca07a4c48db14008bbebbabced8f8ed1fa2ad59.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Center(
            child: Text(
              actor.name,
              style: const TextStyle(fontSize: 34),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              externalIds.facebookId != null ? IconButton(
                  icon: const FaIcon(FontAwesomeIcons.facebook),
                  onPressed: () async {
                    await onLaunchUrl(uri: LinkKeys.facebookUrl, linkKey: externalIds.facebookId);
                  }) : const SizedBox.shrink(),
              externalIds.instagramId != null ? IconButton(
                  icon: const FaIcon(FontAwesomeIcons.instagram),
                  onPressed: () {
                    onLaunchUrl(uri: LinkKeys.instaUrl, linkKey: externalIds.facebookId);
                  }) : const SizedBox.shrink(),
              externalIds.twitterId != null ? IconButton(
                  icon: const FaIcon(FontAwesomeIcons.twitter),
                  onPressed: () {
                    onLaunchUrl(uri: LinkKeys.twitterUrl, linkKey: externalIds.twitterId);
                  }) : const SizedBox.shrink(),
            ],
          ),
          const SizedBox(height: 20,),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Personal Info', style: TextStyle(fontSize: 20),),
                const SizedBox(height: 20,),
                Wrap(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: (MediaQuery.of(context).size.width / 2) - 32,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Known For', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          Text(actor.knownForDepartment, style: const TextStyle(fontSize: 16),)
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: (MediaQuery.of(context).size.width / 2) - 32,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Gender', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          Text('${actor.gender.toString() ?? ''}', style: const TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Birthday', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          Text(parseDateYearsOld('${actor.birthday}'), style: const TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Place of Birth', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          Text(actor.placeOfBirth ?? '', style: const TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Biography', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                const SizedBox(height: 10,),
                ReadMoreText(
                  actor.biography,
                  trimLines: 10,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read more',
                  trimExpandedText: '',
                  moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(height: 40,),
          /*Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Known for', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                SizedBox(
                  height: 270,
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                            children: [
                              const _Card(),
                              const _Card()
                            ]
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40,),*/
        ],
      ),
    );
  }
}

/*class _Card extends StatelessWidget {
  //final Actor cast;

  const _Card({
    Key? key,
    //required this.cast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed(MainNavigationRouteNames.actorDetails);
      },
      child: Container(
        width: 130,
        height: 230,
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
            *//*cast.profilePath != null
                ? Image.network(
              ApiClient.imageUrl(''),
            )
                : *//*
            SizedBox(
                width: 130,
                height: 160,
                child: SvgPicture.network(
                  'https://www.themoviedb.org/assets/2/v4/glyphicons/basic/glyphicons-basic-36-user-female-grey-d9222f16ec16a33ed5e2c9bbdca07a4c48db14008bbebbabced8f8ed1fa2ad59.svg',
                  fit: BoxFit.contain,
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                  maxLines: 2,
                  text: const TextSpan(children: [
                    TextSpan(
                      text: 'The Skin I Live In',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}*/
