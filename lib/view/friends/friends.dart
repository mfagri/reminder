import 'package:flutter/material.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE3E3E3),
        title: const Text(
          'Friends',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          ListView.builder(itemBuilder: (context, index) {
            return const ListTile(
              title: Text('item'),
            );
          }),
        ],
      )),
    );
  }
}
