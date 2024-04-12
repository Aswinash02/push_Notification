part of 'network_cubit.dart';

class NetworkState {
  const NetworkState({required this.isConnected});

  final ConnectivityResult isConnected;

  // @override
  // // TODO: implement props
  // List<Object?> get props => [isConnected];

  NetworkState copyWidth({ConnectivityResult? isConnected}) {
    return NetworkState(isConnected: isConnected ?? this.isConnected);
  }
}

class NetworkInitial extends NetworkState {
  const NetworkInitial({required super.isConnected});
}

class NetworkConnected extends NetworkState {
  const NetworkConnected({required super.isConnected});
}

class NetworkDisconnected extends NetworkState {
  const NetworkDisconnected({required super.isConnected});
}
