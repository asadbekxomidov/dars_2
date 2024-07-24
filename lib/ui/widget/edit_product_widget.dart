// import 'package:dars_2/core/constants/graphql_mutations.dart';
// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// class EditProductWidget extends StatefulWidget {
//   dynamic product;
//   EditProductWidget({required this.product});

//   @override
//   State<EditProductWidget> createState() => _EditProductWidgetState();
// }

// class _EditProductWidgetState extends State<EditProductWidget> {
//   final titleController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final priceController = TextEditingController();
//   final categoryIdController = TextEditingController();
//   final imageController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     titleController.text == widget.product['title'];
//     descriptionController.text == widget.product['desciription'];
//     priceController.text == widget.product['price'].toString();
//     // categoryIdController.text == widget.product['categoryId'].toString();
//     imageController.text == widget.product['images'][0].toString();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Product'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "title",
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: descriptionController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "desciription",
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: priceController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "price",
//               ),
//             ),
//             SizedBox(height: 10),
//             // TextField(
//             //   controller: categoryIdController,
//             //   decoration: InputDecoration(
//             //     border: OutlineInputBorder(),
//             //     hintText: "categoryId",
//             //   ),
//             // ),
//             SizedBox(height: 10),
//             TextField(
//               controller: imageController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "image",
//               ),
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     final client = GraphQLProvider.of(context).value;
//                     client.mutate(
//                       MutationOptions(
//                         document: gql(updateProduct),
//                         variables: {
//                           "id" : widget.product[0],
//                           "title": titleController.text,
//                           "price": priceController.text,
//                           "description": descriptionController.text,
//                           // "categoryId": categoryIdController.text,
//                           "images": imageController.text,
//                         },
//                         onCompleted: (dynamic resultdata) {
//                           print(resultdata);
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(widget.product),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: 40,
//                     width: 100,
//                     decoration: BoxDecoration(color: Colors.green.shade300),
//                     child: Center(child: Text('Edit Product')),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:dars_2/core/constants/graphql_mutations.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EditProductWidget extends StatefulWidget {
  final dynamic product;
  EditProductWidget({this.product});

  @override
  State<EditProductWidget> createState() => _EditProductWidgetState();
}

class _EditProductWidgetState extends State<EditProductWidget> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryIdController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      titleController.text = widget.product['title'];
      descriptionController.text = widget.product['description'];
      priceController.text = widget.product['price'].toString();
      imageController.text = widget.product['images'][0].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "title",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "description",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "price",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: imageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "image URL",
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    final client = GraphQLProvider.of(context).value;
                    if (widget.product == null) {
                      client.mutate(
                        MutationOptions(
                          document: gql(createProduct),
                          variables: {
                            "title": titleController.text,
                            "price": double.parse(priceController.text),
                            "description": descriptionController.text,
                            "categoryId": 2,  // Example category ID, you can modify as per your logic
                            "images": [imageController.text],
                          },
                          onCompleted: (dynamic resultdata) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Product added"),
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      );
                    } else {
                      client.mutate(
                        MutationOptions(
                          document: gql(updateProduct),
                          variables: {
                            "id": widget.product['id'],
                            "title": titleController.text,
                            "price": double.parse(priceController.text),
                            "description": descriptionController.text,
                            "images": [imageController.text],
                          },
                          onCompleted: (dynamic resultdata) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Product updated"),
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(color: Colors.green.shade300),
                    child: Center(child: Text(widget.product == null ? 'Add Product' : 'Edit Product')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
