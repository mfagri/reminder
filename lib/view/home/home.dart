import 'package:flutter/material.dart';
import 'package:myapp/helpers/icon_constants.dart';
import 'package:myapp/helpers/utils.dart';
import 'package:myapp/view/home/widget/app_bar.dart';
import 'package:myapp/view/home/widget/status_item.dart';

import '../../model/status_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Status> status = [
  Status(
      title: 'Pending',
      icon: IconsConstants.pause,
      color: const Color(0xffD4EFFF),
      value: '4'),
  Status(
      title: 'Done',
      icon: IconsConstants.done,
      color: const Color(0xffBFFFC9),
      value: '1'),
  Status(
      title: 'Progress',
      icon: IconsConstants.inprogress,
      color: const Color(0xffFFEDAA),
      value: '2')
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffF2F2F2),
      appBar: appBar(context),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              padding: const EdgeInsets.only(right: 14),
              itemCount: status.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return statusItem(status[index], context);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3671788434.
          Expanded(
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(bottom: 10),
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
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xffD4EFFF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: appIcon(IconsConstants.task, false,
                                    context, 20, 20),
                              ),
                            ),
                            const SizedBox(
                              width: 17,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 40,
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'tfi 3la tajin',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Color(0xFF313131),
                                      fontSize: 13,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'By mfagri',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Color(0xFF717171),
                                      fontSize: 12,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                }),
          ),
        ],
      )),
    );
  }
}
