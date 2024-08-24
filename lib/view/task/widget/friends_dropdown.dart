// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remindly/helpers/icon_constants.dart';
import 'package:remindly/helpers/utils.dart';
import 'package:remindly/model_view/friend_provider.dart';
import 'package:remindly/model_view/task_provider.dart';

class FriendsDropdown extends StatefulWidget {
  String iduser = '';
  FriendsDropdown({
    super.key,
    required this.iduser,
  });

  @override
  State<FriendsDropdown> createState() => _FriendsDropdownState();
}

class _FriendsDropdownState extends State<FriendsDropdown> {
  String friend = 'select friend';
  @override
  void initState() {
    Provider.of<FriendProvider>(context, listen: false).getFriends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<FriendProvider, TaskProvider>(
        builder: (context, value, value2, child) {
      if (value.friends.isEmpty) {
        return const SizedBox();
      }
      return SizedBox(
        height: 40,
        child: DropdownMenu(
          enableSearch: true,
          menuStyle: const MenuStyle(
            backgroundColor: WidgetStatePropertyAll(
              Color(0xffFFFFFF),
            ),
          ),
          trailingIcon: SizedBox(
            width: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                appIcon(IconsConstants.down, false, context, 8, 6),
              ],
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            constraints: const BoxConstraints(
              minHeight: 40,
              maxHeight: 40,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xffC4C4C4),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          width: MediaQuery.of(context).size.width -
              28, //28 because of padding 14 in left and right
          menuHeight: MediaQuery.of(context).size.height * 0.6,
          hintText: friend,
          initialSelection: friend,
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
          onSelected: (String? item) {
            value2.setId(item.toString());
          },
          dropdownMenuEntries: [
            if (value.friends.isNotEmpty)
              for (int i = 0; i < value.friends.length; i++)
                DropdownMenuEntry(
                  value: value.friends[i].sId.toString(),
                  label: value.friends[i].name.toString(),
                  style: ButtonStyle(
                    textStyle: WidgetStateProperty.all(
                      const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  labelWidget: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: const Color(0xffC4C4C4),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xffD4EFFF),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                  value.friends[i].image.toString(),
                                ),
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
                                value.friends[i].name.toString(),
                                style: const TextStyle(
                                  color: Color(0xFF313131),
                                  fontSize: 13,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                value.friends[i].email.toString(),
                                style: const TextStyle(
                                  color: Color(0xFF717171),
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
          ],
        ),
      );
    });
  }
}
