import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:myapp/helpers/icon_constants.dart';
import 'package:myapp/helpers/utils.dart';
import 'package:myapp/view/task/widget/friends_dropdown.dart';
import 'package:myapp/view/task/widget/time_dropdown.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  bool me = true;
  DateTime selectedDate = DateTime.now();

  //munites List
  List<String> munites = [
    '1',
    '5',
    '10',
    '15',
    '30',
    '45',
    '60',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      resizeToAvoidBottomInset: true,
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
                    'Create Task',
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
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 14,
                right: 14,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'For',
                    style: TextStyle(
                      color: Color(0xFF131212),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFC4C4C4)),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                me = true;
                              });
                            },
                            child: Container(
                              color:
                                  me ? const Color(0xff1488CC) : Colors.white,
                              child: Center(
                                child: Text(
                                  'me',
                                  style: TextStyle(
                                    color: me
                                        ? Colors.white
                                        : const Color(0xff1488CC),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                me = false;
                              });
                            },
                            child: Container(
                              color:
                                  !me ? const Color(0xff1488CC) : Colors.white,
                              child: Center(
                                child: Text(
                                  'friend',
                                  style: TextStyle(
                                    color: !me
                                        ? Colors.white
                                        : const Color(0xff1488CC),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (!me)
              const SizedBox(
                height: 20,
              ),
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1419541801.
            if (!me)
              //drop down
              const Padding(
                  padding: EdgeInsets.symmetric(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:275912587.
                    horizontal: 14,
                  ),
                  child: FriendsDropdown()),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                          color: Color(0xFF131212),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      onTap: () async {
                        DateTime? dateTime = await showOmniDateTimePicker(
                          theme: ThemeData(
                            primaryColor: const Color(0xff1488CC),
                            colorScheme: const ColorScheme.light(
                              primary: Color(0xff1488CC),
                            ),
                          ),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1600)
                              .subtract(const Duration(days: 3652)),
                          lastDate: DateTime.now().add(
                            const Duration(days: 3652),
                          ),
                          is24HourMode: false,
                          isShowSeconds: false,
                          minutesInterval: 1,
                          secondsInterval: 1,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          constraints: const BoxConstraints(
                            maxWidth: 350,
                            maxHeight: 650,
                          ),
                          transitionBuilder: (context, anim1, anim2, child) {
                            return FadeTransition(
                              opacity: anim1.drive(
                                Tween(
                                  begin: 0,
                                  end: 1,
                                ),
                              ),
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 200),
                          barrierDismissible: true,
                        );

                        setState(() {
                          selectedDate = dateTime!;
                        });
                      },
                      readOnly: true, //can be changed to false
                      decoration: InputDecoration(
                        hintText:
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year} ${selectedDate.hour}:${selectedDate.minute}',
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: SizedBox(
                          height: 20,
                          width: 20,
                          child: Center(
                            child: appIcon(
                                IconsConstants.monthly, false, context, 20, 20),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: const BorderSide(
                            color: Color(0xFFC4C4C4),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: const BorderSide(
                            color: Color(0xFFC4C4C4),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time  to remaind',
                    style: TextStyle(
                      color: Color(0xFF131212),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  TimeWidget(),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Container(
                height: 44,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xff5F4BA3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    'Create',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Container(
                height: 44,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xff1488CC),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    appIcon(IconsConstants.send, false, context, 15, 15),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Send Reminder',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
