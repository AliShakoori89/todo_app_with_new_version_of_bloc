import 'package:equatable/equatable.dart';
import 'package:todo_app_with_new_version_bloc/model/task_model.dart';

enum TaskFromNetStatus { initial, success, error, loading }

extension MedicineStatusX on TaskFromNetStatus {
  bool get isInitial => this == TaskFromNetStatus.initial;
  bool get isSuccess => this == TaskFromNetStatus.success;
  bool get isError => this == TaskFromNetStatus.error;
  bool get isLoading => this == TaskFromNetStatus.loading;
}

class TaskFromNetState extends Equatable {

  const TaskFromNetState({
    this.status = TaskFromNetStatus.initial,
    List<TaskModel>? allTask,
  }): allTask = allTask ?? const [];

  final TaskFromNetStatus status;
  final List<TaskModel> allTask;

  @override
  // TODO: implement props
  List<Object> get props => [status, allTask];

  TaskFromNetState copyWith({
    TaskFromNetStatus? status,
    List<TaskModel>? allTask
  }) {
    return TaskFromNetState(
      status: status ?? this.status,
      allTask: allTask ?? this.allTask,
    );
  }
}