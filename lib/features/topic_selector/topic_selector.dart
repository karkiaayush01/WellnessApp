import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wellness/core/route_config/route_name.dart';
import 'package:wellness/features/dashboard/explore_screen.dart';
import 'package:wellness/models/topic.dart';

class TopicSelector extends StatefulWidget {
  const TopicSelector({super.key});

  @override
  State<TopicSelector> createState() => _TopicSelectorState();
}

class _TopicSelectorState extends State<TopicSelector> {

  List<Topic> topics = [
    Topic("Hard Times", false),
    Topic("Working Out", false),
    Topic("Productivity", true),
    Topic("Self-esteem", true),
    Topic("Achieving goals", true),
    Topic("Inspiration", false),
    Topic("Letting Go", false),
    Topic("Love", false),
    Topic("Relationships", false),
    Topic("Faith & Spirituality", false),
    Topic("Positive Thinking", false),
    Topic("Stress & Anxiety", false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              SystemNavigator.pop(); //exits the app
            },
            icon: Icon(
              Icons.chevron_left,
              size: 48,
            )
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              spacing: 40,
              children: [
                Text(
                  'Select all topics that motivates you',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 32
                  ),
                ),

                //Using a layout builder gives the width from the constraints object that allows us to get 50% of the width that we will be using for each button in the list
                LayoutBuilder(
                  builder: (context, constraints) {
                    final double itemWidth = constraints.maxWidth / 2 - 10; // minus spacing

                    //Wrap adds items in a row until the screen constraints doesn't allow. Then it moves to next column
                    return Wrap(
                      spacing: 10, //horizontal gap
                      runSpacing: 20, // vertical gap

                      /*
                      list.map doesn't work like array.map() in js where you can get both .map(item, index).
                      The alternative to get both item and index is to use .asMap()
                     */
                      children: topics.asMap().entries.map((entry) {
                        int index = entry.key;
                        Topic topic = entry.value;

                        return SizedBox(
                          width: itemWidth,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                topics[index] =
                                    Topic(topic.title, !topic.selected);
                              });
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                              backgroundColor: topic.selected? Colors.white : Colors.grey[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                              ),
                            ),
                            child: Text(
                              topic.title,
                              style: TextStyle(
                                color: topic.selected ? Colors.black : Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                              ),
                            )
                          ),
                        );
                      }).toList()
                    );
                  }),
              ],

            ),
          ),
        )
      ),

      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min, // prevents it from taking full vertical space
        children: [
          SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: 200,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteName.dashboardScreen);
                },
                style: TextButton.styleFrom(                  backgroundColor: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
