import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindness/components/text_styles.dart';
import 'package:kindness/controllers/auth_controller.dart';
import 'package:kindness/helpers/getUserData.dart';
import 'package:kindness/screens/points_screen.dart';

// PreferredSizeWidget customAppBar(
//     title, onTapTrealing, bool leadingIcon, onTapLeading, coins) {
//   return CustomAppBar();
// }

class CustomAppBar extends StatefulWidget {
  CustomAppBar(
      {required this.title,
      required this.leadingIcon,
      required this.onTapLeading});

  String title;
  bool leadingIcon;
  void Function() onTapLeading;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final AuthController authController = AuthController.to;
  String uid = "";
  String name = "";
  int? coins;
  String profileUrl = "";
  double screenWidth = Get.width;

  getUserData() async {
    Map userData = await getUserDataLocally();
    uid = userData['userUid'];
    name = userData['userName'];
    profileUrl = userData['userProfileUrl'];
    coins = userData['userCoins'];
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
      child: Container(
        padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                  icon: widget.leadingIcon == false
                      ? Icon(
                          Icons.format_list_bulleted_outlined,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                        ),
                  onPressed: widget.onTapLeading,
                ),
              ),
              Text(
                widget.title,
                style: headlineTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              InkWell(
                onTap: () {
                  Get.to(PointsScreen(
                      name: name,
                      coins: coins!,
                      photourl: profileUrl,
                      uid: uid));
                },
                child: Container(
                  height: Get.height * 0.055,
                  width: Get.width * 0.12,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$coins",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700),
                      ),
                      Icon(
                        Icons.savings_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(17),
          ),
          gradient: new LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(179, 199, 242, 1),
                Color.fromRGBO(206, 117, 195, 1)
              ]),
        ),
      ),
    );
  }
}
