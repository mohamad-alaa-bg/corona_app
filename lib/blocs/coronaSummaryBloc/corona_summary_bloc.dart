import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:corona_app/Data/models/corona_summary.dart';
import 'package:corona_app/Data/repositories/corona_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'corona_summary_event.dart';

part 'corona_summary_state.dart';

class CoronaSummaryBloc extends Bloc<CoronaSummaryEvent, CoronaSummaryState> {
  CoronaRepository coronaRepository;

  CoronaSummaryBloc({this.coronaRepository}) : super(CoronaSummaryInitial()) ;

  @override
  // TODO: implement mapEventToState
  CoronaSummaryState get initialState => CoronaSummaryInitial();



  @override
  Stream<CoronaSummaryState> mapEventToState(CoronaSummaryEvent event) async* {
    // TODO: implement mapEventToState
    if(event is CoronaSummaryEvent){
      yield* mapCoronaSummaryEventToState(event);
    }
  }

  Stream<CoronaSummaryState> mapCoronaSummaryEventToState(
      FetchCoronaSummary event) async* {
    yield CoronaSummaryIsLoadingState();
    try {
      CoronaSummary coronaSummary = await coronaRepository.fetchCoronaSummary();
      yield CoronaSummaryLoadedState(coronaSummary: coronaSummary);
    } catch (error) {
      yield CoronaSummaryFailureState(message: error);
    }
  }
}
