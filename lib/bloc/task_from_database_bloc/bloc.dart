import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_new_version_bloc/bloc/task_from_database_bloc/event.dart';
import 'package:todo_app_with_new_version_bloc/bloc/task_from_database_bloc/state.dart';
import 'package:todo_app_with_new_version_bloc/model/task_model_for_data_base.dart';
import 'package:todo_app_with_new_version_bloc/repository/task_repository.dart';

class TaskFromDataBaseBloc extends Bloc<TaskFromDataBaseEvent, TaskFromDataBaseState>{
  final TaskRepository taskRepository;

  TaskFromDataBaseBloc(this.taskRepository): super(const TaskFromDataBaseState()){
    on<GetAllTaskEvent>(_mapGetAllTaskEventToState);
    on<AddNewTaskEvent>(_mapAddNewTaskEventToState);
    on<DeleteTaskEvent>(_mapDeleteTaskEventToState);
    on<EditTaskEvent>(_mapEditTaskEventToState);
  }

  void _mapGetAllTaskEventToState(
      GetAllTaskEvent event, Emitter<TaskFromDataBaseState> emit) async {
    try{
      emit(state.copyWith(status: TaskFromDataBaseStatus.loading));
      List<TaskForDataBaseModel> allTask = await taskRepository.getAllTaskFromDataBase();
      emit(
        state.copyWith(
          status: TaskFromDataBaseStatus.success,
          allTask: allTask
        )
      );
    }catch (error){
      emit(state.copyWith(status: TaskFromDataBaseStatus.error));
    }
  }

  void _mapAddNewTaskEventToState(
      AddNewTaskEvent event, Emitter<TaskFromDataBaseState> emit) async {
    try{
      emit(state.copyWith(status: TaskFromDataBaseStatus.loading));
      await taskRepository.addTask(event.taskModel);
      emit(
          state.copyWith(
              status: TaskFromDataBaseStatus.success,
          )
      );
    }catch (error){
      emit(state.copyWith(status: TaskFromDataBaseStatus.error));
    }
  }

  void _mapDeleteTaskEventToState(
      DeleteTaskEvent event, Emitter<TaskFromDataBaseState> emit) async {
    try{
      emit(state.copyWith(status: TaskFromDataBaseStatus.loading));
      await taskRepository.deleteTask(event.id);
      emit(
          state.copyWith(
            status: TaskFromDataBaseStatus.success,
          )
      );
    }catch (error){
      emit(state.copyWith(status: TaskFromDataBaseStatus.error));
    }
  }

  void _mapEditTaskEventToState(
      EditTaskEvent event, Emitter<TaskFromDataBaseState> emit) async {
    try{
      emit(state.copyWith(status: TaskFromDataBaseStatus.loading));
      await taskRepository.updateTaskToDataBase(event.taskForDataBaseModel);
      emit(
          state.copyWith(
            status: TaskFromDataBaseStatus.success,
          )
      );
    }catch (error){
      emit(state.copyWith(status: TaskFromDataBaseStatus.error));
    }
  }
}