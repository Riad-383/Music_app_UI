import 'package:ebook_app/constant.dart';
import 'package:ebook_app/music_model.dart';
import 'package:ebook_app/screen/playerlist_screen.dart';
import 'package:flutter/material.dart';

class playerScreen extends StatefulWidget {
  const playerScreen({super.key});

  @override
  State<playerScreen> createState() => _playerScreenState();
}

class _playerScreenState extends State<playerScreen> {
  int _currentItemPlaying = 0;
  double _currentPlayback = 0;
  String playtime(double time) {
    final min = time ~/ 60;
    final sec = time % 60;
    return "$min:${sec.toStringAsFixed(0).padRight(2, "0")}";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  neomorphijmbtn(
                    size: 60,
                    child: Icon(
                      musicList[_currentItemPlaying].isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColor.secondaryTextColor,
                    ),
                  ),
                  Text(
                    'PLAYING NOW',
                    style: TextStyle(
                        color: AppColor.secondaryTextColor, fontSize: 25),
                  ),
                  neomorphijmbtn(
                    onpressed: () async {
                      int selectindex = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerList(
                            selectindex: _currentItemPlaying,
                          ),
                        ),
                      );
                      setState(() {
                        _currentItemPlaying = selectindex;
                      });
                    },
                    size: 60,
                    child: Icon(
                      Icons.menu,
                      color: AppColor.secondaryTextColor,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * .02,
              ),
              neomorphijmbtn(
                padding: 10,
                size: size.width * 0.8,
                imageurl: musicList[_currentItemPlaying].imageUrl,
              ),
              SizedBox(
                height: size.height * .03,
              ),
              Column(
                children: [
                  Text(
                    musicList[_currentItemPlaying].name,
                    style: TextStyle(
                        fontSize: 25,
                        color: AppColor.primaryTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    musicList[_currentItemPlaying].artist,
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColor.secondaryTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          playtime(_currentPlayback),
                          style: TextStyle(color: AppColor.secondaryTextColor),
                        ),
                        Text(playtime(musicList[_currentItemPlaying].length),
                            style:
                                TextStyle(color: AppColor.secondaryTextColor))
                      ],
                    ),
                  ),
                  Slider(
                      value: _currentPlayback,
                      max: musicList[_currentItemPlaying].length,
                      thumbColor: AppColor.blue,
                      activeColor: AppColor.blue,
                      inactiveColor: AppColor.bgDark,
                      onChanged: (value) {
                        setState(() {
                          _currentPlayback = value;
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  neomorphijmbtn(
                    onpressed: () {
                      if (_currentItemPlaying > 0) {
                        setState(() {
                          _currentItemPlaying--;
                        });
                      }
                    },
                    size: 80,
                    child: Icon(
                      Icons.skip_previous_rounded,
                      color: AppColor.secondaryTextColor,
                      size: 35,
                    ),
                  ),
                  neomorphijmbtn(
                    colors: [AppColor.blueTopDark, AppColor.blue],
                    size: 80,
                    child: Icon(
                      Icons.pause_rounded,
                      color: AppColor.bgColor,
                      size: 35,
                    ),
                  ),
                  neomorphijmbtn(
                    onpressed: () {
                      if (_currentItemPlaying < musicList.length - 1) {
                        setState(() {
                           _currentItemPlaying++;
                        });
                       
                      }
                    },
                    size: 80,
                    child: Icon(
                      Icons.skip_next_rounded,
                      color: AppColor.secondaryTextColor,
                      size: 35,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
