import 'package:flutter/material.dart';
import 'package:movies_mobile/library/widgets/inherited/provider.dart';
import 'package:movies_mobile/ui/widgets/main_screen/MainScreenModel.dart';
import 'package:movies_mobile/ui/widgets/movie_details/movie_details_cast_widget.dart';
import 'package:movies_mobile/ui/widgets/movie_details/movie_details_info_widget.dart';
import 'package:movies_mobile/ui/widgets/movie_details/movie_details_model.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({Key? key,}) : super(key: key);

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {

  @override
  void initState() {
    super.initState();
    final model = NotifierProvider.read<MovieDetailsModel>(context);
    final appModel = Provider.read<MainScreenModel>(context);
    model?.onSessionExpired = () => appModel?.resetSession(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.read<MovieDetailsModel>(context)?.setupLocal(context);
  }

  @override
  Widget build(BuildContext context) {
    // NotifierProvider.read<MovieDetailsModel>(context)?.setupLocal(context);
    return Scaffold(
      appBar: AppBar(
        title: const _TitleWidget(),
        centerTitle: true,
      ),
      body: const ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1),
        child: _BodyWidget(),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final movieDetails = model?.movieDetails;
    if(movieDetails == null) {
      return const Center(child: CircularProgressIndicator(),);
    }
    return ListView(
      children: const [
        MovieDetailsInfo(),
        SizedBox(height: 10,),
        MovieDetailsCast()
      ],
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    return Text(model?.movieDetails?.title ?? 'Loading...');
  }
}

