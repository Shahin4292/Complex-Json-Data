import 'package:complex_json/model/products_model.dart';
import 'package:flutter/material.dart';

class JsonViewPage extends StatefulWidget {
  const JsonViewPage({super.key});

  @override
  State<JsonViewPage> createState() => _JsonViewPageState();
}

class _JsonViewPageState extends State<JsonViewPage> {
  // Future<ProductsModel>

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Json Complex Data"), centerTitle: true,),
    );
  }
}
