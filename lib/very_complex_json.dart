import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/ProductsModel.dart';

class VeryComplexJson extends StatefulWidget {
  const VeryComplexJson({super.key});

  @override
  State<VeryComplexJson> createState() => _VeryComplexJsonState();
}

class _VeryComplexJsonState extends State<VeryComplexJson> {

  Future<ProductsModel> getProductsApi() async{
    final response = await http.get(Uri.parse('https://webhook.site/63da82d3-9a39-462e-b6a0-32ba938b186f'));
    var data = jsonDecode(response.body.toString());
    if(response == 200){
      return ProductsModel.fromJson(data);
    }else{
      return ProductsModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Very_Complex_JSON"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getProductsApi(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Text("Loading");
                }
                else{
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(snapshot.data!.data![index].shop!.name.toString()),
                            subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*.3,
                            width: MediaQuery.of(context).size.width*1,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.data![index].images!.length,
                              itemBuilder: (context, position){
                                return Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height*.25,
                                    width: MediaQuery.of(context).size.width*.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot.data!.data![index].images![position].url.toString()),
                                        fit: BoxFit.cover,
                                      )
                                    ),
                                  ),
                                );
                              }
                            ),
                          )
                        ],
                      );
                    }
                  );
                }
              }
            ),
          )
        ],
      ),
    );
  }
}
