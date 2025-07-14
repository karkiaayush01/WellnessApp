import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wellness/core/route_config/route_name.dart';

class AddCategory extends StatefulWidget{
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory>{
  final _categoryFormKey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();
  String selectedCategory = 'Quotes';
  List<String> types = ['Quotes', 'Health'];

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
            'Add Category',
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
              key: _categoryFormKey,
              child: Column(
                spacing: 28.h,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 24.h,
                    children: [
                      Text(
                        'Category Name:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp
                        )
                      ),
          
                      TextFormField(
                        controller: _categoryNameController,
                        validator: (String? value) =>
                          (value??'').isEmpty ? 'Category name is needed' : null,
                        style: TextStyle(
                          fontSize: 16.sp
                        ),
                        decoration: InputDecoration(
                          hintText: 'Category Name',
                        ),
                      )
                    ],
                  ),
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 24.sp,
                    children: [
                      Text(
                        'Category Type:',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp
                        )
                      ),
          
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double containerWidth = constraints.maxWidth / 2 - 30.w; //10.w each for padding left and right and 10 for row spacing
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: types.map((type) =>
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = type;
                                  });
                                },
                                child: Container(
                                  width: containerWidth.w,
                                  height: 70.h,
                                  decoration: BoxDecoration(
                                    color: selectedCategory == type ? Colors .grey[900] : Colors.black,
                                    border: selectedCategory == type ? null : Border.all(color: Colors.grey[900]!),
                                    borderRadius: BorderRadius.circular(12)
                                  ),
          
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 10.w,
                                    children: [
                                      Icon(
                                        selectedCategory == type
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_unchecked,
                                        color: Colors.white,
                                        size: 20.sp,
                                      ),
          
                                      Text(
                                        type,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white
                                        )
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ).toList()
                          );
                        }
                      )
                    ],
                  ),
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 24.sp,
                    children: [
                      Text(
                        'Choose image for category:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp
                        )
                      ),
          
                      DottedBorder(
                        color: Colors.white54,
                        strokeWidth: 2,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(8),
                        dashPattern: [6, 4],
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 32,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Tap to choose image',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]
                  ),
                ],
              )
            ),
          ),
        ),
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
                    if(_categoryFormKey.currentState != null && _categoryFormKey.currentState!.validate()){
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

