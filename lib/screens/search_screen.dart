import 'package:flutter/material.dart';
import 'package:onlinestore/screens/models.dart';

import '../constant/constant.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController contoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // ignore: avoid_unnecessary_containers
          child: Column(
            children: [
              Container(
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
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: kcolor,
                    ),
                    SizedBox(
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: contoller,
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
            ],
          ),
        ),
      ),
    );
  }
}
