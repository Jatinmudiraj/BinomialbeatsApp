

import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:music_app/model/DataModel/dataModel.dart';
import 'package:music_app/resources/utils/app_colors.dart' as AppColors;
import 'package:music_app/view/screen/detail_audio_page.dart';
import 'package:music_app/view/widget/bar_top.dart';
import 'package:music_app/view/widget/my_tabs.dart';
import '../../view_model/data_view_model.dart';


class MyHomePage extends StatefulWidget {
  // const MyHomePage({Key? key, required String title}) : super(key: key);
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {


  // ignore: unused_field
  late ScrollController _scrollController;
  // ignore: unused_field
  late TabController _tabController;


  // fun for slide one
  MusicPopFun()async{
    final item = DataModelListRes.items[0];
    final List<MusicList>? dataItemMusic = item.musicList;
    String jsonMusic = jsonEncode(dataItemMusic);
    final deCodeData = jsonDecode(jsonMusic);
    var appData = deCodeData;
    DataModelListMusic.items = List.from(appData)
        .map((model_data) => MusicList.fromJson(model_data))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _scrollController = ScrollController();
    MusicPopFun();
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              //bar top widget
              MyBarData(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "Popular Music",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -30,
                      right: 0,
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        height: 180,
                        child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            // ignore: unnecessary_null_comparison

                            itemCount: DataModelListMusic.items.length,
                            itemBuilder: (context, index) {
                              final item = DataModelListMusic.items[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailAudioPage(
                                              musicData: item)));
                                },
                                child: Container(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: AssetImage(item.img.toString()),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),

              // ignore: sized_box_for_whitespace
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: AppColors.silverBackground,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(50),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20, left: 10),
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 10),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 7,
                                      offset: const Offset(0, 0),
                                    )
                                  ]),
                              tabs: [
                                AppTabs(
                                    color: AppColors.menu1Color, text: "New"),
                                AppTabs(
                                    color: AppColors.menu2Color,
                                    text: "Popular"),
                                AppTabs(
                                    color: AppColors.menu3Color,
                                    text: "Trending"),
                              ],
                            ),
                          ),
                        ),
                      )
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(

                        itemCount: DataModelListMusic.items.length,
                        itemBuilder: (context, index) {
                          final item = DataModelListMusic.items[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailAudioPage(
                                          musicData: item)));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.tabVarViewColor,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(item.img.toString())
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name
                                                .toString(),
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
                                                color: AppColors.starColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                5
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                        AppColors.menu2Color),
                                              )
                                            ],
                                          ),

                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            width: 40,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: AppColors.loveColor,
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
                      ),

                      ListView.builder(

                        itemCount: DataModelListMusic.items.length,
                        itemBuilder: (context, index) {
                          final item = DataModelListMusic.items[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailAudioPage(
                                          musicData: item)));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.tabVarViewColor,
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
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage(item.img.toString())
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name
                                                .toString(),
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
                                                color: AppColors.starColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                5
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                    AppColors.menu2Color),
                                              )
                                            ],
                                          ),

                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            width: 40,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(3),
                                              color: AppColors.loveColor,
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
                      ),
                      // const Material(
                      //   child: ListTile(
                      //     leading: CircleAvatar(
                      //       backgroundColor: Colors.grey,
                      //     ),
                      //     title: Text("Content"),
                      //   ),
                      // ),
                      ListView.builder(

                        itemCount: DataModelListMusic.items.length,
                        itemBuilder: (context, index) {
                          final item = DataModelListMusic.items[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailAudioPage(
                                          musicData: item)));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.tabVarViewColor,
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
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage(item.img.toString())
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name
                                                .toString(),
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
                                                color: AppColors.starColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                5
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                    AppColors.menu2Color),
                                              )
                                            ],
                                          ),

                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            width: 40,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(3),
                                              color: AppColors.loveColor,
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
