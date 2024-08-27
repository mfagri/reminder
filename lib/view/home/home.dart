import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remindly/helpers/icon_constants.dart';
import 'package:remindly/helpers/utils.dart';
import 'package:remindly/model_view/task_provider.dart';
import 'package:remindly/view/home/widget/app_bar.dart';
import 'package:remindly/view/home/widget/status_item.dart';
import 'package:remindly/view/task/show_task.dart';
import '../../model/status_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String selectedStatus = 'pending';
Status selectedStatusModel = status[0];

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
      title: 'In Progress',
      icon: IconsConstants.inprogress,
      color: const Color(0xffFFEDAA),
      value: '2'),
  Status(
      title: 'Rejected',
      icon: IconsConstants.close,
      color: const Color(0xffFFD1D1),
      value: '3'),
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskprovider, child) => Scaffold(
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
                  return InkWell(
                      onTap: () {
                        setState(() {
                          selectedStatus = status[index].title.toLowerCase();
                          selectedStatusModel = status[index];
                        });
                      },
                      child: statusItem(
                          status[index],
                          selectedStatus == status[index].title.toLowerCase(),
                          context));
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: taskprovider.getUserTasks(),
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
                  return const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No tasks found.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowTask(
                                task: snapshot.data![index],
                              ),
                            ),
                          );
                        },
                        child: Visibility(
                          visible:
                              snapshot.data![index].status!.toLowerCase() ==
                                  selectedStatus,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              padding: const EdgeInsets.all(10),
                              // height: 60,
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
                                      color: selectedStatusModel.color,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: appIcon(
                                        IconsConstants.task,
                                        false,
                                        context,
                                        20,
                                        20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 17,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    height: 40,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].name != null
                                              ? snapshot.data![index].name!
                                              : 'No name',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            color: Color(0xFF313131),
                                            fontSize: 13,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data![index].createdBy !=
                                                  null
                                              ? snapshot
                                                  .data![index].createdBy!.name!
                                              : 'No name',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
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
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            // Suggested code may be subject to a license. Learn more: ~LicenseLog:3671788434.
          ],
        )),
      ),
    );
  }
}
