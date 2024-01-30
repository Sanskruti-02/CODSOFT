import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/models/task_model.dart';

class EditTaskDialog extends StatefulWidget {
  const EditTaskDialog(
      {Key? key, required this.onSavePressed, required this.taskModel})
      : super(key: key);
  final void Function(TaskModel taskModel) onSavePressed;

  final TaskModel taskModel;

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late Color selectedColor;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? titleError;

  @override
  void initState() {
    selectedColor = Color.fromARGB(
      widget.taskModel.argb[0],
      widget.taskModel.argb[1],
      widget.taskModel.argb[2],
      widget.taskModel.argb[3],
    );
    titleController.text = widget.taskModel.title;
    descriptionController.text = widget.taskModel.description ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            'Edit Task',
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
                              value: const Color.fromARGB(255, 103, 58, 183),
                              groupValue: selectedColor,
                              onChanged: (color) {
                                setState(() => selectedColor = color!);
                              },
                            ),
                            Radio<Color>(
                              fillColor:
                                  const MaterialStatePropertyAll(Colors.orange),
                              focusColor: Colors.orange,
                              value: const Color.fromARGB(255, 255, 152, 0),
                              groupValue: selectedColor,
                              onChanged: (color) {
                                setState(() => selectedColor = color!);
                              },
                            ),
                            Radio<Color>(
                              fillColor:
                                  const MaterialStatePropertyAll(Colors.blue),
                              focusColor: Colors.blue,
                              value: const Color.fromARGB(255, 33, 150, 243),
                              groupValue: selectedColor,
                              onChanged: (color) {
                                setState(() => selectedColor = color!);
                              },
                            ),
                            Radio<Color>(
                              fillColor:
                                  const MaterialStatePropertyAll(Colors.red),
                              focusColor: Colors.red,
                              value: const Color.fromARGB(255, 244, 67, 54),
                              groupValue: selectedColor,
                              onChanged: (color) {
                                setState(() => selectedColor = color!);
                              },
                            ),
                            Radio<Color>(
                              fillColor:
                                  const MaterialStatePropertyAll(Colors.green),
                              focusColor: Colors.green,
                              value: const Color.fromARGB(255, 76, 175, 80),
                              groupValue: selectedColor,
                              onChanged: (color) {
                                setState(() => selectedColor = color!);
                              },
                            ),
                            Radio<Color>(
                              fillColor:
                                  const MaterialStatePropertyAll(Colors.brown),
                              focusColor: Colors.brown,
                              value: const Color.fromARGB(255, 121, 85, 72),
                              groupValue: selectedColor,
                              onChanged: (color) {
                                setState(() => selectedColor = color!);
                              },
                            ),
                            Radio<Color>(
                              fillColor:
                                  const MaterialStatePropertyAll(Colors.yellow),
                              focusColor: Colors.yellow,
                              value: const Color.fromARGB(255, 255, 235, 59),
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
                  widget.taskModel.title = titleController.text;
                  widget.taskModel.description =
                      descriptionController.text.isEmpty
                          ? null
                          : descriptionController.text;
                  widget.taskModel.argb = [
                    selectedColor.alpha,
                    selectedColor.red,
                    selectedColor.green,
                    selectedColor.blue
                  ];
                  widget.onSavePressed(widget.taskModel);
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Save',
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
