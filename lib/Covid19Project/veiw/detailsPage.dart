import 'package:api/Covid19Project/veiw/world_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {
  final String name;
   var img;
   int totalCase,totalDeaths, totalRecover, active, critical, todayRecover, test;
   CountryDetails({super.key,
     required this.name,
     required this.img,
     required this.totalCase,
     required this.totalDeaths,
     required this.totalRecover,
     required this.active,
     required this.critical,
     required this.todayRecover,
     required this.test,

   });

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(
        title: Text(widget.name),
        centerTitle: true,
        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.img),

            ),
          ),
        ],
      ),body: SingleChildScrollView(
        child: Column(
        children: [
        
          Stack(
            children: [
              SizedBox(height: 20,),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*.6,
                        height: MediaQuery.of(context).size.height*.2,
                        child: Image.network(widget.img,fit: BoxFit.cover,)
                      ),
                      SizedBox(height: 30,),
                      ReusableRow(title: "Country", value: widget.name),
                      ReusableRow(title: "TotalCase", value: widget.totalCase.toString()),
                      ReusableRow(title: "TotalDeaths", value: widget.totalDeaths.toString()),
                      ReusableRow(title: "TotalRecover", value: widget.totalRecover.toString()),
                      ReusableRow(title: "TodayRecover", value: widget.todayRecover.toString()),
                      ReusableRow(title: "Active", value: widget.active.toString()),
                      ReusableRow(title: "Critical", value: widget.critical.toString()),
                      ReusableRow(title: "Test", value: widget.test.toString()),
                    ],
                  ),
                ),
              )
            ],
          )
        
        ],
            ),
      ),

    );
  }
}
