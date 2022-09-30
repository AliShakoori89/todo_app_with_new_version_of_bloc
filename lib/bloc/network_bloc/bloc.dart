import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_new_version_bloc/bloc/network_bloc/event.dart';
import 'package:todo_app_with_new_version_bloc/bloc/network_bloc/state.dart';
import 'package:todo_app_with_new_version_bloc/network/network_helper.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc._() : super(NetworkInitial()) {
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notifyStatus);
  }

  static final NetworkBloc _instance = NetworkBloc._();

  factory NetworkBloc() => _instance;

  void _observe(event, emit) {
    NetworkHelper.observeNetwork();
  }

  void _notifyStatus(NetworkNotify event, emit) {
    event.isConnected ? emit(NetworkSuccess()) : emit(NetworkFailure());
  }
}