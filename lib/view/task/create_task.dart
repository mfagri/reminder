import 'package:flutter/material.dart';
import 'package:myapp/helpers/utils.dart';
import 'package:myapp/view/task/widget/input_widget.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:myapp/helpers/icon_constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _buildInputFields(),
              const SizedBox(height: 20),
              _buildForSection(),
              if (!me) const SizedBox(height: 20),
              if (!me) const FriendsDropdown(),
              const SizedBox(height: 20),
              _buildDatePicker(context),
              const SizedBox(height: 20),
              const _TaskTimeReminder(),
              const SizedBox(height: 20),
              _buildActionButton('Create', 0xff5F4BA3),
              const SizedBox(height: 20),
              _buildActionButtonWithIcon(
                  'Send Reminder', 0xff1488CC, IconsConstants.send),
              const SizedBox(height: 20),
            ],
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

  Widget _buildDatePicker(BuildContext context) {
    return Column(
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
                firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
                lastDate: DateTime.now().add(const Duration(days: 3652)),
                is24HourMode: false,
                minutesInterval: 1,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                constraints:
                    const BoxConstraints(maxWidth: 350, maxHeight: 650),
                barrierDismissible: true,
              );

              setState(() {
                if (dateTime != null) selectedDate = dateTime;
              });
            },
            readOnly: true,
            decoration: InputDecoration(
              hintText:
                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year} ${selectedDate.hour}:${selectedDate.minute}',
              hintStyle: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Center(
                  child:
                      appIcon(IconsConstants.monthly, false, context, 20, 20)),
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
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        InputWidget(
            name: 'Task Name',
            controller: TextEditingController(),
            isDescription: false),
        const SizedBox(height: 20),
        InputWidget(
            name: 'Task Description',
            controller: TextEditingController(),
            isDescription: true),
      ],
    );
  }

  Widget _buildActionButton(String label, int color) {
    return Container(
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
  const _TaskTimeReminder();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Time to remind', style: _labelStyle),
        SizedBox(height: 8),
        TimeWidget(),
      ],
    );
  }
}
