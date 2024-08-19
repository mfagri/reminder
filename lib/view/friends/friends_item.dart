
import 'package:flutter/material.dart';

class FrindsItem extends StatelessWidget {
  const FrindsItem({
    super.key,
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
                image: const DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/564x/02/ec/e0/02ece05f715a0c64cf3a4c6c443a924c.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              width: 17,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Marouane fagri',
                  style: TextStyle(
                    color: Color(0xFF313131),
                    fontSize: 13,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '@mfagri',
                  style: TextStyle(
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
