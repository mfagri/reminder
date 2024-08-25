import 'package:flutter/material.dart';
import 'package:remindly/helpers/utils.dart';
import 'package:remindly/model/status_model.dart';

Center statusItem(Status status, bool isselcted, BuildContext context) {
  return Center(
    child: Container(
        margin: const EdgeInsets.only(left: 10),
        height: 60,
        width: 172,
        decoration: BoxDecoration(
          color: isselcted ? status.color : Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: const Color(0xffE0E0E0),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Center(
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: status.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: appIcon(status.icon, false, context, 15, 10),
                  ),
                ),
              ),
              const SizedBox(
                width: 17,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status.title,
                    style: const TextStyle(
                      color: Color(0xFF717171),
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
  );
}
