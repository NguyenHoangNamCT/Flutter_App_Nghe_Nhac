import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../model/Song.dart';
import 'package:http/http.dart' as http;

abstract interface class DataSource {
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    const url = 'https://thantrieu.com/resources/braniumapis/songs.json';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      //jsonDecode trả về Map<String, dynamic> vì dữ liệu json bao trùm ở ngoài
      // là 1 jsonObject ngược lại nếu dữ liệu bao trùm ở ngoài là một json array
      // thì sẽ trả về List<dynamic> mỗi dynamic trong list sẽ là Map<String, dynamic>
      var songWraper = jsonDecode(bodyContent) as Map<String, dynamic>;
      var songList = songWraper['songs'] as List<dynamic>;
      List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
      return songs;
    } else {
      return null;
    }
  }
}

class LocalDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    final String respone = await rootBundle.loadString('assets/songs.json');
    debugPrint("hello my lenth is ${respone.length}");
    final jsonBody = jsonDecode(respone) as Map<String, dynamic>;
    final songList = jsonBody['songs'] as List<dynamic>;
    List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
    return songs;
    // return null;
  }
}
