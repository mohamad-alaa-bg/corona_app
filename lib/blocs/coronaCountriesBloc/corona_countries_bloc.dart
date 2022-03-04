import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:corona_app/Data/models/corona_country.dart';
import 'package:corona_app/Data/repositories/corona_repository.dart';
import 'package:corona_app/blocs/coronaSummaryBloc/corona_summary_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'corona_countries_event.dart';

part 'corona_countries_state.dart';

class CoronaCountriesBloc
    extends Bloc<CoronaCountriesEvent, CoronaCountriesState> {
  CoronaRepository coronaRepository;

  CoronaCountriesBloc({@required this.coronaRepository}) : super(CoronaCountriesIsLoadingState());
  List<CoronaCountry> list;

  @override
  CoronaCountriesState get initialState => CoronaCountriesIsLoadingState();

  @override
  Stream<CoronaCountriesState> mapEventToState(
    CoronaCountriesEvent event,
  ) async* {
    if (event is FetchCoronaCountries) {
      yield* mapFetchCoronaCountriesToEvent(event);
    }else if(event is FilterCountry){
      yield* mapFilterCountryToEvent(event);
    }else if(event is CrossBtnPressed){
      yield CoronaCountriesLoadedState(countries: list);
    }
    // TODO: implement mapEventToState
  }

  Stream<CoronaCountriesState> mapFetchCoronaCountriesToEvent(
      FetchCoronaCountries event) async* {
    yield CoronaCountriesIsLoadingState();
    try {
      list = await coronaRepository.fetchCoronaCountries();
      yield CoronaCountriesLoadedState(countries: list);
    } catch (error) {
      yield CoronaCountriesFailureState(message: error);
    }
  }

  Stream<CoronaCountriesState> mapFilterCountryToEvent(
      FilterCountry event) async* {
    yield CoronaCountriesIsLoadingState();
    List<CoronaCountry> countries = coronaRepository.fetchFilteredCountries(
        event.filterText, event.countries);
    if (countries.length > 0) {
      yield FilteredCountries(countries: countries);
    } else {
      yield NoCountriesFound();
    }
  }
}
