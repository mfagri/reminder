// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remindly/helpers/utils.dart';
import 'package:remindly/model/task.dart';
import 'package:remindly/model_view/task_provider.dart';

class ShowTask extends StatefulWidget {
  Task task;
  ShowTask({super.key, required this.task});

  @override
  State<ShowTask> createState() => _ShowTaskState();
}

class _ShowTaskState extends State<ShowTask> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskprovider, child) => Scaffold(
        appBar: myAppbar(context, "Task"),
        backgroundColor: const Color(0xffF2F2F2),
        body: Container(
          padding: const EdgeInsets.all(24),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task name',
                style: TextStyle(
                  color: const Color(0xFF131212).withOpacity(0.5),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TaskInfo(
                widget: widget,
                content: widget.task.name ?? 'no name',
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Task description',
                style: TextStyle(
                  color: const Color(0xFF131212).withOpacity(0.5),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TaskInfo(
                widget: widget,
                content: widget.task.description ?? 'no description',
                maxline: 5,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Task start date',
                style: TextStyle(
                  color: const Color(0xFF131212).withOpacity(0.5),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TaskInfo(
                widget: widget,
                content: formattedDate(DateTime.parse(widget.task.startDate!)),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Task reminder time',
                style: TextStyle(
                  color: const Color(0xFF131212).withOpacity(0.5),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TaskInfo(
                widget: widget,
                content: widget.task.reminderTime!.toString(),
              ),
              const SizedBox(
                height: 20,
              ),
              //accept button and reject button
              if (widget.task.status == 'pending')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        bool b = await taskprovider.updateTask(
                            widget.task.sId!, 'in progress');
                        if (b) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Task accepted'),
                            ),
                          );
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: const Color(0xff5F4BA3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Accept',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        bool b = await taskprovider.updateTask(
                            widget.task.sId!, 'rejected');
                        if (b) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Task rejected'),
                            ),
                          );
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Reject',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ///done button if task status is in progress
              if (widget.task.status == 'in progress')
                InkWell(
                  onTap: () async {
                    bool b =
                        await taskprovider.updateTask(widget.task.sId!, 'done');
                    if (b) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Task done'),
                        ),
                      );
                      setState(() {});
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 85, 163, 75),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              if (widget.task.status == 'done') ...[
                const SizedBox(
                  height: 25,
                ),
                //this task is done message
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'This task is done',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
              if (widget.task.status == 'rejected') ...[
                const SizedBox(
                  height: 25,
                ),
                //this task is rejected message
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'This task is rejected',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class TaskInfo extends StatelessWidget {
  String content;
  int maxline;

  TaskInfo({
    super.key,
    required this.widget,
    required this.content,
    this.maxline = 1,
  });

  final ShowTask widget;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: content),
      cursorColor: Colors.black,
      maxLines: maxline,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        focusColor: const Color(0xFFC4C4C4),
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Color(0xFFC4C4C4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Color(0xFFC4C4C4),
          ),
        ),
      ),
    );
  }
}
