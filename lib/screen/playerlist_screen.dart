import 'package:ebook_app/constant.dart';
import 'package:ebook_app/music_model.dart';
import 'package:flutter/material.dart';

class PlayerList extends StatefulWidget {
  const PlayerList({super.key, required this.selectindex});
  final int selectindex;

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  late int selectindex;
  ScrollController scrollctrl = ScrollController();
  @override
  void initState() {
    selectindex = widget.selectindex;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      calculateScrollpostion(scrollctrl);
    });
    super.initState();
  }

  calculateScrollpostion(ScrollController scrollController) {
    int totalLength = musicList.length;
    final maxscroll = scrollctrl.position.maxScrollExtent;
    scrollctrl.animateTo(maxscroll / totalLength * selectindex,
        duration: Duration(milliseconds: 10), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
          child: Column(
        children: [
          Text(
            musicList[selectindex].name.toUpperCase(),
            style: TextStyle(
                fontSize: 25,
                color: AppColor.primaryTextColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Size.height * .03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              neomorphijmbtn(
                onpressed: () {
                  Navigator.pop(context, selectindex);
                },
                size: 60,
                child: Icon(
                  Icons.arrow_back,
                  color: AppColor.secondaryTextColor,
                ),
              ),
              neomorphijmbtn(
                padding: 4
                
                ,
                size: Size.width * 0.5,
                imageurl: musicList[selectindex].imageUrl,
              ),
              neomorphijmbtn(
                size: 60,
                child: Icon(
                  musicList[0].isFav ? Icons.favorite : Icons.favorite_border,
                  color: AppColor.secondaryTextColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: Size.height * .03,
          ),
          Expanded(
              child: ListView.builder(
            controller: scrollctrl,
            itemCount: musicList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectindex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: selectindex == index
                      ? BoxDecoration(
                          color: AppColor.secondaryTextColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15))
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            musicList[index].name,
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColor.primaryTextColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            musicList[index].artist,
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColor.secondaryTextColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      selectindex == index
                          ? neomorphijmbtn(
                              colors: [AppColor.blueTopDark, AppColor.blue],
                              size: 50,
                              child: Icon(
                                Icons.pause_rounded,
                                color: AppColor.white,
                              ),
                            )
                          : neomorphijmbtn(
                              size: 50,
                              child: Icon(
                                Icons.play_arrow,
                                color: AppColor.secondaryTextColor,
                              ),
                            )
                    ],
                  ),
                ),
              );
            },
          ))
        ],
      )),
    );
  }
}
