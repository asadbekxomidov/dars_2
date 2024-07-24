// const String createProduct = """
// mutation addProduct(
//   \$title: String!, 
//   \$price: Float!, 
//   \$description: String!, 
//   \$categoryId: Float!,
//   \$images: [String!]!
// ) {
//     addProduct(
//       data: {
//         title: \$title, 
//         price:  \$price, 
//         description: \$description, 
//         categoryId: \$categoryId
//         images: \$images
//       }) {
//       id
//       title
//       price
//       description
//       images
//       category {
//         name
//       }
//     }
// }
// """;

// const String updateProduct = """
// mutation updateProduct(\$id: ID!, \$title: String, \$price: Float, \$description: String) {
// updateProduct(id: \$id, input: { title: \$title, price: \$price, description: \$description}) {
//     id
//     title
//     price
//     description
//   }
// }
// """;
//     // category {
//     // name
//     // }
//     // categoryId:\$categoryId
//     // \$categoryId: ID

// const String deleteProduct = """
// mutation deleteProduct(\$id: ID!) {
//   deleteProduct(id: \$id) {
//     id
//   }
// }
// """;






const String createProduct = """
mutation addProduct(
  \$title: String!, 
  \$price: Float!, 
  \$description: String!, 
  \$categoryId: Float!,
  \$images: [String!]!
) {
    addProduct(
      data: {
        title: \$title, 
        price:  \$price, 
        description: \$description, 
        categoryId: \$categoryId
        images: \$images
      }) {
      id
      title
      price
      description
      images
      category {
        name
      }
    }
}
""";

const String updateProduct = """
mutation updateProduct(\$id: ID!, \$title: String!, \$price: Float!, \$description: String!) {
  updateProduct(id: \$id, changes: { title: \$title, price: \$price, description: \$description}) {
    id
    title
    price
    description
  }
}
""";

const String deleteProduct = """
mutation deleteProduct(\$id: ID!) {
  deleteProduct(id: \$id)
}
""";
