import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/colors.dart' as color;
import 'package:workout_app/utils/constants.dart';
import 'package:workout_app/utils/widget_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List listViewItems = [];

  void _listViewData() async {
    String jsonValue =
        await DefaultAssetBundle.of(context).loadString("json/info.json");
    listViewItems = json.decode(jsonValue);
    print(listViewItems);
  }

  @override
  void initState() {
    super.initState();
    _listViewData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 25, top: 30, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Training",
                    style: TextStyle(
                        color: color.AppColor.homePageTitle,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(child: Container()),
                  const Icon(
                    Icons.arrow_back_ios,
                    color: color.AppColor.homePageIcons,
                    size: 20,
                  ),
                  getHorizontalSpace(7),
                  const Icon(
                    Icons.date_range,
                    color: color.AppColor.homePageIcons,
                    size: 20,
                  ),
                  getHorizontalSpace(7),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: color.AppColor.homePageIcons,
                    size: 20,
                  ),
                ],
              ),
              getVerticalSpace(25),
              Row(
                children: [
                  const Text(
                    "Your Program",
                    style: TextStyle(
                        color: color.AppColor.homePageTitle,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(child: Container()),
                  const Text(
                    "Details",
                    style: TextStyle(
                        color: color.AppColor.homePageDetail,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                  getHorizontalSpace(5),
                  const Icon(
                    Icons.arrow_forward,
                    color: color.AppColor.homePageIcons,
                    size: 20,
                  ),
                ],
              ),
              getVerticalSpace(25),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(10, 10),
                          color: color.AppColor.gradientSecond.withOpacity(0.6),
                          blurRadius: 5)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                        .copyWith(topRight: Radius.circular(70)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        color.AppColor.gradientFirst,
                        color.AppColor.gradientSecond.withOpacity(0.8)
                      ],
                    )),
                // width: double.infinity,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Next Workout",
                      style: TextStyle(color: Colors.white),
                    ),
                    getVerticalSpace(10),
                    Text(
                      "Legs Toning and Glutens Workout",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    getVerticalSpace(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.timer_sharp,
                          color: Colors.white,
                        ),
                        getHorizontalSpace(15),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            "60 min",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(60)),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(5, 5),
                                    color: color.AppColor.gradientFirst
                                        .withOpacity(0.5),
                                    blurRadius: 10)
                              ]),
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              getVerticalSpace(8),
              Container(
                // height: 180,
                // color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.grey.withOpacity(0.6),
                              blurRadius: 5),
                          const BoxShadow(
                              //giving more shadow on top.
                              offset: Offset(-4, -1),
                              color: Colors.grey,
                              blurRadius: 10),
                        ],
                        image: DecorationImage(
                            image: AssetImage("$kImagePath/card.png"),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 18),
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        // color: Colors.red.withOpacity(0.5),
                        image: DecorationImage(
                            image: AssetImage("$kImagePath/figure.png"),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Container(
                      // width: double.maxFinite,
                      // height: 100,
                      margin: EdgeInsets.only(
                        left: 150,
                        top: 40,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "You are doing great",
                              style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            getVerticalSpace(12),
                            Text(
                              "keep it up",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 14),
                            ),
                            Text(
                              "stick to your plan",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 14),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
              getVerticalSpace(16),
              Text(
                "Area of focus",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
              // CardIconText(
              //   imagePath: "$kImagePath/ex1.png",
              //   text: "Glues",
              // )
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: CardIconText(
                          imagePath: "$kImagePath/ex1.png", text: "Glues"),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardIconText extends StatelessWidget {
  final String imagePath;
  final String text;

  CardIconText({required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(imagePath),
          getVerticalSpace(10),
          Text(
            text,
            style: TextStyle(color: Colors.blueAccent, fontSize: 18),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10).copyWith(top: 15),
      decoration: const BoxDecoration(
          // color: Colors.red.withOpacity(0.4),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 10)
          ],
          color: Colors.white),
    );
  }
}