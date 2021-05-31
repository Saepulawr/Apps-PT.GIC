import 'dart:convert';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:testptgic/module/headersliver/HeaderSliver.dart';
import 'package:testptgic/module/provider/PublicProvider.dart';

class ContactPage extends StatefulWidget {
  ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with AfterLayoutMixin<ContactPage> {
  GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey();
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   // title: Text("Contact"),
      // ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.red,
          ),
          Expanded(child: _buildBody()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {},
        // onPressed: () async {
        //   List<TCustomer> customers = [];
        //   if (Provider.of<ProviderPublic>(context, listen: false)
        //           .modelCustomerAll
        //           .total ==
        //       null) {
        //     await API().getData(
        //       url: UrlApi().customer,
        //       onComplete: (data, statusCode) {
        //         if (statusCode == 200) {
        //           try {
        //             Provider.of<ProviderPublic>(context, listen: false)
        //                 .setModelCustomerAll(
        //                     ModelCustomerAll.fromJson(jsonDecode(data)));
        //             customers.clear();
        //             customers = ModelCustomerAll.fromJson(jsonDecode(data))
        //                 .data!
        //                 .tCustomer!;
        //           } catch (e) {}
        //         }
        //       },
        //     );
        //   } else {
        //     customers = Provider.of<ProviderPublic>(context, listen: false)
        //         .modelCustomerAll
        //         .data!
        //         .tCustomer!;
        //   }
        //   late TCustomer customerSelected;
        //   await SelectDialog.showModal<TCustomer>(
        //     context,
        //     label: "ContactPage for ?",
        //     selectedValue: TCustomer(),
        //     items: customers,
        //     itemBuilder: (context, item, isSelected) {
        //       return Column(children: [
        //         ListTile(
        //           title: Text(item.nama!),
        //           subtitle: Text(
        //             item.alamat!,
        //             maxLines: 2,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //         ),
        //         Divider()
        //       ]);
        //     },
        //     onFind: (text) {
        //       List<TCustomer> cus = [];
        //       customers.forEach((element) {
        //         if (element.nama!.toLowerCase().contains(text.toLowerCase()) ||
        //             element.alamat!.toLowerCase().contains(text.toLowerCase()))
        //           cus.add(element);
        //       });
        //       return Future.value(cus);
        //     },
        //     onChange: (TCustomer selected) {
        //       setState(() {
        //         customerSelected = selected;
        //       });
        //     },
        //   );
        //   if (customerSelected != null) {
        //     String result = await Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => ContactPageAdd(
        //         customer: customerSelected,
        //       ),
        //     ));
        //     try {
        //       if (result == "ok") {
        //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //           content: Text("Success"),
        //           backgroundColor: Colors.green,
        //         ));
        //         _handleRefresh();
        //       }
        //     } catch (e) {}
        //   }
        // },
      ),
    );
  }

  Future<void> _handleRefresh() async {
    setState(() {
      isLoading = true;
    });
    // Provider.of<PublicProvider>(context, listen: false)
    //     .setModelContactPageAll(ModelContactPageAll());
    // await API().getData(
    //   url: UrlApi().ContactPageGetAll,
    //   onComplete: (data, statusCode) {
    //     if (statusCode == 200) {
    //       try {
    //         Provider.of<ProviderPublic>(context, listen: false)
    //             .setModelContactPageAll(
    //                 ModelContactPageAll.fromJson(jsonDecode(data)));
    //       } catch (e) {}
    //     }
    //   },
    // );
    setState(() {
      isLoading = false;
    });
  }

  Widget _buildBody() {
    // ModelContactPageAll modelContactPageAll =
    //     Provider.of<ProviderPublic>(context).modelContactPageAll;
    // Widget list = Center(
    //     child: SpinKitCubeGrid(
    //   color: Theme.of(context).primaryColor,
    // ));
    // if (!isLoading) {
    //   if (modelContactPageAll.total != null) {
    //     list = ListView.builder(
    //       itemBuilder: (context, index) {
    //         // print(modelContactPageAll.data!.tContactPage![index].toJson());
    //         return CardContactPageList(
    //           ContactPage: modelContactPageAll.data!.tContactPage![index],
    //         );
    //       },
    //       itemCount: modelContactPageAll.total,
    //     );
    //   } else {
    //     list = SingleChildScrollView(
    //       child: Container(
    //         alignment: Alignment.center,
    //         height: MediaQuery.of(context).size.height,
    //         child: Text("Failed Connect To Server!"),
    //       ),
    //     );
    //   }
    // }

    return LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        color: Theme.of(context).primaryColor,
        onRefresh: _handleRefresh,
        child: CustomScrollView(slivers: <Widget>[
          // SliverAppBar(
          // title: Container(
          //   alignment: Alignment.centerLeft,
          //   child: Text(
          //     "Contact",
          //     style: TextStyle(color: Colors.black),
          //   ),
          // ),
          // toolbarHeight: 30,
          // collapsedHeight: 10,

          // backgroundColor: Theme.of(context).primaryColor,
          // expandedHeight: 200.0,
          // flexibleSpace: FlexibleSpaceBar(
          //   title: Text("test"),
          //   // background: Image.asset('assets/forest.jpg', fit: BoxFit.cover),
          // ),
          // ),
          SliverFixedExtentList(
            itemExtent: MediaQuery.of(context).padding.top,
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Contact",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          HeaderSliver(
              height: 60,
              child: Container(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(10),
                child: OutlineSearchBar(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  hintText: "Cari",
                  searchButtonPosition: SearchButtonPosition.leading,
                  searchButtonIconColor: Colors.black,
                  cursorColor: Colors.black,
                ),
              )),
          SliverStickyHeader(
            header: Container(
              height: 60.0,
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Header #0',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => ListTile(
                  leading: CircleAvatar(
                    child: Text('0'),
                  ),
                  title: Text('List tile #$i'),
                ),
                childCount: 20,
              ),
            ),
          ),
          SliverStickyHeader(
            header: Container(
              height: 60.0,
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Header #1',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => ListTile(
                  leading: CircleAvatar(
                    child: Text('0'),
                  ),
                  title: Text('List tile #$i'),
                ),
                childCount: 20,
              ),
            ),
          ),
          SliverStickyHeader(
            header: Container(
              height: 60.0,
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Header #2',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => ListTile(
                  leading: CircleAvatar(
                    child: Text('0'),
                  ),
                  title: Text('List tile #$i'),
                ),
                childCount: 20,
              ),
            ),
          )
        ]));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _handleRefresh();
  }
}
