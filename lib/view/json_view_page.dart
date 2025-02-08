import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:complex_json/model/products_model.dart';

class JsonViewPage extends StatefulWidget {
  const JsonViewPage({super.key});

  @override
  State<JsonViewPage> createState() => _JsonViewPageState();
}

class _JsonViewPageState extends State<JsonViewPage> {
  Future<ProductModel?> getProductsApi() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.edamam.com/search?q=All&app_id=b4569f96&app_key=2859517f694e1ed605f5a9e8829e80ca&from=0&to=20&calories=591-722&health=alcohol-free'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(' the model data is ${ProductModel.fromJson(data)}');
        return ProductModel.fromJson(data);
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Json Complex Data"),
        centerTitle: true,
      ),
      body: FutureBuilder<ProductModel?>(
        future: getProductsApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.hits == null) {
            return const Center(child: Text("No Data Found"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.hits!.length,
            itemBuilder: (context, index) {
              var recipe = snapshot.data!.hits![index].recipe;
              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 3,
                child: Column(
                  children: [
                    recipe!.image != null
                        ? Image.network(
                            recipe.image!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        recipe.label ?? "Unknown Recipe",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Meal Type: ${recipe.mealType?.join(", ") ?? "N/A"}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
