import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/universal_provider.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool _isClicked = false;
  late Color color;

  @override
  void initState() {
    color = Color.fromARGB(widget.taskModel.argb[0], widget.taskModel.argb[1],
        widget.taskModel.argb[2], widget.taskModel.argb[3]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UniversalProvider>(
        builder: (context, universalProvider, child) {
      color = Color.fromARGB(
        widget.taskModel.argb[0],
        widget.taskModel.argb[1],
        widget.taskModel.argb[2],
        widget.taskModel.argb[3],
      );
      return InkWell(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        onTap: () => setState(() => _isClicked = !_isClicked),
        child: AnimatedContainer(
          key: GlobalKey(),
          duration: const Duration(seconds: 1000),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 10.w,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      width: 4,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.r),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.taskModel.title,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                            ),
                          ),
                          if (widget.taskModel.description != null)
                            SizedBox(
                              height: 10.h,
                            ),
                          if (widget.taskModel.description != null)
                            Text(
                              widget.taskModel.description!,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (_isClicked)
                SizedBox(
                  height: 10.h,
                ),
              if (_isClicked)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      widget.taskModel.status != 'Completed'
                          ? IconButton(
                              onPressed: () =>
                                  universalProvider.updateTaskStatus(
                                      widget.taskModel.id, 'Completed'),
                              icon: Icon(
                                Icons.task_alt_rounded,
                                color: color,
                              ),
                            )
                          : IconButton(
                              onPressed: () =>
                                  universalProvider.updateTaskStatus(
                                      widget.taskModel.id, 'Incomplete'),
                              icon: Icon(
                                Icons.restart_alt_rounded,
                                color: color,
                              ),
                            ),
                      IconButton(
                        onPressed: () =>
                            universalProvider.deleteTask(widget.taskModel.id),
                        icon: Icon(
                          Icons.delete,
                          color: color,
                        ),
                      ),
                      IconButton(
                        onPressed: () => universalProvider.showEditTaskDialog(
                            context, widget.taskModel),
                        icon: Icon(
                          Icons.edit_note_rounded,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
