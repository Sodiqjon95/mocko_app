import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mocko_app/models/company_item.dart';
import 'package:mocko_app/service/api_provider.dart';
import 'package:mocko_app/utils/my_text_stile.dart';
import 'info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Car Companies",
            style: MyTextStyle.interSemiBold600.copyWith(color: Colors.black, fontSize: 22),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder<List<CompanyItem>>(
          future: ApiProvider.getAllCompanies(),
          builder: (context, AsyncSnapshot<List<CompanyItem>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              var carts = snapshot.data!;
              return ListView.builder(
                itemCount: carts.length,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage(id: index)));
                    },
                    leading: Image.network(carts[index].logo),
                    title: Text(carts[index].carModel),
                    subtitle: Text(
                      carts[index].establishedYear.toString(),
                    ),
                    trailing: InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle),
                        child: Icon(Icons.arrow_right),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CupertinoActivityIndicator());
            }
          },
        ));
  }
}
