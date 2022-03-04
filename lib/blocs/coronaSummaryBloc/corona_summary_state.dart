part of 'corona_summary_bloc.dart';

abstract class CoronaSummaryState extends Equatable {
  const CoronaSummaryState();
}

class CoronaSummaryInitial extends CoronaSummaryState {
  @override
  List<Object> get props => null;
}

class CoronaSummaryIsLoadingState extends CoronaSummaryState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class CoronaSummaryLoadedState extends CoronaSummaryState {
  final CoronaSummary coronaSummary;

  CoronaSummaryLoadedState({@required this.coronaSummary});

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CoronaSummaryFailureState extends CoronaSummaryState {
  final String message;
  CoronaSummaryFailureState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => null;

}
