import 'package:flutter/material.dart';

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({
    Key key,
    @required this.gambar,
  }) : super(key: key);

  final String gambar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 300,
          width: double.infinity,
          child: Image.asset(
            gambar,
            fit: BoxFit.cover,
          )),
    );
  }
}
