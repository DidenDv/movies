import 'package:flutter/material.dart';
import 'package:movies_mobile/domain/api_client/api_client.dart';
import 'package:movies_mobile/library/widgets/inherited/provider.dart';
import 'package:movies_mobile/ui/widgets/series_list/DropdownButtonWidget.dart';
import 'package:movies_mobile/ui/widgets/series_list/series_list_model.dart';

class SeriesListWidget extends StatelessWidget {
  const SeriesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SeriesListModel>(context);
    if(model == null) return const SizedBox.shrink();
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 100.0),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: model.series.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            model.showedSeriesAtIndex(index);
            final series = model.series.elementAt(index);
            final posterPath = series.posterPath;
            final releaseDate = series.releaseDate;
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
                    child: Row(
                      children: [
                        (posterPath == null)
                            ? const SizedBox.shrink()
                            : Image.network(
                                ApiClient.imageUrl(posterPath),
                                width: 95,
                              ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  series.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                  ),),

                                Text(model.stringFromDate(releaseDate), style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff999999),
                                    fontWeight: FontWeight.w400
                                )),
                                const SizedBox(height: 20,),
                                Text(series.overview,
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
                      onTap: () => model.onSeriesTap(context, index),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0,60,20,0),
          alignment: AlignmentDirectional.topEnd,
          child: const DropdownButtonWidget(),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: model.searchSeries,
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