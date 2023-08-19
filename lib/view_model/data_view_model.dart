import 'package:music_app/model/DataModel/dataModel.dart';

//this will add our data to list  and it contain the fun to get data match with id = id clicked
class DataModelListRes {
  static List<DataMain> items = [];

  DataMain getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);

  DataMain getByPosition(int pos) => items[pos];
}

class DataModelListMusic {
  static List<MusicList> items = [];

  MusicList getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);

  MusicList getByPosition(int pos) => items[pos];
}

