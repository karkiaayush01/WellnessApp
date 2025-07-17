import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wellness/core/route_config/route_name.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.only(top:5.h),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 40
              ),
            ),
          ),

          title: Container(
            margin: EdgeInsets.only(top: 8.h),
            child: Text(
              'Dashboard',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteName.profileScreen);
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
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              spacing: 24,
              children: [
                Container(
                  height: 104.h,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.group,
                        color: Colors.white,
                        size: 84,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total Users',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 16.sp
                            ),
                          ),

                          Text(
                            '1488888',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                Container(
                  height: 104.h,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),

                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Text(
                            'Total Category',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp
                            ),
                          ),

                          Text(
                            '100',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w800
                            ),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(RouteName.addCategory);
                            },
                            padding: EdgeInsets.all(12),
                            icon: Icon(
                              Icons.add,
                              size: 28,

                            ),
                            style: ButtonStyle(

                            ),
                          ),

                          Text(
                            'Add New',
                            style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

                Container(
                  height: 104.h,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),

                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Text(
                            'Total Quotes',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp
                            ),
                          ),

                          Text(
                            '200',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w800
                            ),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(RouteName.addQuote);
                            },
                            padding: EdgeInsets.all(12),
                            icon: Icon(
                              Icons.add,
                              size: 28,

                            ),
                            style: ButtonStyle(

                            ),
                          ),

                          Text(
                            'Add New',
                            style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

                Container(
                  height: 104.h,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),

                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Text(
                            'Total Health Tips',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp
                            ),
                          ),

                          Text(
                            '50',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w800
                            ),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(RouteName.addHealthTips);
                            },
                            padding: EdgeInsets.all(12),
                            icon: Icon(
                              Icons.add,
                              size: 28,

                            ),
                            style: ButtonStyle(

                            ),
                          ),

                          Text(
                            'Add New',
                            style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ]
            ),
          ),
        )
      )
    );
  }
}
