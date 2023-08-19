import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_app/view/screen/NavBar.dart';
import 'package:music_app/view/screen/catagorymusic.dart';
import 'package:music_app/resources/utils/app_colors.dart' as Appcolors;
import 'package:flutter/services.dart';
import 'package:music_app/view_model/data_view_model.dart';
import 'package:music_app/model/DataModel/dataModel.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

//myFun to load data
//just loading the data
  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final catlogJson = await rootBundle.loadString("assets/json/data.json");
    final deCodeData = jsonDecode(catlogJson);
    var appData = deCodeData;

    DataModelListRes.items = List.from(appData)
        .map((model_data) => DataMain.fromJson(model_data))
        .toList();
    //set state to load list with data
    setState(() {});

    print(DataModelListRes.items.length);
  }

// --------
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          centerTitle: true,
          title: Center(child: Text("Music App")),
        ),
        body: (DataModelListRes.items != null &&
                DataModelListRes.items.isNotEmpty)
            ? ListView.builder(
                // itemCount: lists == null ? 0 : lists.length,
                itemCount: DataModelListRes.items.length,
                itemBuilder: (context, index) {
                  //creating instance of class for using in app
                  final item = DataModelListRes.items[index];
                  return GestureDetector(
                    onTap: () {
                      print(item.id);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CatagoryMusic(item: item)));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Appcolors.tabVarViewColor,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                offset: const Offset(0, 0),
                                color: Colors.grey.withOpacity(0.2),
                              )
                            ]),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                width: 90,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    // image: AssetImage(lists[i]["img"]),
                                    image: AssetImage(item.img.toString()),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // lists[i]["title"],
                                    item.title.toString(),
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: "Avenir",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 24,
                                        color: Appcolors.starColor,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        // lists[i]["rating"],
                                        item.rating.toString(),
                                        style: TextStyle(
                                            color: Appcolors.menu2Color),
                                      )
                                    ],
                                  ),
                                  Text(
                                    // lists[i]["text"],
                                    item.text.toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Avenir",
                                        color: Appcolors.subTitleText),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: 40,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Appcolors.loveColor,
                                    ),
                                    child: Text(
                                      "NGO",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Avenir",
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
              ));
  }
}
