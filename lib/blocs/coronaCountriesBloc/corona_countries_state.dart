part of 'corona_countries_bloc.dart';

abstract class CoronaCountriesState extends Equatable {
  const CoronaCountriesState();
}

class CoronaCountriesInitial extends CoronaCountriesState {
  @override
  List<Object> get props => null;
}

class CoronaCountriesIsLoadingState extends CoronaCountriesState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CoronaCountriesLoadedState extends CoronaCountriesState {
  final List<CoronaCountry> countries;

  CoronaCountriesLoadedState({@required this.countries});

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CoronaCountriesFailureState extends CoronaCountriesState {
  final String message;

  CoronaCountriesFailureState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class FilteredCountries extends CoronaCountriesState {
  final List<CoronaCountry> countries;

  FilteredCountries({@required this.countries});

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class NoCountriesFound extends CoronaCountriesState{
  @override
  // TODO: implement props
  List<Object> get props => null;

}
