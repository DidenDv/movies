import 'package:flutter/material.dart';

class MovieNewsWidget extends StatelessWidget {
  const MovieNewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Movie news', style: TextStyle(fontSize: 20),),
    );
  }
}