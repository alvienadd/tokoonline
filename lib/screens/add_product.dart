import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tokoonline/screens/homepage.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlontroller = TextEditingController();

  Future saveProduct() async {
    final String url = 'http://10.113.129.56:8000/api/posts';
    final response = await http.post(Uri.parse(url), body: {
      "name": _nameController.text,
      "description": _descriptionController.text,
      "price": _priceController.text,
      "image_url": _imageUrlontroller.text,
    });
    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Product"),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "Name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Plrease enter product name";
                      }
                      return null;
                    }),
                TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: "Description"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Plrease enter Description name";
                      }
                      return null;
                    }),
                TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(labelText: "Price"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Plrease enter Price name";
                      }
                      return null;
                    }),
                TextFormField(
                    controller: _imageUrlontroller,
                    decoration: InputDecoration(labelText: "Image URL"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Plrease enter Image URL name";
                      }
                      return null;
                    }),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      // print(_nameController.text);
                      if (_formKey.currentState!.validate()) {
                        saveProduct().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Produk berhasil ditambah")));
                        });
                      }
                    },
                    child: Text("Save"))
              ],
            )));
  }
}
