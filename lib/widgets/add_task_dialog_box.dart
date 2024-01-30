import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({Key? key, required this.onAddPressed}) : super(key: key);
  final void Function(Color color, String title, String? description)
      onAddPressed;

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  late Color selectedColor;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? titleError;

  @override
  void initState() {
    super.initState();
    selectedColor = Colors.deepPurple;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            'Add Task',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              fontSize: 15.sp,
            ),
          ),
          content: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20.w),
                  width: 4,
                  decoration: BoxDecoration(
                    color: selectedColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          errorText: titleError,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      TextField(
                        controller: descriptionController,
                        maxLines: 2,
                        autocorrect: false,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Radio<Color>(
                              fillColor: const MaterialStatePropertyAll(
                                  Colors.deepPurple),
                              focusColor: Colors.deepPurple,
                              value: Colors.deepPurple,
                              groupValue: selectedColor,
                              onChanged: (color) {
                                setState(() => selectedColor = color!);
                              },
                            ),
                            Radio<Color>(
                              fillColor:
                                  const MaterialStatePropertyAll(Colors.orange),
                              focusColor: Colors.orange,
                              value: Colors.orange,
                              groupValue: selectedColor,
                              onChanged: (color) {
                                setState(() => selectedColor = color!);
                              },
                            ),
                            Radio<Color>(
                              fillColor:
                                  const MaterialStatePropertyAll(Colors.blue),
                              focusColor: Colors.blue,
                              value: Colors.blue,
                              groupValue: selectedColor,
                              onChanged: (color) {
                                setState(() => selectedColor = color!);
                              },
                            ),
                            Radio<Color>(
                              fillColor:
                                  const MaterialStatePropertyAll(Colors.red),
                              focusColor: Colors.red,
                              value: Colors.red,
                              groupValue: selectedColor,
                              onChanged: (color) {
                                setState(() => selectedColor = color!);
                              },
                            ),
                            Radio<Color>(
                              fillColor:
                                  const MaterialStatePropertyAll(Colors.green),
                              focusColor: Colors.green,
                              value: Colors.green,
                              groupValue: selectedColor,
                              onChanged: (color) {
                                setState(() => selectedColor = color!);
                              },
                            ),
                            Radio<Color>(
                              fillColor:
                                  const MaterialStatePropertyAll(Colors.brown),
                              focusColor: Colors.brown,
                              value: Colors.brown,
                              groupValue: selectedColor,
                              onChanged: (color) {
                                setState(() => selectedColor = color!);
                              },
                            ),
                            Radio<Color>(
                              fillColor:
                                  const MaterialStatePropertyAll(Colors.yellow),
                              focusColor: Colors.yellow,
                              value: Colors.yellow,
                              groupValue: selectedColor,
                              onChanged: (color) {
                                setState(() => selectedColor = color!);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () {
                if (titleController.text.isEmpty) {
                  setState(() {
                    titleError = 'Title cannot be empty';
                  });
                } else {
                  widget.onAddPressed(
                    selectedColor,
                    titleController.text,
                    descriptionController.text.isEmpty
                        ? null
                        : descriptionController.text,
                  );
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
