import 'package:api/Covid19Project/model/WorldStateModel.dart';
import 'package:api/Covid19Project/services/state_services.dart';
import 'package:api/Covid19Project/services/utilitis/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'CountryNamePage.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color> [
    Colors.blue,
    Colors.green,
    Colors.red,
  ];


  @override
  Widget build(BuildContext context) {

    StateServices services = StateServices();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Covid-19"),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.blue
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.04,),

            FutureBuilder(
                future: services.fechtWorldState(),
                builder: (BuildContext context,AsyncSnapshot<WorldStateModel> snapshot){
                  if(!snapshot.hasData){
                    return Expanded(
                        child: SpinKitFadingCircle(
                          color: Colors.black,
                          size: 40.0,
                          controller:  _controller,
                        )
                    );

                  }else{

                    return Column(
                      children: [
                        PieChart(
                          centerText: "Covid-19",
                          dataMap: {
                            "Total" :  double.parse(snapshot.data!.cases.toString()),
                            "Recovered" :  double.parse(snapshot.data!.recovered.toString()),
                            "Deaths" :  double.parse(snapshot.data!.deaths.toString()),
                          },
                          animationDuration: Duration(seconds: 3),
                          chartType: ChartType.ring,
                          chartRadius: MediaQuery.of(context).size.height* .2,
                          colorList: colorList,
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesOutside: true
                          ) ,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.right
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*.04,),
                        Card(
                          elevation: 0,
                          color: Colors.grey.withOpacity(.3),
                          child: Column(
                            children: [
                              ReusableRow(title: "Total", value: snapshot.data!.cases.toString()),
                              ReusableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                              ReusableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                              ReusableRow(title: "TodayCase", value: snapshot.data!.todayCases.toString()),
                              ReusableRow(title: "TodayDeath", value: snapshot.data!.todayDeaths.toString()),

                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*.03,),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                              width:MediaQuery.of(context).size.width*1 ,
                              height:MediaQuery.of(context).size.height*.06 ,
                              child: ElevatedButton.icon(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> CountryNamePage()));
                              }, icon: Icon(Icons.arrow_circle_right_outlined), label: Text("Tricker"))),
                        )
                      ],
                    );

                  }

                }

            ),




          ],

        ),
      ),

    );
  }
}
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height:5 ,),
          Divider()
        ],
      ),
    );
  }
}

