import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_new_version_bloc/bloc/task_from_net_bloc/event.dart';
import 'package:todo_app_with_new_version_bloc/bloc/task_from_net_bloc/state.dart';
import 'package:todo_app_with_new_version_bloc/model/task_model.dart';
import 'package:todo_app_with_new_version_bloc/repository/task_repository.dart';

class TaskFromNetBloc extends Bloc<TaskFromNetEvent, TaskFromNetState>{
  final TaskRepository taskRepository;

  TaskFromNetBloc(this.taskRepository): super(const TaskFromNetState()){
    on<GetAllTaskEvent>(_mapGetAllTaskEventToState);
    on<AddNewTaskEvent>(_mapAddNewTaskEventToState);
    on<DeleteTaskEvent>(_mapDeleteTaskEventToState);
    on<EditTaskEvent>(_mapEditTaskEventToState);
  }

  void _mapGetAllTaskEventToState(
      GetAllTaskEvent event, Emitter<TaskFromNetState> emit) async {
    try{
      emit(state.copyWith(status: TaskFromNetStatus.loading));
      final response = await taskRepository.getAllTask();
      Iterable l = json.decode(response.body);
      List<TaskModel> allTask = List<TaskModel>.from(l.map((model)=> TaskModel.fromJson(model)));      emit(
          state.copyWith(
              status: TaskFromNetStatus.success,
              allTask: allTask
          )
      );
    }catch (error){
      emit(state.copyWith(status: TaskFromNetStatus.error));
    }
  }

  void _mapAddNewTaskEventToState(
      AddNewTaskEvent event, Emitter<TaskFromNetState> emit) async {
    try{
      emit(state.copyWith(status: TaskFromNetStatus.loading));
      await taskRepository.addTask(event.taskModel);
      final response = await taskRepository.getAllTask();
      Iterable l = json.decode(response.body);
      List<TaskModel> allTask = List<TaskModel>.from(l.map((model)=> TaskModel.fromJson(model)));
      emit(
          state.copyWith(
            status: TaskFromNetStatus.success,
            allTask: allTask
          )
      );
    }catch (error){
      emit(state.copyWith(status: TaskFromNetStatus.error));
    }
  }

  void _mapDeleteTaskEventToState(
      DeleteTaskEvent event, Emitter<TaskFromNetState> emit) async {
    try{
      emit(state.copyWith(status: TaskFromNetStatus.loading));
      await taskRepository.deleteTask(event.id);
      final response = await taskRepository.getAllTask();
      Iterable l = json.decode(response.body);
      List<TaskModel> allTask = List<TaskModel>.from(l.map((model)=> TaskModel.fromJson(model)));
      emit(
          state.copyWith(
            status: TaskFromNetStatus.success,
            allTask: allTask
          )
      );
    }catch (error){
      emit(state.copyWith(status: TaskFromNetStatus.error));
    }
  }

  void _mapEditTaskEventToState(
      EditTaskEvent event, Emitter<TaskFromNetState> emit) async {
    try{
      emit(state.copyWith(status: TaskFromNetStatus.loading));
      await taskRepository.editTask(event.taskModel);
      final response = await taskRepository.getAllTask();
      Iterable l = json.decode(response.body);
      List<TaskModel> allTask = List<TaskModel>.from(l.map((model)=> TaskModel.fromJson(model)));
      emit(
          state.copyWith(
            status: TaskFromNetStatus.success,
            allTask: allTask
          )
      );
    }catch (error){
      emit(state.copyWith(status: TaskFromNetStatus.error));
    }
  }
}