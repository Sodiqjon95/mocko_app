import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mocko_app/models/company_item.dart';
import 'package:mocko_app/service/api_provider.dart';
import 'package:mocko_app/utils/my_text_stile.dart';

class InfoPage extends StatefulWidget {
  InfoPage({required this.id});

  final int id;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info Page"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: ApiProvider.getSingleCompany(id: widget.id),
                  builder: (BuildContext context, AsyncSnapshot<CompanyItem> snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!;
                      return Column(
                        children: [
                          CarouselSlider(
                            items: List.generate(
                              data.pics.length,
                              (index) => Image.network(
                                data.pics[index],
                              ),
                            ),
                            options: CarouselOptions(height: 300, autoPlay: true, autoPlayAnimationDuration: Duration(seconds: 1)),
                          ),
                          ListTile(
                            leading: Image.network(data.logo),
                            title: Text(data.carModel),
                            subtitle: Text(
                              data.averagePrice.toString(),
                            ),
                          ),
                          ExpansionTile(
                            title: Text("About company"),
                            children: [
                              Container(padding: EdgeInsets.all(15),child: Text(data.description, style: MyTextStyle.interMedium500.copyWith(color: Colors.black, fontSize: 16),))
                            ],
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error"),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),),
    );
  }
}
