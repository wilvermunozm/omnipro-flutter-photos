import 'package:flutter/material.dart';

class PhotoListPage extends StatelessWidget {
  const PhotoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("Lista de fotos"),
        ),
      ),
    );
  }
}
