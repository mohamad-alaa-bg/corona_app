import 'package:corona_app/Data/dataSource/corona_data_source.dart';
import 'package:corona_app/Data/models/corona_country.dart';
import 'package:corona_app/Data/models/corona_summary.dart';
import 'package:corona_app/blocs/coronaCountriesBloc/corona_countries_bloc.dart';
import 'package:meta/meta.dart';

class CoronaRepository {
  CoronaSource coronaSource;

  CoronaRepository({@required this.coronaSource});

  Future<CoronaSummary> fetchCoronaSummary() async {
    return await coronaSource.getCoronaSummary();
  }

  Future<List<CoronaCountry>> fetchCoronaCountries() async {
    return await coronaSource.getCoronaCountries();
  }

  List<CoronaCountry> fetchFilteredCountries (String text,List<CoronaCountry> countries){
    return coronaSource.getFilterCountries(text, countries);
  }
}

