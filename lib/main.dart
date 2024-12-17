import 'package:flutter/material.dart';
import 'package:music_app/data/repository/repository.dart';

import 'data/model/Song.dart';

void main() async{
  var repository = DefaultRepository();
  var songs = await repository.loadData() as List<Song>;
  for(var s in songs){
    debugPrint(s.toString());
  }
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
