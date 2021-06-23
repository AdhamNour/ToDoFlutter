import 'package:flutter/cupertino.dart';
import 'package:todo/Models/Task.dart';
import 'package:todo/data/moor_database.dart';

class Tasks extends ChangeNotifier {
  //TODO: add the task manipulation to all functions
  List<Task> _tasks = [];
  final db = AppDatabase();
  Tasks() {
    db.watchTasks().listen((event) {
      _tasks=event.map((e) => Task(
          title: e.title,
          deadline: e.deadline,
          done: e.done,
          haschildren: e.hasChildren,
          parent: e.parent,
          id: e.id)).toList();
    });
  }
  List<Task> tasks({int? parent}) {
    return [..._tasks.where((element) => element.parent == parent).toList()];
  }

  void addTask({required String taskName, DateTime? deadline, int? parent}) {
    _tasks.add(Task(
        title: taskName,
        id: _tasks.length,
        parent: parent,
        deadline: deadline));
    if (parent != null) {
      _tasks[parent].haschildren = true;
    }
    notifyListeners();
  }

  void changeTitleOfTask({required String taskName, required int id}) {
    _tasks[id].title = taskName;
    notifyListeners();
  }

  void setParentOf({int? parentID, required int childID}) {
    int? prevParent = _tasks[childID].parent;
    _tasks[childID].parent = parentID;
    if (parentID != null) {
      _tasks[parentID].haschildren =
          _tasks.indexWhere((element) => element.parent == parentID) != -1;
    }
    if (prevParent != null) {
      _tasks[prevParent].haschildren =
          _tasks.indexWhere((element) => element.parent == prevParent) != -1;
    }
    notifyListeners();
  }

  void setDoneForAllChildrenof({required int parentID, required bool? value}) {
    List<Task> targetTasks =
        _tasks.where((element) => element.parent == parentID).toList();
    for (var i = 0; i < targetTasks.length; i++) {
      targetTasks = [
        ...targetTasks,
        ..._tasks
            .where((element) => element.parent == targetTasks[i].id)
            .toList()
      ];
      int x = targetTasks[i].id ?? -1;
      _tasks[x].done = value;
    }
    notifyListeners();
  }

  void setTitleOf({required int id, required String newTitle}) {
    _tasks[id].title = newTitle;
    notifyListeners();
  }

  void setDeadLineof({required int id, DateTime? newDeadline}) {
    _tasks[id].deadline = newDeadline;
    notifyListeners();
  }
}
