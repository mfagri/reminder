import 'package:flutter/material.dart';
import 'package:myapp/helpers/utils.dart';
import 'package:myapp/view/friends/friends_item.dart';
import 'package:myapp/view/friends/scan_view.dart';
// import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
// import 'package:scan/scan.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({super.key});

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: myAppbar(context, "Add Friends"),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
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
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    // Suggested code may be subject to a license. Learn more: ~LicenseLog:663312493.
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  // Suggested code may be subject to a license. Learn more: ~LicenseLog:2661310012.
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  suffixIcon: InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScanViwePage(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.qr_code_scanner,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    maxHeight: 30,
                    maxWidth: 40,
                  ),
                ),
                style: const TextStyle(
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

