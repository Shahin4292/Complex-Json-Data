import 'dart:convert';

import 'package:complex_json/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JsonViewPage extends StatefulWidget {
  const JsonViewPage({super.key});

  @override
  State<JsonViewPage> createState() => _JsonViewPageState();
}

class _JsonViewPageState extends State<JsonViewPage> {
  Future<ProductsModel> getProductsApi() async {
    final response = await http.get(Uri.parse(
        'https://api.edamam.com/search?q=All&app_id=b4569f96&app_key=2859517f694e1ed605f5a9e8829e80ca&from=0&to=20&calories=591-722&health=alcohol-free'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Complex Data"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<ProductsModel>(
                  future: getProductsApi(),
                  builder: (context, index) {
                    return SizedBox();
                  }))
        ],
      ),
    );
  }
}
