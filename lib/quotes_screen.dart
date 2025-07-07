import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellness/models/category.dart';

class QuotesScreen extends StatefulWidget {
  final Category quote;
  const QuotesScreen({super.key, required this.quote});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            size: 40,
            color: Colors.white
          )
        ),

        title: Text(
          widget.quote.title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white54
          )
        ),

        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(6)
            ),

            child: Text(
              '1/15',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16
              )
            )
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Center(
                child: Column(
                  spacing: 20,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.quote.quote != null ?
                        '❝ ${widget.quote.quote} ❞'
                        : 'No Quote Found For The Category',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                      textAlign: TextAlign.center,
                    ),

                    if(widget.quote.saidBy != null && widget.quote.saidBy!.trim().isNotEmpty)
                      Text(
                        widget.quote.saidBy != null ?
                            '- ${widget.quote.saidBy}'
                            : '',
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 18
                        ),
                        textAlign: TextAlign.center,
                      )
                  ],
                )
              ),

              Positioned(
                top: 16,
                right: 0,
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white24,
                  child: SvgPicture.asset(
                    'assets/icons/volume_high.svg',
                    width: 32,
                    height: 32,
                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  )
                ),
              ),

              Positioned(
                bottom: 32,
                right: 0,
                left: 0,
                child: Column(
                  spacing: 10,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/pointing_up.svg',
                      width: 40,
                      height: 40,
                      colorFilter: ColorFilter.mode(Colors.white60, BlendMode.srcIn),
                    ),

                    Text(
                      'Swipe Up',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 20
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/heart.svg',
                          width: 40,
                          height: 40,
                          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),

                        SvgPicture.asset(
                          'assets/icons/cards.svg',
                          width: 40,
                          height: 40,
                          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
}
