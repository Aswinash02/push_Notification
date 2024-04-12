import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit()
      : super(const NetworkInitial(isConnected: ConnectivityResult.none));
  StreamSubscription? subscription;

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }

  void checkNetwork() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      emit(state.copyWidth(isConnected: result));
      if (state.isConnected == ConnectivityResult.none) {
        emit(NetworkDisconnected(isConnected: state.isConnected));
      } else {
        emit(NetworkConnected(isConnected: state.isConnected));
      }
    });
  }
}
