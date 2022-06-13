import 'dart:async';

extension CompleterExtensions on Completer{
  Future completeAndReturnFuture(){
    complete();
    return future;
  }
}