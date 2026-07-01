import 'package:coubot/core/extensions/object_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// this class is the app bloc observer
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    'onCreate -- ${bloc.runtimeType}'.log;
  }

  @override
  void onEvent(BlocBase<dynamic> bloc, Object? event) {
    super.onEvent(bloc as Bloc<dynamic, dynamic>, event);
    'onEvent -- ${bloc.runtimeType}, $event'.log;
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    'onChange -- ${bloc.runtimeType}, $change'.log;
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    'onTransition -- ${bloc.runtimeType}, $transition'.log;
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    'onError -- ${bloc.runtimeType}, $error'.log;
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    'onClose -- ${bloc.runtimeType}'.log;
  }
}
