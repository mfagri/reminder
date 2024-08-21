// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  String name;
// Suggested code may be subject to a license. Learn more: ~LicenseLog:915413359.
  TextEditingController controller;
  bool isDescription;
  InputWidget({
    super.key,
    required this.name,
    required this.controller,
    required this.isDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Color(0xFF131212),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        SizedBox(
          height: isDescription ? 100 : 40,
          child: TextField(
            controller: controller,
            cursorColor: Colors.black,
            maxLines: isDescription ? 5 : 1,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white, //
              hintText: name,
              hintStyle: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(
                  color: Color(0xFFC4C4C4),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(
                  color: Color(0xFFC4C4C4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


  Widget buildInputFields(
      TextEditingController name, TextEditingController desc) {
    return Column(
      children: [
        InputWidget(
            name: 'Task Name',
            controller: TextEditingController(),
            isDescription: false),
        const SizedBox(height: 20),
        InputWidget(
            name: 'Task Description',
            controller: TextEditingController(),
            isDescription: true),
      ],
    );
  }