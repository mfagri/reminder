// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remindly/helpers/icon_constants.dart';
import 'package:remindly/helpers/utils.dart';
import 'package:remindly/model_view/auth_provider.dart';
import 'package:remindly/view/profile/profile.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    leadingWidth: MediaQuery.of(context).size.width,
    scrolledUnderElevation: 1,
    backgroundColor: Colors.white,
    // automaticallyImplyLeading: false,
    elevation: 1,
    shadowColor: const Color(0xff313131).withOpacity(0.5),
    leading: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: const Text(
            'Welcome',
            style: TextStyle(
              color: Color(0xFF313131),
              fontSize: 18,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: Row(
            children: [
              appIcon(IconsConstants.notification, false, context, 20, 15,
                  color: const Color(0xffDDDDDD)),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xff1488CC),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                        Provider.of<AuthProvider>(context, listen: false)
                            .user!
                            .image
                            .toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
