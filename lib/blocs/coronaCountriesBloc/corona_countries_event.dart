part of 'corona_countries_bloc.dart';

abstract class CoronaCountriesEvent extends Equatable {
  const CoronaCountriesEvent();
}

class FetchCoronaCountries extends CoronaCountriesEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class FilterCountry extends CoronaCountriesEvent {
  final String filterText;
  final List<CoronaCountry> countries;

  FilterCountry({@required this.filterText, @required this.countries});

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CrossBtnPressed extends CoronaCountriesEvent{
  @override
  // TODO: implement props
  List<Object> get props => null;

}