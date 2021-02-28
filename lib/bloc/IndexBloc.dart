import 'dart:async';

class IndexBloc {
  StreamController _currentIndexStreamController =
      StreamController<int>.broadcast();

  Stream get currentIndex => _currentIndexStreamController.stream;

  dispose() {
    _currentIndexStreamController.close();
  }

  updateCurrentIndex(int currentIndex) {
    _currentIndexStreamController.sink.add(currentIndex);
  }
}

final indexBloc = IndexBloc();

class InternetCheckBloc {
  StreamController _isConnectedStreamController =
      StreamController<bool>.broadcast();

  Stream get isConnected => _isConnectedStreamController.stream;

  dispose() {
    _isConnectedStreamController.close();
  }

  updateCurrentIndex(bool _isConnected) {
    _isConnectedStreamController.sink.add(_isConnected);
  }
}

final internetCheckBloc = InternetCheckBloc();
