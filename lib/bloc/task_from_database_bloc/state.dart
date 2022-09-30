import 'package:equatable/equatable.dart';
import 'package:todo_app_with_new_version_bloc/model/task_model_for_data_base.dart';

enum TaskFromDataBaseStatus { initial, success, error, loading }

extension MedicineStatusX on TaskFromDataBaseStatus {
  bool get isInitial => this == TaskFromDataBaseStatus.initial;
  bool get isSuccess => this == TaskFromDataBaseStatus.success;
  bool get isError => this == TaskFromDataBaseStatus.error;
  bool get isLoading => this == TaskFromDataBaseStatus.loading;
}

class TaskFromDataBaseState extends Equatable {

  const TaskFromDataBaseState({
    this.status = TaskFromDataBaseStatus.initial,
    List<TaskForDataBaseModel>? allTask,
  }): allTask = allTask ?? const [];

  final TaskFromDataBaseStatus status;
  final List<TaskForDataBaseModel> allTask;

  @override
  // TODO: implement props
  List<Object> get props => [status, allTask];

  TaskFromDataBaseState copyWith({
    TaskFromDataBaseStatus? status,
    List<TaskForDataBaseModel>? allTask
  }) {
    return TaskFromDataBaseState(
      status: status ?? this.status,
      allTask: allTask ?? this.allTask,
    );
  }
}