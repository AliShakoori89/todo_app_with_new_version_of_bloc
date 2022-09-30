import 'package:equatable/equatable.dart';
import 'package:todo_app_with_new_version_bloc/model/task_model.dart';

class TaskFromNetEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetAllTaskEvent extends TaskFromNetEvent {
  GetAllTaskEvent();
}

class AddNewTaskEvent extends TaskFromNetEvent {
  final TaskModel taskModel;

  AddNewTaskEvent({required this.taskModel});

  @override
  List<Object> get props => [taskModel];
}

class DeleteTaskEvent extends TaskFromNetEvent{
  final int id;

  DeleteTaskEvent(this.id);
  @override
  List<Object> get props => [id];
}

class EditTaskEvent extends TaskFromNetEvent{
  final TaskModel taskModel;

  EditTaskEvent({required this.taskModel});

  @override
  List<Object> get props => [taskModel];
}