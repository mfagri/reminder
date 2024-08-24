import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remindly/helpers/utils.dart';
import 'package:remindly/model_view/friend_provider.dart';
import 'package:remindly/services/friend_server.dart';
import 'package:remindly/view/friends/friends_item.dart';
import 'package:remindly/view/friends/scan_view.dart';
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
    return Consumer<FriendProvider>(
      builder: (context, friendProvider, child) => Scaffold(
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
                  onChanged: (name) async {
                    loadingWidget(context);
                    await friendProvider.searchUser(name).then((value) {
                      Navigator.pop(context);
                    });
                  },
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
              if (friendProvider.users.isEmpty)
                const Text(
                  'No Friends Found',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              Expanded(
                child: ListView.builder(
                    itemCount: friendProvider.users.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          loadingWidget(context);
                          await FriendServer.addFriend(
                                  friendProvider.users[index].sId.toString())
                              .then(
                            (value) {
                              Navigator.pop(context);
                            },
                          );
                        },
                        child: FrindsItem(
                          user: friendProvider.users[index],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
