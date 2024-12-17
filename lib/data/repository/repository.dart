import 'package:music_app/data/source/source.dart';

import '../model/Song.dart';

abstract interface class Repository {
  Future<List<Song>?> loadData();
}

class DefaultRepository implements Repository {
  final _localDataSource = LocalDataSource();
  final _remoteDataSource = RemoteDataSource();

  //cách có dùng then
  @override
  Future<List<Song>?> loadData() async {
    List<Song> songs = [];
    await _remoteDataSource.loadData().then((remoteSong) {
      if(remoteSong == null){
        _localDataSource.loadData().then((localSong){
          if(localSong != null){
            songs.addAll(localSong);
          }
        });
      }
      else{
        songs.addAll(remoteSong);
      }
    });
    return songs;
  }

  // //không dùng then
  // @override
  // Future<List<Song>?> loadData() async {
  //   List<Song> songs = [];
  //
  //   // Chờ dữ liệu từ _remoteDataSource
  //   var remoteSong = await _remoteDataSource.loadData();
  //
  //   if (remoteSong == null) {
  //     // Nếu dữ liệu từ _remoteDataSource là null, tải dữ liệu từ _localDataSource
  //     var localSong = await _localDataSource.loadData();
  //     if (localSong != null) {
  //       songs.addAll(localSong);
  //     }
  //   } else {
  //     // Nếu dữ liệu từ _remoteDataSource có giá trị, thêm vào danh sách
  //     songs.addAll(remoteSong);
  //   }
  //
  //   return songs;
  // }
}