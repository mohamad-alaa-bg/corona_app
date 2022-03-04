import 'package:corona_app/Data/models/corona_country.dart';
import 'package:corona_app/blocs/coronaCountriesBloc/corona_countries_bloc.dart';
import 'package:corona_app/res/colors/app_colors.dart';
import 'package:corona_app/ui/pages/corona_country_details_page.dart';
import 'package:corona_app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoronaCountriesPage extends StatefulWidget {
  @override
  _CoronaCountriesPageState createState() => _CoronaCountriesPageState();
}

class _CoronaCountriesPageState extends State<CoronaCountriesPage> {
  double scrHeight, scrWidth;
  CoronaCountriesBloc coronaCountriesBloc;
  bool isSearching = false;
  List<CoronaCountry> list = [];
  TextEditingController searchTextCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    coronaCountriesBloc = BlocProvider.of<CoronaCountriesBloc>(context);
    coronaCountriesBloc.add(FetchCoronaCountries());
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    scrHeight = MediaQuery.maybeOf(context).size.height;
    scrWidth = MediaQuery.maybeOf(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBk,
        title: !isSearching
            ? Text(
                "CORONA VIRUS",
                style: TextStyle(
                  fontFamily: "RussoOne",
                  letterSpacing: 1.7,
                  color: Colors.teal,
                ),
              )
            : TextField(
                controller: searchTextCtrl,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Search by country",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value) {
                  coronaCountriesBloc.add(FilterCountry(
                    filterText: value,
                    countries: list,
                  ));
                },
              ),
        centerTitle: true,
        actions: [
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    coronaCountriesBloc.add(CrossBtnPressed());
                    setState(() {
                      searchTextCtrl.text = "";
                      isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.darkBk,
          height: scrHeight,
          child: BlocBuilder<CoronaCountriesBloc, CoronaCountriesState>(
            bloc: coronaCountriesBloc,
            // ignore: missing_return
            builder: (context, state) {
              if (state is CoronaCountriesIsLoadingState) {
                return buildLoadingUi();
              } else if (state is CoronaCountriesLoadedState) {
                return buildCoronaCountriesList(state.countries);
              } else if (state is CoronaCountriesFailureState) {
                return buildErrorUi(state.message);
              } else if (state is FilteredCountries) {
                return buildCoronaCountriesList(state.countries);
              } else if (state is NoCountriesFound) {
                return buildErrorUi("No Countries Found");
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget buildCoronaCountriesList(List<CoronaCountry> countries) {
  return Container(
    margin: EdgeInsets.only(bottom: 118.0),
    child: ListView.builder(
        itemCount: countries.length,
        padding: EdgeInsets.all(5.0),
        shrinkWrap: true,
        itemBuilder: (context, position) {
          CoronaCountry coronaCountry = countries[position];
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                navigateToDetailsPage(context, coronaCountry);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10.0),
                child: Material(
                  elevation: 10.0,
                  shadowColor: Colors.grey,
                  color: AppColors.upDark,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            coronaCountry.country.toUpperCase(),
                            style: TextStyle(
                              color: AppColors.cyan,
                              fontSize: 20.0,
                              fontFamily: "RussoOne",
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "Cases : ${coronaCountry.cases.toString()}",
                            style: TextStyle(
                              color: AppColors.green,
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Deaths : ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: coronaCountry.deaths.toString(),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: "RussoOne",
                                          color: AppColors.white,
                                          letterSpacing: 1.5,
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Today : ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: coronaCountry.todayDeaths
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: "RussoOne",
                                          color: coronaCountry.todayDeaths == 0
                                              ? AppColors.teal
                                              : AppColors.red,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
  );
}

void navigateToDetailsPage(BuildContext context, CoronaCountry country) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return CoronaCountryDetailsPage(country: country);
  }));
}
