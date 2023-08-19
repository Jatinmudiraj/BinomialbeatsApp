class DataMain {
  int? id;
  String? rating;
  String? title;
  String? text;
  String? img;
  List<MusicList>? musicList;

  DataMain(
      {this.id, this.rating, this.title, this.text, this.img, this.musicList});

  DataMain.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    title = json['title'];
    text = json['text'];
    img = json['img'];
    if (json['musicList'] != null) {
      musicList = <MusicList>[];
      json['musicList'].forEach((v) {
        musicList!.add(new MusicList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['title'] = this.title;
    data['text'] = this.text;
    data['img'] = this.img;
    if (this.musicList != null) {
      data['musicList'] = this.musicList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MusicList {
  int? id;
  String? name;
  String? img;
  String? audio;

  MusicList({this.id, this.name, this.img, this.audio});

  MusicList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['audio'] = this.audio;
    return data;
  }
}
