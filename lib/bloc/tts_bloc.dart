//import 'package:bloc/bloc.dart';
//import 'package:the_hero_brain/bloc/tts_event.dart';
//import 'package:the_hero_brain/bloc/tts_state.dart';
//
//class TtsBloc extends Bloc<TtsEvent, TtsState> {
//  TtsBloc(TtsState initialState) : super(initialState);
//
//  TtsState get initialState => TtsState.initial();
//
//  void onPlay() {
//    dispatch(PlayEvent());
//  }
//
//
//  @override
//  Stream<TtsState> mapEventToState(TtsEvent event) async* {
//    final _currentState = currentState;
//    if (event is PlayEvent) {
//      yield TtsState(counter: _currentState.counter + 1);
//    }
//  }
//}