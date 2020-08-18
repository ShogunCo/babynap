
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hero_brain/bloc/tts_event.dart';
import 'package:the_hero_brain/bloc/tts_state.dart';

class TtsBloc extends Bloc<TtsEvent, TtsState> {
  TtsBloc() : super(StoppedState());



  @override
  Stream<TtsState> mapEventToState(TtsEvent event) async*{

  }

  @override
  void onTransition(Transition<TtsEvent, TtsState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
  }

}