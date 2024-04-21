import 'package:api/Covid19Project/services/state_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

import 'detailsPage.dart';

class CountryNamePage extends StatefulWidget {
  const CountryNamePage({super.key});

  @override
  State<CountryNamePage> createState() => _CountryNamePageState();
}

class _CountryNamePageState extends State<CountryNamePage> with SingleTickerProviderStateMixin{

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

  var searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    StateServices services = StateServices();
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid-19"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              onChanged: (value){
                setState(() {

                });
              },
              decoration: InputDecoration(

                hintText: "Search country name",
                prefixIcon: Icon(Icons.search),


                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue
                  )
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02,),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: services.countryList(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                  if(!snapshot.hasData){
                    return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index){

                          return Shimmer.fromColors(
                              child:ListTile(
                                title: Container(width:89, height: 10,color: Colors.white,),
                                subtitle: Container(width:89, height: 10,color: Colors.white,),
                                leading:  Container(width:60, height: 40,color: Colors.white,),

                              ),
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                          );


                        });

                  }else{
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {

                          String name = snapshot.data![index]["country"].toString();

                          if(searchController.text.isEmpty){
                            return Card(
                              child: ListTile(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CountryDetails(
                                    name:snapshot.data![index]["country"].toString(),
                                    img: snapshot.data![index]["countryInfo"]["flag"].toString(),
                                    totalCase: snapshot.data![index]["cases"],
                                    totalDeaths: snapshot.data![index]["todayDeaths"],
                                    totalRecover: snapshot.data![index]["recovered"],
                                    active: snapshot.data![index]["active"],
                                    critical: snapshot.data![index]["critical"],
                                    todayRecover: snapshot.data![index]["todayRecovered"],
                                    test: snapshot.data![index]["tests"],
                                  )));
                                },
                                title: Text(snapshot.data![index]["country"].toString()),
                                leading: Image.network(snapshot.data![index]["countryInfo"]["flag"].toString(),width: 60,fit: BoxFit.cover,),
                              ),
                            );

                          }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return Card(
                              child: ListTile(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CountryDetails(
                                    name:snapshot.data![index]["country"].toString(),
                                    img: snapshot.data![index]["countryInfo"]["flag"].toString(),
                                    totalCase: snapshot.data![index]["cases"],
                                    totalDeaths: snapshot.data![index]["todayDeaths"],
                                    totalRecover: snapshot.data![index]["recovered"],
                                    active: snapshot.data![index]["active"],
                                    critical: snapshot.data![index]["critical"],
                                    todayRecover: snapshot.data![index]["todayRecovered"],
                                    test: snapshot.data![index]["tests"],

                                  )));
                                },
                                title: Text(snapshot.data![index]["country"].toString()),
                                leading: Image.network(snapshot.data![index]["countryInfo"]["flag"].toString(),width: 60,fit: BoxFit.cover,),
                              ),
                            );

                          }else{
                            return Container();
                          }


                        });

                  }

                },
              )
            )
          ],
        ),
      ),
    );
  }
}
