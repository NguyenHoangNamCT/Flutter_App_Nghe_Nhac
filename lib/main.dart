import 'package:flutter/material.dart';
import 'package:music_app/data/repository/repository.dart';

import 'data/model/Song.dart';

void main() async{
  //vì chưa gọi run app nên gặp lỗi để dòng này dô để khắc phục tạm thời
  WidgetsFlutterBinding.ensureInitialized();
  // for(int i = 0; i < 100; i++)
  //   debugPrint("Hello");
  var repository = DefaultRepository();
  var songs = await repository.loadData() as List<Song>;
  int i = 0;

  debugPrint("Hello my lange is ${songs.length}");

  for(var s in songs){
    debugPrint(s.toString());
    debugPrint('Hi i can run ${++i}');
  }
  debugPrint("end");
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
