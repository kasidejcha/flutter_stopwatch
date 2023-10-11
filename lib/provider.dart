import 'package:flutter_riverpod/flutter_riverpod.dart';



abstract class StreamingSocket {
  Stream<int> getCounterStream(int startnum, bool status);
}

// ignore: camel_case_types
class counterSocket implements  StreamingSocket {
  @override
  Stream<int> getCounterStream(startnum, status) async*{
    int i = startnum;
    while (status) {
      yield i--;
      await Future.delayed(const Duration(milliseconds: 1000));
      if (i<0){
        break;
      }
    }
  }
}

final startNumProvider = StateProvider((ref) => 20);

final streamCountProvider = Provider<StreamingSocket>((ref) => counterSocket());
final streamCountProvider1 = Provider<StreamingSocket>((ref) => counterSocket());
final statusProvider = StateProvider((ref) => true);

final counterProvider = StateProvider<Stream>((ref) {
  final socket = ref.watch(streamCountProvider);
  return socket.getCounterStream(ref.watch(startNumProvider), ref.watch(statusProvider));
});

final counterProvider1 = StreamProvider<int>((ref) {
  final socket = ref.watch(streamCountProvider1);
  return socket.getCounterStream(30, true);
});