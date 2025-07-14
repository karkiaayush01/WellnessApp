import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellness/features/dashboard/profile_screen.dart';
import 'package:wellness/quotes_screen.dart';
import 'package:wellness/models/category.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Category> categories = [
    Category(
      "Feeling Blessed",
      "assets/icons/sun.svg",
      quote: "When I started counting my blessings, my whole life turned around.",
      saidBy: "Willie Nelson"
    ),

    Category(
      "Pride Month",
      "assets/icons/heart.svg",
      quote: "Openness may not completely disarm prejudice, but it's a good place to start.",
      saidBy: "Jason Collins"
    ),

    Category(
      "Self-Worth",
      "assets/icons/star.svg",
      quote: "You yourself, as much as anybody in the entire universe, deserve your love and affection.",
      saidBy: "Buddha"
    ),

    Category(
      "Love",
      "assets/icons/heart_solid.svg",
      quote: "Love is composed of a single soul inhabiting two bodies.",
      saidBy: "Aristotle"
    ),
  ];

  List<Category> healthTips = [
    Category(
      "Breathe to Reset",
      "assets/icons/sun.svg",
      quote: "Sometimes the most important thing in a whole day is the rest we take between two deep breaths.",
      saidBy: "Etty Hillesum"
    )
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //stops taking leading from previous contexts (back buttons)
        title: Text(
          'Explore',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20
          )
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (ctx) {
                      return ProfileScreen();
                    }
                )
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                'https://image.lexica.art/full_jpg/8f87cbeb-233e-42b7-9822-241444d591b1',
                width: 40,
                height: 40,
                fit: BoxFit.cover
              ),
            ),
          )
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              spacing: 30,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 0),

                LayoutBuilder(
                  builder: (context, constraints){
                    final double buttonWidth = constraints.maxWidth / 2 - 10/2; //spacing divide by no. of items to get proper width

                    return SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: buttonWidth,
                            child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                    backgroundColor: Colors.grey[900],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)
                                    )
                                ),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/heart.svg',
                                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                    ),

                                    Text(
                                      'My Favourites',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16
                                      )
                                    )
                                  ],
                                )
                            ),
                          ),

                          SizedBox(
                            width: buttonWidth,
                            child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                  backgroundColor: Colors.grey[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                  )
                                ),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/bell.svg',
                                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                    ),

                                    Text(
                                        'Remind Me',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16
                                        )
                                    )
                                  ],
                                )
                            ),
                          )
                        ],
                      ),
                    );
                  }
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    Text(
                        "Today's Quotes",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 20
                        )
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 20, top: 20, right:30, bottom:20),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12)
                      ),

                      child: Column(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '"Your wellness is an investment, not an expense."',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontStyle: FontStyle.italic
                            )
                          ),

                          Text(
                              '- Author Name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic
                              )
                          ),
                        ],
                      ),
                    ),
                  ]
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    Text(
                      "Quotes",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 20
                      )
                    ),

                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: categories.map((category) =>
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (ctx) {
                                          return QuotesScreen(
                                            quote: category
                                          );
                                        }
                                    )
                                );
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
                            SizedBox(height: 10)
                          ],
                        ),
                      ).toList()
                    )
                  ]
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    Text(
                      "Health Tips",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 20
                      )
                    ),

                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: healthTips.map((category) =>
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (ctx) {
                                          return QuotesScreen(
                                            quote: category
                                          );
                                        }
                                    )
                                );
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
                            SizedBox(height: 10)
                          ],
                        ),
                      ).toList()
                    )
                  ]
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}