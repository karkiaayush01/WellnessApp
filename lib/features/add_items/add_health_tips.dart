import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wellness/core/route_config/route_name.dart';

class AddHealthTips extends StatefulWidget {
  const AddHealthTips({super.key});

  @override
  State<AddHealthTips> createState() => _AddHealthTipsState();
}

class _AddHealthTipsState extends State<AddHealthTips> {
  final List<String> categories = ['Quotes', 'Health'];
  String selectedCategory = 'Health';
  final _addHealthTipsFormKey = GlobalKey<FormState>();
  final TextEditingController _healthTipController = TextEditingController();

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
                Icons.arrow_back,
                color: Colors.white,
                size: 30
            ),
          ),
        ),

        title: Container(
          margin: EdgeInsets.only(top: 8.h),
          child: Text(
            'Add Health Tips',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp
            ),
          ),
        ),
      ),

      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(top: 20.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Form(
                  key: _addHealthTipsFormKey,
                  child: Column(
                    spacing: 28.h,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 24.h,
                        children: [
                          Text(
                              'Select Category:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp
                              )
                          ),

                          Container(
                            width: double.infinity,
                            height: 50.h,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedCategory,
                                dropdownColor: Colors.grey[900],
                                iconEnabledColor: Colors.white,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 16.sp,
                                ),
                                items: categories.map((category) {
                                  return DropdownMenuItem<String>(
                                    value: category,
                                    child: Text(category),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 24.h,
                        children: [
                          Text(
                            'Health Tips:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp
                            )
                          ),

                          SizedBox(
                            height: 180.h,
                            child: TextFormField(
                              controller: _healthTipController,
                              maxLines: null,
                              expands: true,
                              validator: (String? value) =>
                              (value??'').isEmpty ? 'Tip is needed' : null,
                              textAlign: TextAlign.start,
                              textAlignVertical: TextAlignVertical.top,
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Write a health tip',
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
            ),
          )
      ),

      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min, // prevents it from taking full vertical space
        children: [
          SizedBox(height: 10),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    if(_addHealthTipsFormKey.currentState != null && _addHealthTipsFormKey.currentState!.validate()){
                      Navigator.of(context).pushNamed(RouteName.adminDashboard);
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
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
