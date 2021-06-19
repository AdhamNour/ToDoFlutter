import 'package:flutter/material.dart';
import 'package:todo/Models/Task.dart';
import 'package:todo/components/TaskList/TaskList.dart';

class TaskListItemContent extends StatefulWidget {
  final Task targetTask;
  const TaskListItemContent({ Key? key , required this.targetTask}) : super(key: key);

  @override
  _TaskListItemContentState createState() => _TaskListItemContentState();
}

class _TaskListItemContentState extends State<TaskListItemContent> {

  bool? checked;
  bool expanded = false;
  Function(bool?)? setChecked;
  @override
  void initState() {
    checked = widget.targetTask.done;
    setChecked = (newValue) {
      setState(() {
        widget.targetTask.done = newValue;
        checked = newValue;
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Card(
      child: Container(
        child: Column(
          children: [
            ListTile(
              leading: Checkbox(
                value: checked,
                onChanged: setChecked,
              ),
              title: Text(widget.targetTask.title),
              trailing: widget.targetTask.children.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        expanded = !expanded;
                      },
                      icon: Icon(Icons.arrow_drop_down))
                  : null,
            ),
            if (expanded)
              Container(
                child: TaskList(parent: widget.targetTask.id),
                height: screenSize.height * 0.40,
              )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
      elevation: 3,
    );
  }
}