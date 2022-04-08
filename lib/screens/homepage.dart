import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tokoonline/screens/add_product.dart';
import 'package:tokoonline/screens/edit_product.dart';
import 'package:tokoonline/screens/product_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'http://10.113.129.56:8000/api/posts';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteProduct(String productId) async {
    String url = "http://10.113.129.56:8000/api/posts/" + productId;
    var response = await http.delete(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddProduct()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(title: Text('Pokemon')),
        body: FutureBuilder(
            future: getProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // return Text('Data Oke');
                return ListView.builder(
                    itemCount: (snapshot.data as dynamic)['data'].length,
                    itemBuilder: (context, index) {
                      // return Text(snapshot.data['data'][index]['title'])
                      // return Text(
                      //     (snapshot.data as dynamic)['data'][index]['title']);
                      return Container(
                        height: 180,
                        child: Card(
                            elevation: 5,
                            child: Row(children: [
                              // Text((snapshot.data as dynamic)['data'][index]
                              //     ['title']),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                              product: (snapshot.data
                                                  as dynamic)['data'][index])));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  height: 120,
                                  width: 120,
                                  child: Image.network((snapshot.data
                                      as dynamic)['data'][index]['image_url']),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            (snapshot.data as dynamic)['data']
                                                [index]['title'],
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              (snapshot.data as dynamic)['data']
                                                  [index]['content']),
                                        ),
                                        // Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.spaceBetween,
                                        //     children: [
                                        //       Row(children: [
                                        //         GestureDetector(
                                        //             onTap: () {
                                        //               Navigator.push(
                                        //                   context,
                                        //                   MaterialPageRoute(
                                        //                       builder: (context) => EditProduct(
                                        //                           product: (snapshot
                                        //                                       .data
                                        //                                   as dynamic)['data']
                                        //                               [
                                        //                               index])));
                                        //             },
                                        //             child: Icon(Icons.edit)),
                                        //         GestureDetector(
                                        //             onTap: () {
                                        //               deleteProduct((snapshot.data
                                        //                                   as dynamic)[
                                        //                               'data']
                                        //                           [index]['id']
                                        //                       .toString())
                                        //                   .then((value) {
                                        //                 setState(() {});
                                        //                 ScaffoldMessenger.of(
                                        //                         context)
                                        //                     .showSnackBar(SnackBar(
                                        //                         content: Text(
                                        //                             'Produk berhasil dihapus')));
                                        //               });
                                        //             },
                                        //             child: Icon(Icons.delete)),
                                        //       ]),
                                        //       // Text((snapshot.data
                                        //       //         as dynamic)['data'][index]
                                        //       //     ['price']),
                                        //     ]),
                                      ]),
                                ),
                              ),
                            ])),
                      );
                    });
              } else {
                return Text('Data Error');
              }
            }));
  }
}
