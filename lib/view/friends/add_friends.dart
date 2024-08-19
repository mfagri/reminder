import 'package:flutter/material.dart';
import 'package:myapp/helpers/icon_constants.dart';
import 'package:myapp/helpers/utils.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({super.key});

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading: Container(
          height: 100,
          color: const Color(0xffE3E3E3),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'Add Friends',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0.06,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:
                          appIcon(IconsConstants.back, false, context, 15, 15))
                ],
              ),
            ),
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width,
      ),
      body: const Center(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          //search bar
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3054034525.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2806410375.
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0.06,
                  // Suggested code may be subject to a license. Learn more: ~LicenseLog:663312493.
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                // Suggested code may be subject to a license. Learn more: ~LicenseLog:2661310012.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                suffixIcon: Row(
                  children: [
                    Icon(
                      Icons.qr_code_scanner,
                      color: Colors.grey,
                    ),
                  ],
                ),
                suffixIconConstraints: BoxConstraints(
                  maxHeight: 30,
                  maxWidth: 40,
                ),
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.06,
              ),
            ),
          )
        ],
      )),
    );
  }
}
