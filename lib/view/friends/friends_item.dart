import 'package:flutter/material.dart';
import 'package:remindly/model/search_user.dart';

class FrindsItem extends StatelessWidget {
  Searchuser user;
  FrindsItem({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: const Color(0xffE0E0E0),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 17,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: const Color(0xffD4EFFF),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(user.image.toString()),
                    fit: BoxFit.cover),
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
                  user.name.toString(),
                  style: const TextStyle(
                    color: Color(0xFF313131),
                    fontSize: 13,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  user.email.toString(),
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
    );
  }
}
