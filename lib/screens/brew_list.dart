import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/brew_object.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brewData = Provider.of<List<BrewObject>>(context); // Accessing data from provider. Specifying the type of data needed to ensure it listens to correct stream

    brewData.forEach((brewwww) {
      print(brewwww.sugars);
      print(brewwww.name);
      print(brewwww.strength);
    });

    return Container();
  }
}
