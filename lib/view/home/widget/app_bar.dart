// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:myapp/helpers/icon_constants.dart';
import 'package:myapp/helpers/utils.dart';
import 'package:myapp/services/supabase.dart';

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
                  await SupaService.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xff1488CC),
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://i.pinimg.com/564x/2d/0f/37/2d0f378284b1d78a5e1c558f762ce3b1.jpg'),
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
