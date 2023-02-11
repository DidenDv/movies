import 'package:flutter/material.dart';
import 'package:movies_mobile/library/widgets/inherited/provider.dart';
import 'package:movies_mobile/ui/widgets/main_screen/MainScreenModel.dart';
import 'package:movies_mobile/ui/widgets/series_details/series_details_cast_widget.dart';
import 'package:movies_mobile/ui/widgets/series_details/series_details_info_widget.dart';
import 'package:movies_mobile/ui/widgets/series_details/series_details_model.dart';

class SeriesDetailsWidget extends StatefulWidget {
  const SeriesDetailsWidget({Key? key,}) : super(key: key);

  @override
  State<SeriesDetailsWidget> createState() => _SeriesDetailsWidgetState();
}

class _SeriesDetailsWidgetState extends State<SeriesDetailsWidget> {

  @override
  void initState() {
    super.initState();
    final model = NotifierProvider.read<SeriesDetailsModel>(context);
    final appModel = Provider.read<MainScreenModel>(context);
    model?.onSessionExpired = () => appModel?.resetSession(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.read<SeriesDetailsModel>(context)?.setupLocal(context);
  }

  @override
  Widget build(BuildContext context) {
    //NotifierProvider.read<SeriesDetailsModel>(context)?.setupLocal(context);
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
    final model = NotifierProvider.watch<SeriesDetailsModel>(context);
    final seriesDetails = model?.seriesDetails;
    if(seriesDetails == null) {
      return const Center(child: CircularProgressIndicator(),);
    }
    return ListView(
      children: const [
        SeriesDetailsInfo(),
        SizedBox(height: 10,),
        SeriesDetailsCast()
      ],
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SeriesDetailsModel>(context);
    return Text((model?.seriesDetails?.originalName) ?? 'Loading...');
  }
}

