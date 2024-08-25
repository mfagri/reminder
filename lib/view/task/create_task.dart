// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remindly/helpers/utils.dart';
import 'package:remindly/model_view/auth_provider.dart';
import 'package:remindly/model_view/friend_provider.dart';
import 'package:remindly/model_view/task_provider.dart';
import 'package:remindly/view/task/widget/input_widget.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:remindly/helpers/icon_constants.dart';
import 'package:remindly/view/task/widget/friends_dropdown.dart';
import 'package:remindly/view/task/widget/time_dropdown.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  bool me = true;
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  int selectedTime = 20;
  String selectedFriend = 'select friend';
  @override
  void initState() {
    Provider.of<FriendProvider>(context, listen: false).getfriends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        resizeToAvoidBottomInset: true,
        appBar: myAppbar(context, "Create Task"),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                buildInputFields(),
                const SizedBox(height: 20),
                _buildForSection(),
                if (!me) const SizedBox(height: 20),
                if (!me) FriendsDropdown(iduser: selectedFriend),
                const SizedBox(height: 20),
                _buildDatePicker(context),
                const SizedBox(height: 20),
                _TaskTimeReminder(
                  selectedTime: selectedTime,
                ),
                const SizedBox(height: 20),
                _buildActionButton('Create', 0xff5F4BA3, context),
                const SizedBox(height: 20),
                _buildActionButtonWithIcon(
                    'Send Reminder', 0xff1488CC, IconsConstants.send),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('For', style: _labelStyle),
        const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: const Color(0xFFC4C4C4)),
          ),
          child: Row(
            children: ['me', 'friend'].map((option) {
              final isMe = option == 'me';
              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => me = isMe),
                  child: Container(
                    color: (isMe && me) || (!isMe && !me)
                        ? const Color(0xff1488CC)
                        : Colors.white,
                    height: 40,
                    child: Center(
                      child: Text(option, style: _getOptionTextStyle(isMe)),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

// Suggested code may be subject to a license. Learn more: ~LicenseLog:3290925913.
  Widget _buildDatePicker(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Date', style: _labelStyle),
          const SizedBox(height: 6),
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
                  firstDate:
                      DateTime(1600).subtract(const Duration(days: 3652)),
                  lastDate: DateTime.now().add(const Duration(days: 3652)),
                  is24HourMode: false,
                  minutesInterval: 1,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  constraints:
                      const BoxConstraints(maxWidth: 350, maxHeight: 650),
                  barrierDismissible: true,
                );

                setState(() {
                  if (dateTime != null) {
                    value.setselectedDate(dateTime);
                    value.setDate('${dateTime.toIso8601String()}Z');
                  }
                });
              },
              readOnly: true,
              decoration: InputDecoration(
                hintText:
                    '${value.selectedDate.day}/${value.selectedDate.month}/${value.selectedDate.year} ${value.selectedDate.hour}:${value.selectedDate.minute}',
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: Center(
                    child: appIcon(
                        IconsConstants.monthly, false, context, 20, 20)),
                prefixIconConstraints: const BoxConstraints(
                  maxHeight: 40,
                  maxWidth: 50,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(color: Color(0xFFC4C4C4)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, int color, BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) => InkWell(
        onTap: () async {
          if (value.titleController.text.isEmpty ||
              value.descriptionController.text.isEmpty ||
              value.date == null ||
              value.remindertime == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please fill all fields'),
              ),
            );
            return;
          }
          if (!me && value.id.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select a friend'),
              ),
            );
            return;
          }
          loadingWidget(context);
          try {
            await Provider.of<TaskProvider>(context, listen: false).createTask(
              value.titleController.text,
              value.descriptionController.text,
              value.date!,
              me
                  ? Provider.of<AuthProvider>(context, listen: false)
                      .user!
                      .sId
                      .toString()
                  : value.id,
              value.remindertime,
            );
          } catch (e) {
            if (mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    e.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }
            return;
          }
          if (mounted) {
            Navigator.pop(context);
          }
          if (mounted) {
            Navigator.pop(context);
          }
        },
        child: Container(
          height: 44,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(color),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtonWithIcon(String label, int color, String icon) {
    return Container(
      height: 44,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appIcon(icon, false, context, 15, 15),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _getOptionTextStyle(bool isMe) {
    return TextStyle(
      color: (isMe && me) || (!isMe && !me)
          ? Colors.white
          : const Color(0xff1488CC),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }
}

const TextStyle _labelStyle = TextStyle(
  color: Color(0xFF131212),
  fontSize: 14,
  fontWeight: FontWeight.w500,
  fontFamily: 'Roboto',
);

class _TaskTimeReminder extends StatelessWidget {
  int selectedTime = 20;
  _TaskTimeReminder({
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Time to remind  (default is 30)', style: _labelStyle),
        const SizedBox(height: 8),
        TimeWidget(
          reminderTime: selectedTime,
        ),
      ],
    );
  }
}
