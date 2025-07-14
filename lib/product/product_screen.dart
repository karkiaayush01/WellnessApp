import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wellness/models/product_model.dart';

final Dio dio = Dio();

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  bool _isLoading = false;
  List<ProductModel> _productList = [];


  void _fetchProduct() async{
    setState(() {
      _isLoading = true;
    });

    try {
      Response<dynamic> response = await dio.get(
          'https://dummyjson.com/products');

      if (response.statusCode == 200) {
        List<dynamic> dynamicList = response.data["products"];
        _productList =
            dynamicList.map((e) => ProductModel.fromJson(e)).toList();
      }
    } catch(e) {
      print("An error occured.");
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
          itemCount: _productList.length,
          itemBuilder: (ctx, i) {
            ProductModel productModel = _productList[i];
            return ListTile(
              title: Text('${productModel.title}'),
              subtitle: Text('${productModel.category}'),
            );
          }
      )
    );
  }
}
