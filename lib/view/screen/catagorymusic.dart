import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/model/DataModel/dataModel.dart';
import 'package:music_app/view/screen/detail_audio_page.dart';
import 'package:music_app/view/screen/my_home_page.dart';
import 'package:music_app/view_model/data_view_model.dart';

class CatagoryMusic extends StatefulWidget {
  // const CatagoryMusic({Key? key, DataMain item }) : super(key: key);
  DataMain item;
  CatagoryMusic({required this.item}) {
    this.item = item;
  }
  @override
  _CatagoryMusicState createState() => _CatagoryMusicState();
}

class _CatagoryMusicState extends State<CatagoryMusic> {
  _CatagoryMusicState() {}
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Audio Therapy");

  loadDataMusic() async {
    //created json file
    String jsonMusic = jsonEncode(widget.item.musicList);
    // print(jsonMusic);
    // =============
    final deCodeData = jsonDecode(jsonMusic);
    var appData = deCodeData;

    DataModelListMusic.items = List.from(appData)
        .map((model_data) => MusicList.fromJson(model_data))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    // ReadData();
    loadDataMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: cusSearchBar,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (this.cusIcon.icon == Icons.search) {
                  this.cusIcon = Icon(Icons.cancel);
                  this.cusSearchBar = TextField(
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Search Audio"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  );
                } else {
                  this.cusIcon = Icon(Icons.search);
                  this.cusSearchBar = Text("Audio Therapy");
                }
              });
            },
            icon: cusIcon,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
            icon: Icon(Icons.home),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: (DataModelListMusic.items != null &&
                DataModelListMusic.items.isNotEmpty)
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0),
                // itemCount: listResponse == null ? 0 : listResponse.length,
                itemCount: DataModelListMusic.items.length,
                itemBuilder: (context, index) {
                  //loadin music list
                  final item = DataModelListMusic.items[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailAudioPage(musicData: item)));
                    },
                    child: Container(
                      height: 190.0,
                      child: new Card(
                        elevation: 10.0,
                        child: new Column(
                          children: <Widget>[
                            new Image.asset(
                              // listResponse[i]["avatar"].toString(),
                              // widget.item.img.toString(), // this is image of categroy music main file
                              item.img.toString(),
                              height: 90.0,
                              width: 90.0,
                              fit: BoxFit.cover,
                            ),
                            Text(" Singer Name :\n${widget.item.text} "),
                            SizedBox(
                              height: 2.0,
                            ),
                            Divider(),
                            Text(widget.item.title.toString()),
                            SizedBox(
                              height: 2.0,
                            ),
                            new Text(
                              item.name.toString(),
                              // item.musicList.toString(),
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.deepOrange),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
      ),
    );
  }
}
