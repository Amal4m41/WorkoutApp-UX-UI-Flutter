import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:workout_app/colors.dart' as color;
import 'package:workout_app/utils/constants.dart';
import 'package:workout_app/utils/widget_functions.dart';
import 'package:video_player/video_player.dart';

class VideoInfoScreen extends StatefulWidget {
  static const String id = "videoscreen";

  const VideoInfoScreen({Key? key}) : super(key: key);

  @override
  _VideoInfoScreenState createState() => _VideoInfoScreenState();
}

class _VideoInfoScreenState extends State<VideoInfoScreen> {
  List _listViewVideoItems = [];
  bool isPlayArea = false;
  VideoPlayerController? _controller;
  bool _isPlaying = false;

  void _getVideoListData() async {
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/json/videoinfo.json");
    print(jsonData);
    setState(() {
      _listViewVideoItems = json.decode(jsonData);
    });
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
              isPlayArea
                  ? Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25, right: 25, bottom: 10),
                            child: ScreenHeader(),
                          ),
                          _playView(context),
                          _controlView(context),
                        ],
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(
                          left: 25, right: 25, top: 20, bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ScreenHeader(),
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
                            children: const [
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
                          const Text(
                            "Circuit 1 : Legs Toning",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          const Icon(
                            Icons.refresh,
                            color: Colors.blue,
                          ),
                          getHorizontalSpace(10),
                          Text("3  sets")
                        ],
                      ),
                      getVerticalSpace(20),
                      Expanded(
                        child: VideoItemsListViewBuilder(
                            listViewVideoItems: _listViewVideoItems,
                            onTapItem: (int index) {
                              var item = _listViewVideoItems[index];
                              debugPrint("Clicked: $index, ${item["title"]}");

                              if (!isPlayArea) {
                                setState(() {
                                  isPlayArea = true;
                                });
                              }

                              _InitializeVideoPlayer(item["videoUrl"]);
                            }),
                      )
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

  Widget _controlView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: color.AppColor.gradientFirst.withOpacity(0.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              onPressed: () {},
              child: Icon(
                Icons.fast_rewind,
                color: Colors.white,
              )),
          TextButton(
              onPressed: () {
                if (_isPlaying) {
                  _controller?.pause();
                } else {
                  _controller?.play();
                }
              },
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              )),
          TextButton(
              onPressed: () {},
              child: Icon(
                Icons.fast_forward,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  Widget _playView(BuildContext context) {
    print("CALLED PLAYVIEW");
    if (_controller != null && _controller!.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(_controller!),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Loading please wait",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              getHorizontalSpace(10),
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              )
            ],
          ),
        ),
      );
    }
  }

  void _onControllerUpdate() {
    if (_controller == null) {
      debugPrint("controller is null");
    } else if (!_controller!.value.isInitialized) {
      debugPrint("controller is not initialized");
    } else {
      setState(() {
        _isPlaying = _controller!.value.isPlaying;
      });
      print("isplaying : $_isPlaying");
    }
  }

  void _InitializeVideoPlayer(String videoUrl) async {
    _controller = VideoPlayerController.network(videoUrl);
    await _controller?.initialize();
    _controller?.addListener(_onControllerUpdate);
    _controller?.play();
    print("$_controller");
    setState(() {});
  }
}

class VideoItemsListViewBuilder extends StatelessWidget {
  final List listViewVideoItems;
  final onTapItemCallback onTapItem;

  VideoItemsListViewBuilder({
    required this.listViewVideoItems,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listViewVideoItems.length,
      itemBuilder: (_, int index) {
        final item = listViewVideoItems[index];
        return GestureDetector(
          onTap: () {
            onTapItem(index);
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: VideoListItem(
              title: item["title"],
              duration: item["time"],
              imagePath: item["thumbnail"],
              restDuration: "15s rest",
            ),
          ),
        );
      },
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
  final String imagePath;
  final String restDuration;

  VideoListItem(
      {required this.title,
      required this.duration,
      required this.imagePath,
      required this.restDuration});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.redAccent,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  // color: Colors.redAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage(
                        imagePath,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              getHorizontalSpace(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  getVerticalSpace(12),
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
          ),
          getVerticalSpace(20),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                    color: color.AppColor.gradientSecond.withOpacity(0.3),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  restDuration,
                  style: TextStyle(
                      color: color.AppColor.gradientFirst, fontSize: 12),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 70; i++)
                      i.isEven
                          ? Container(
                              width: 3,
                              height: 1,
                              color: Colors.grey,
                            )
                          : Container(
                              width: 3,
                              height: 1,
                              color: Colors.white,
                            )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ScreenHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
        const Icon(
          Icons.info_outline,
          color: Colors.white,
        ),
      ],
    );
  }
}
