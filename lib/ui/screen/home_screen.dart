import 'package:dars_2/core/constants/garphql_queries.dart';
import 'package:dars_2/core/constants/graphql_mutations.dart';
import 'package:dars_2/ui/widget/edit_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade800,
        title: Text(
          "Products",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Query(
        options: QueryOptions(
          document: gql(fetchProducts),
        ),
        builder: (
          QueryResult result, {
          FetchMore? fetchMore,
          VoidCallback? refetch,
        }) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List products = result.data!['products'];

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(product['images'][0]
                      .substring(2, product['images'][0].length - 2)),
                ),
                title:
                    Text('${product['title']}', style: TextStyle(fontSize: 16)),
                subtitle: Text('${product['description']}',
                    style: TextStyle(fontSize: 12)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) =>
                                EditProductWidget(product: product),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: () {
                        final client = GraphQLProvider.of(context).value;
                        client.mutate(
                          MutationOptions(
                            document: gql(deleteProduct),
                            variables: {
                              "id": product['id'],
                            },
                            onCompleted: (dynamic resultdata) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Product deleted"),
                                ),
                              );
                              if (refetch != null) {
                                refetch();
                              }
                            },
                          ),
                        );
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => EditProductWidget(product: null),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
