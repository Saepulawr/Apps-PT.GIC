import 'dart:convert';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:testptgic/module/API/Api.dart';
import 'package:testptgic/module/ContactPage/Function/FunctionContact.dart';
import 'package:testptgic/module/ContactPage/model/ModelContactAll.dart'
    as modelContactAll;
import 'package:testptgic/module/ContactPage/widget/CardContactList.dart';
import 'package:testptgic/module/headersliver/HeaderSliver.dart';
import 'package:testptgic/module/provider/PublicProvider.dart';

GlobalKey<ContactPageState> keyContact = GlobalKey();

class ContactPage extends StatefulWidget {
  ContactPage({Key? key}) : super(key: key);

  @override
  ContactPageState createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage>
    with AfterLayoutMixin<ContactPage> {
  GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey();
  bool _isLoading = true;
  late Size _screenSize;

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Theme.of(context).primaryColor,
          ),
          Expanded(child: _buildBody()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          onPressed: () async {
            FunctionContact().showFormContact(
                context: context,
                isEdit: false,
                onSuccess: () => handleRefresh());
          }
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

  Future<void> handleRefresh({String querySearch = ""}) async {
    print(querySearch);
    setState(() {
      _isLoading = true;
    });
    Provider.of<PublicProvider>(context, listen: false)
        .setModelContactAll(modelContactAll.ModelContact());
    //get data from API
    await API().getData(
      url: UrlApi().contactAll,
      params: {
        "sort_field": "nama", //sort by nama
        "sort_order": "ASC",
        "limit": "10000",
        "filter": querySearch,
        "field": "nama"
      },
      onComplete: (data, statusCode) {
        print(data);
        if (statusCode == 200) {
          try {
            Provider.of<PublicProvider>(context, listen: false)
                .setModelContactAll(
                    modelContactAll.ModelContact.fromJson(jsonDecode(data)));
          } catch (e) {}
        }
      },
    );
    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildBody() {
    modelContactAll.ModelContact modelContactPageAll =
        Provider.of<PublicProvider>(context).modelContactAll;
    Widget errorServer = SliverFixedExtentList(
        itemExtent: _screenSize.height * 0.8,
        delegate: SliverChildListDelegate([
          Center(
              child: Text("Failed connect to server!",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))
        ]));
    Widget loadingIndicator = SliverFixedExtentList(
        itemExtent: _screenSize.height * 0.8,
        delegate: SliverChildListDelegate([
          Center(
              child: SpinKitCubeGrid(
            color: Theme.of(context).primaryColor,
          ))
        ]));
    List<Widget> isi = [
      //title
      SliverFixedExtentList(
        itemExtent: MediaQuery.of(context).padding.top,
        delegate: SliverChildListDelegate(
          [
            Container(
              padding: EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  Icon(
                    Icons.contact_mail,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Contact",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      //search
      HeaderSliver(
          height: modelContactPageAll.total != null ? 40 : 50,
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: modelContactPageAll.total != null ? 0 : 10),
            child: OutlineSearchBar(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              hintText: "Cari",
              searchButtonPosition: SearchButtonPosition.leading,
              searchButtonIconColor: Colors.black,
              cursorColor: Colors.black,
              onSearchButtonPressed: (value) =>
                  handleRefresh(querySearch: value),
              onClearButtonPressed: (value) => handleRefresh(),
            ),
          )),
    ];

    if (_isLoading) {
      //Loading
      isi.add(loadingIndicator);
    } else {
      if (modelContactPageAll.total != null) {
        //load list
        Map<String, List<modelContactAll.Contact>> dataGroup = Map();
        modelContactPageAll.data!.contact!.forEach((element) {
          //check key with initial
          String initial = element.nama![0].toUpperCase();
          if (dataGroup.containsKey(initial)) {
            //add to keys
            dataGroup[initial]!.add(element);
          } else {
            //add key
            dataGroup.addAll({
              initial: [element]
            });
          }
        });
        List<Widget> list = _buildGroupList(dataGroup);
        if (list != null) {
          list.forEach((element) {
            isi.add(element);
          });
        } else {
          //error
          isi.add(errorServer);
        }
      } else {
        isi.add(errorServer);
      }
    }

    //add margin bottom safearea
    isi.add(SliverFixedExtentList(
        itemExtent: MediaQuery.of(context).padding.bottom,
        delegate: SliverChildListDelegate([Container()])));
    return LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        color: Theme.of(context).primaryColor,
        onRefresh: handleRefresh,
        child: CustomScrollView(slivers: isi));
  }

  List<Widget> _buildGroupList(
      Map<String, List<modelContactAll.Contact>> data) {
    List<Widget> wReturn = [];
    data.forEach((key, value) {
      wReturn.add(
        SliverStickyHeader(
          header: Container(
            color: Theme.of(context).primaryColor,
            child: ListTile(
                leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                key,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )),
          ),
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return CardContactList(contact: value[index]);
          }, childCount: value.length)),
        ),
      );
    });
    return wReturn;
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await API().requestToken("adm.ipul@gmail.com", "password");
    handleRefresh();
  }
}
