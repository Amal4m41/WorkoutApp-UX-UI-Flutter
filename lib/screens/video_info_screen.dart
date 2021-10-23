import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:workout_app/colors.dart' as color;
import 'package:workout_app/utils/widget_functions.dart';

class VideoInfoScreen extends StatefulWidget {
  static const String id = "videoscreen";

  const VideoInfoScreen({Key? key}) : super(key: key);

  @override
  _VideoInfoScreenState createState() => _VideoInfoScreenState();
}

class _VideoInfoScreenState extends State<VideoInfoScreen> {
  List _listViewVideoItems = [];

  void _getVideoListData() async {
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/json/videoinfo.json");
    print(jsonData);
    _listViewVideoItems = json.decode(jsonData);
  }

  @override
  void initState() {
    super.initState();
    _getVideoListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.AppColor.gradientFirst,
              color.AppColor.gradientFirst.withOpacity(0.8),
              color.AppColor.gradientFirst.withOpacity(0.5),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 25, right: 25, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: const Icon(
                            Icons.arrow_back_ios_outlined,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    getVerticalSpace(25),
                    Text(
                      "Legs Toning",
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                    Text(
                      "and Glutes Workout",
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                    getVerticalSpace(35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TransparentTextCard(
                          text: "min",
                          icon: Icons.timer_outlined,
                        ),
                        TransparentTextCard(
                          text: "Resistent band, Kettlebell",
                          icon: Icons.add,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              getVerticalSpace(30),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Circuit 1 : Legs Toning",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Icon(
                            Icons.refresh,
                            color: Colors.blue,
                          ),
                          getHorizontalSpace(10),
                          Text("3  sets")
                        ],
                      ),
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemCount: _listViewVideoItems.length,
                      //     itemBuilder: (_, int index) {
                      //       return Expanded(
                      //         child: VideoListItem(
                      //           title: _listViewVideoItems[index]["title"],
                      //           duration: _listViewVideoItems[index]["time"],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TransparentTextCard extends StatelessWidget {
  final String text;
  final IconData? icon;

  const TransparentTextCard({required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          color: color.AppColor.gradientSecond.withOpacity(0.4),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon ?? Icons.add,
            color: Colors.white,
          ),
          getHorizontalSpace(3),
          Text(
            text.toString(),
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class VideoListItem extends StatelessWidget {
  final String title;
  final String duration;

  VideoListItem({required this.title, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                "assets/images/ex1.png",
                scale: 10,
              ),
              getHorizontalSpace(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  getVerticalSpace(15),
                  Text(
                    duration,
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              )
              // Row(
              //   children: [
              //
              //   ],
              // )
            ],
          )
        ],
      ),
    );
  }
}
