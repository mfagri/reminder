import 'package:flutter/material.dart';
import 'package:myapp/helpers/icon_constants.dart';
import 'package:myapp/helpers/utils.dart';
import 'package:myapp/view/friends/friends_item.dart';

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
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 14,
                right: 14,
              ),
              child: TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,

                  fillColor: Colors.white,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
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
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return const FrindsItem();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
