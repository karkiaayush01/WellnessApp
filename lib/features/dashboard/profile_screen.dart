import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellness/core/route_config/route_name.dart';
import 'package:wellness/features/auth/login_screen.dart';
import 'package:wellness/models/category.dart';
import 'package:wellness/popup.dart';
import 'package:wellness/service/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final String displayName = AuthService().getDisplayName();
  final String userEmail = AuthService().getUserEmail();

  List<Category> menuCategories = [
    Category("Theme", "assets/icons/pen.svg"),
    Category("Change Password", "assets/icons/password_elipsis.svg",
      onClick: (context) {
        Navigator.of(context).pushNamed(
          RouteName.changePassword
        );
      }
    ),
    Category("Logout", "assets/icons/logout.svg",
      onClick: (ctx) async {
        String? signOutResult = await AuthService().signOut()??"";
        if(signOutResult.startsWith("Success:")){
          Navigator.of(ctx).pushNamed(RouteName.loginScreen);
        }
        else {
          if(signOutResult.startsWith("Error:")){
            String popupMessage = signOutResult.split("Error: ")[0];
            Popup.show(ctx, popupMessage, type: PopupType.error );
          }
        }
      }
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 40
            ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 24
          )
        )
      ),

      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              spacing: 40,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[900]
                  ),

                  child: Row(
                    spacing: 20,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          'https://image.lexica.art/full_jpg/8f87cbeb-233e-42b7-9822-241444d591b1',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6,
                        children: [
                          Text(
                            displayName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                            )
                          ),

                          Text(
                            userEmail,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white54
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ),

                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    children: [
                      Text(
                          "MAKE IT YOURS",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white54,
                              fontSize: 18
                          )
                      ),

                      Column(
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    spacing: 10,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/open_book.svg",
                                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                      ),

                                      Text(
                                        'Content Preferences',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  ),

                                  Icon(
                                    Icons.chevron_right,
                                    color: Colors.white,
                                    size: 24,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10)
                        ],
                      ),
                    ]
                ),

                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    children: [
                      Text(
                          "ACCOUNT",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white54,
                              fontSize: 18
                          )
                      ),

                      ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: menuCategories.map((category) =>
                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      category.onClick?.call(context);
                                    },
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            spacing: 10,
                                            children: [
                                              SvgPicture.asset(
                                                category.iconPath,
                                                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                              ),

                                              Text(
                                                category.title,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              )
                                            ],
                                          ),

                                          Icon(
                                            Icons.chevron_right,
                                            color: Colors.white,
                                            size: 24,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16)
                                ],
                              ),
                          ).toList()
                      )
                    ]
                )
              ],
            ),
          )
      )
    );
  }
}
