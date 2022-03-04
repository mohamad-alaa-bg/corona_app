import 'package:corona_app/Data/dataSource/corona_data_source.dart';
import 'package:corona_app/Data/repositories/corona_repository.dart';
import 'package:corona_app/blocs/coronaCountriesBloc/corona_countries_bloc.dart';
import 'package:corona_app/blocs/coronaSummaryBloc/corona_summary_bloc.dart';
import 'package:corona_app/ui/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final CoronaRepository coronaRepository = CoronaRepository(
    coronaSource: CoronaSource(),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Corona Live",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => CoronaSummaryBloc(
              coronaRepository: coronaRepository,
            ),
          ),
          BlocProvider(
            lazy: false,
              create: (context) => CoronaCountriesBloc(
                    coronaRepository: coronaRepository,
                  ))
        ],
        child: HomePage(),
      ),
    );
  }
}
