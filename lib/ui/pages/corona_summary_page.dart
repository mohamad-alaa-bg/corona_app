import 'package:corona_app/blocs/coronaCountriesBloc/corona_countries_bloc.dart';
import 'package:corona_app/blocs/coronaSummaryBloc/corona_summary_bloc.dart';
import 'package:corona_app/ui/widgets/app_widgets.dart';
import 'package:corona_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoronaSummaryPage extends StatefulWidget {
  @override
  _CoronaSummaryPageState createState() => _CoronaSummaryPageState();
}

class _CoronaSummaryPageState extends State<CoronaSummaryPage> {
  double scrHeight, scrWidth;
  CoronaSummaryBloc coronaSummaryBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    coronaSummaryBloc = BlocProvider.of<CoronaSummaryBloc>(context);
    coronaSummaryBloc.add(FetchCoronaSummary());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[850],
          height: MediaQuery.maybeOf(context).size.height,
          child: BlocBuilder<CoronaSummaryBloc, CoronaSummaryState>(
            bloc: coronaSummaryBloc,
            builder: (context, state) {
              if (state is CoronaSummaryInitial) {
                return buildLoadingUi();
              } else if (state is CoronaSummaryIsLoadingState) {
                return buildLoadingUi();
              } else if (state is CoronaSummaryLoadedState) {
                return buildSuccessUi(state);
              } else if (state is CoronaSummaryFailureState) {
                buildErrorUi(state.message);
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget buildSuccessUi(CoronaSummaryLoadedState state) {
  return ListView(
    children: [
      Container(
        padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
        alignment: Alignment.center,
        child: Text(
          'CORONA VIRUS SUMMARY',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            letterSpacing: 2.3,
            fontFamily: 'RussoOne',
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
        alignment: Alignment.center,
        child: Text(
          Helper.millisecondToDate(state.coronaSummary.updated),
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            letterSpacing: 4.5,
            fontFamily: 'RussoOne',
          ),
        ),
      ),
      Card(
        child: Text(
          "${state.coronaSummary.deaths}",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            letterSpacing: 2.5,
            fontFamily: 'RussoOne',
          ),
        ),
        // alignment: Alignment.center,
        // bevel: 25.0,
        // decoration: NeumorphicDecoration(
        //   shape: BoxShape.circle,
        //   color: Colors.grey[850],
        // ),
        // margin: EdgeInsets.only(top: 30.0),
        // width: 150.0,
        // height: 150.0,
        // curveType: CurveType.concave,
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 25.0),
        alignment: Alignment.center,
        child: Text(
          "TOTAL DEATH",
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.0),
        alignment: Alignment.center,
        child: Text(
          state.coronaSummary.cases.toString(),
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            fontFamily: "RussoOne",
            letterSpacing: 4.5,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 30.0),
        alignment: Alignment.center,
        child: Text(
          "TOTAL CASE",
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),

      //
      Container(
        margin: EdgeInsets.only(top: 10.0),
        alignment: Alignment.center,
        child: Text(
          state.coronaSummary.recovered.toString(),
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            fontFamily: "RussoOne",
            letterSpacing: 4.5,
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          "TOTAL RECOVERED",
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
    ],
  );
}
