import 'package:flutter/material.dart';
import 'package:vegetable_apps/application/sign_in/sign_in_provider.dart';
import 'package:vegetable_apps/presentation/item_detail/item_detail_page.dart';
import 'package:provider/provider.dart';

class MenuListPage extends StatefulWidget {
  MenuListPage({Key key, @required this.token}) : super(key: key);

  final String token;

  @override
  _MenuListPageState createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  List<String> listGambar = [
    'assets/images/food.jpg',
    'assets/images/food1.jpg',
    'assets/images/food2.jpg',
    'assets/images/food3.jpg',
    'assets/images/food4.jpg',
    'assets/images/food.jpg',
    'assets/images/food1.jpg',
    'assets/images/food2.jpg',
    'assets/images/food3.jpg',
    'assets/images/food4.jpg',
  ];

  @override
  void initState() {
    print("Token Id setelah masuk kelas menu list " +
        context.read<SignInProvider>().getTokenId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInProvider>(
      builder: (context, signInProvider, _) => Scaffold(
        appBar: AppBar(
          title: Text(signInProvider.getTokenId),
        ),
        body: SafeArea(
          child: Container(
              child: Column(
            children: <Widget>[
              FlatButton(
                child: Text("Ganti Token"),
                onPressed: () {
                  signInProvider.setTokenId("Tokennya diganti");
                  print(context.read<SignInProvider>().getTokenId);
                },
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: listGambar.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ItemDetailPage(
                                    gambar: listGambar[index],
                                  )));
                        },
                        child: ListImageItem(listGambar: listGambar[index]))),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class ListImageItem extends StatelessWidget {
  const ListImageItem({
    Key key,
    @required this.listGambar,
  }) : super(key: key);

  final String listGambar;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 100,
        child: Image.asset(
          listGambar,
          fit: BoxFit.cover,
        ));
  }
}
