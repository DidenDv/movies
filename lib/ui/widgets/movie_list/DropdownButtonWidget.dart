import 'package:flutter/material.dart';
import 'package:movies_mobile/library/widgets/inherited/provider.dart';
import 'package:movies_mobile/ui/widgets/DropdownButtonModel.dart';
import 'package:movies_mobile/ui/widgets/movie_list/movie_list_model.dart';

class DropdownButtonWidget extends StatelessWidget {
  const DropdownButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieListModel>(context);

    if(model == null) return  const SizedBox.shrink();

    final selectList = model.selectList;
    final selectListValue = model.selectListValue;

    final items = selectList?.map<DropdownMenuItem<int>>((SelectValues selectValue) {
      return DropdownMenuItem<int>(
        value: selectValue.id,
        child: Text(selectValue.value),
      );
    }).toList();

    return Container(
      color: Colors.white,
      width: 120,
      padding: const EdgeInsets.only(left: 16),
      child: DropdownButton<int>(
        value: selectListValue?.id,
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        isExpanded: true,
        underline: Container(
          height: 2,
          color: Colors.grey,
        ),
        onChanged: (value) => model.onSelect(value),
        items: items,
      ),
    );
  }
}