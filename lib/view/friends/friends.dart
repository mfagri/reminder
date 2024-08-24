import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remindly/helpers/icon_constants.dart';
import 'package:remindly/helpers/utils.dart';
import 'package:remindly/model_view/friend_provider.dart';
import 'package:remindly/view/friends/friends_item.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FriendProvider>(
      builder: (context, friendprovider, child) => Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        appBar: AppBar(
          backgroundColor: const Color(0xffE3E3E3),
          scrolledUnderElevation: 0,
          title: Row(
            children: [
              const Text(
                'Friends',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/addfriends');
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xff1488CC),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Center(
                    child: appIcon(IconsConstants.add, false, context, 15, 15,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: friendprovider.getFriends(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Color(0xff1488CC),
                  );
                }
                if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text(
                    'No friends found.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: friendprovider.friends.length,
                    itemBuilder: (context, index) {
                      return FrindsItem(
                        user: friendprovider.friends[index],
                      );
                    },
                  ),
                );
              },
            )
          ],
        )),
      ),
    );
  }
}
