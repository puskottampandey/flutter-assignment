import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onlinestore/screens/models.dart';
import 'package:http/http.dart' as http;
import '../constant/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel>? productmodel = [];
  Future<List<ProductModel>>? futureproduct;
  Future<List<ProductModel>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products?limit=10'));
    if (response.statusCode == 200) {
      List<dynamic> data = (jsonDecode(response.body.toString()));
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load the Prouct');
    }
  }

  @override
  void initState() {
    super.initState();
    futureproduct = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcolor,
        automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          "OnlineStore",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 55,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0.0,
                    blurRadius: 2,
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 375,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            iconColor: kcolor,
                            suffixIcon: const Icon(Icons.search),
                            suffixIconColor: kcolor,
                            border: InputBorder.none,
                            hintText: "Search Product......",
                            hintStyle: TextStyle(color: kcolor)),
                      ),
                    ),
                  ),
                  const SizedBox()
                ],
              ),
            ),
          ),
          const Text(
            "ALL PRODUCT",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          FutureBuilder<List<ProductModel>>(
              future: futureproduct,
              builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
                if (snapshot.hasData) {
                  List<ProductModel> products = snapshot.data!;
                  return Expanded(
                      child: GridView.builder(
                          padding: const EdgeInsets.all(16.0),
                          scrollDirection: Axis.vertical,
                          itemCount: products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Container(
                              width: 180,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 120,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(8),
                                      child: Image.network(
                                          product.image.toString(),
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                  /*
                                  Image.network(
                                    product.image.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                  */
                                  Text(
                                    product.title.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(product.price.toString()),
                                ],
                              ),
                            );
                          })

                      /* ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Text(product.title.toString());
                        }), */
                      );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              })
        ],
      ),
    );
  }
}
