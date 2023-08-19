import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/model/DataModel/dataModel.dart';
import 'package:music_app/resources/utils/app_colors.dart' as AppColors;
import 'package:flutter/cupertino.dart';
import 'package:music_app/view/widget/audio_file.dart';

class DetailAudioPage extends StatefulWidget {
  final MusicList musicData;
  const DetailAudioPage({Key? key, required this.musicData})
      : super(key: key);

  @override
  _DetailAudioPageState createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  late AudioPlayer _advancedPlayer;

  AudioPlayer get advancedPlayer => _advancedPlayer;

  set advancedPlayer(AudioPlayer advancedPlayer) {
    _advancedPlayer = advancedPlayer;
  }

  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 4,
            child: Container(
              color: AppColors.audioBlueBackground,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                // onPressed: () => Navigator.of(context).pop(),
                onPressed: () {
                  advancedPlayer.stop();
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () {},
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.2,
            height: screenHeight * 0.795,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.48,
                  ),
                  Text(
                    // this.widget.musicData[this.widget.index]["title"],
                    widget.musicData.name.toString(),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Avenir",
                    ),
                  ),
                  Text(
                    "Junk Text",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  AudioFile(
                      advancedPlayer: advancedPlayer,
                      audioPath: widget.musicData.audio.toString()
                          ),
                ],
              ),
            ),
          ),
          Positioned(
              top: screenHeight * 0.26,
              left: (screenWidth - 340) / 2,
              right: (screenWidth - 340) / 2,
              height: screenHeight * 0.4,
              child: Container(
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    // border: Border.all(color: Colors.white, width: 2,),
                    // color: AppColors.audioGreyBackground,
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 8,
                      ),
                      image: DecorationImage(
                          image: AssetImage(
                            widget.musicData.img.toString()
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
