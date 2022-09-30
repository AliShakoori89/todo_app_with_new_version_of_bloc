import 'package:equatable/equatable.dart';
import 'package:todo_app_with_new_version_bloc/model/task_model.dart';
import 'package:todo_app_with_new_version_bloc/model/task_model_for_data_base.dart';

class TaskFromDataBaseEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetAllTaskEvent extends TaskFromDataBaseEvent {}

class AddNewTaskEvent extends TaskFromDataBaseEvent {
  final TaskModel taskModel;

  AddNewTaskEvent({required this.taskModel});

  @override
  List<Object> get props => [taskModel];
}

class DeleteTaskEvent extends TaskFromDataBaseEvent{
  final int id;

  DeleteTaskEvent(this.id);
  @override
  List<Object> get props => [id];
}

class EditTaskEvent extends TaskFromDataBaseEvent{
  final TaskForDataBaseModel taskForDataBaseModel;

  EditTaskEvent({required this.taskForDataBaseModel});

  @override
  List<Object> get props => [taskForDataBaseModel];
}