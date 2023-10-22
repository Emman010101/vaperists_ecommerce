import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaperists_ecommerce/data/global_vars.dart';

/////////////////////////////////////CRUD for products
//create data
Future createProducts(
    {required name,
    required imageName,
    required currentPrice,
    required oldPrice,
    required isLiked,
    required collection,
    required color}) async {
  final docProducts = FirebaseFirestore.instance.collection(collection).doc();

  final Products product = Products(
    id: docProducts.id,
    name: name,
    imageName: imageName,
    currentPrice: currentPrice,
    oldPrice: oldPrice,
    color: color,
  );

  final json = product.toJson();

  await docProducts.set(json);
}

// //read realtime data from firestore database
// Stream<List<Products>> readProducts(String collection) =>
//     FirebaseFirestore.instance.collection(collection).snapshots().map(
//         (snapshot) =>
//             snapshot.docs.map((doc) => Products.fromJson(doc.data())).toList());

Stream<List<Products>> readProducts(collection){
  var collections = FirebaseFirestore.instance.collection(collection);
  var snapshot = collections.snapshots();

  return snapshot.map((event) => event.docs.map((e) => Products.fromJson(e.data())).toList());

}

//read data from firestore database once
Future<Products?> readProduct(String id, String collection) async {
  final docProduct = FirebaseFirestore.instance.collection(collection).doc(id);
  final snapshot = await docProduct.get();

  if (snapshot.exists) {
    return Products.fromJson(snapshot.data()!);
  }
}

void deleteProduct(String collection) {
  final docProduct = FirebaseFirestore.instance
      .collection(collection)
      .doc("pZdBhIdd4MO7V2jX0jnE");

  docProduct.delete();
}

Future<void> deleteAllProducts(String colctn) async {
  final instance = FirebaseFirestore.instance;
  final batch = instance.batch();
  var collection = instance.collection(colctn);
  var snapshots = await collection.get();
  for (var doc in snapshots.docs) {
    batch.delete(doc.reference);
  }
  await batch.commit();
}

void updateProduct() {
  final docProduct = FirebaseFirestore.instance
      .collection('products')
      .doc("pZdBhIdd4MO7V2jX0jnE");

  docProduct.update({
    'name': "Emman",
  });
}

class Products {
  var id;
  final String name;
  final List<dynamic> imageName;
  final List<dynamic> currentPrice;
  final List<dynamic> oldPrice;
  final List<dynamic> color;

  Products({
    this.id = '',
    required this.name,
    required this.imageName,
    required this.currentPrice,
    required this.oldPrice,
    required this.color,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageName': imageName,
        'currentPrice': currentPrice,
        'oldPrice': oldPrice,
        'color': color,
      };

  static Products fromJson(Map<String, dynamic> json) => Products(
        id: json['id'],
        name: json['name'],
        imageName: json['imageName'],
        currentPrice: json['currentPrice'],
        oldPrice: json['oldPrice'],
        color: json['color'],
      );
}

////////////////////////////////////////////////////

class User {
  final String email;
  String name;
  List<dynamic> address;
  List<dynamic> contactNumber;
  Map<dynamic, dynamic> cart;
  Map<dynamic, dynamic> orders;

  User(
      {required this.email,
      this.name = '',
      required this.address,
      required this.contactNumber,
      required this.cart,
      required this.orders});

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'address': address,
        'contactNumber': contactNumber,
        'cart': cart,
        'orders': orders,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        name: json['name'],
        address: json['address'],
        contactNumber: json['contactNumber'],
        cart: json['cart'],
        orders: json['orders'],
      );
}

//create new user
Future createUser({required uid}) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

  await docUser.set({'uid': uid});
}

//create user for the first time
Future createFirstTimeUser() async {
  // var cartUserMap = new Map();
  // cartUserMap['itemsId'] = ['null'];
  // cartUserMap['itemQuantities'] = ['null'];
  // var orderUserMap = new Map();
  // orderUserMap['itemsId'] = ['null'];
  // orderUserMap['itemPrices'] = ['null'];
  // orderUserMap['itemsQuantities'] = ['null'];

  await createUser(uid: FirebaseAuth.instance.currentUser!.uid);
}

//add item to cart
Future addToCart(itemId, itemIndex, itemQuantity, uid) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(uid);
  final snapshot = await docUser.get();

  String clctn = '';

  switch (selectedCategoryValue) {
    case 0:
      clctn = 'pods';
      break;
    case 1:
      clctn = 'pod_mods';
      break;
    case 2:
      clctn = 'vape_pens';
      break;
    case 3:
      clctn = 'vape_mods';
      break;
  }
  //check if the cart field exists
  if (snapshot.data()!['cart'] == null) {
    var cartMap = new Map();
    cartMap['itemsId'] = [itemId];
    cartMap['itemsQuantity'] = [itemQuantity];
    cartMap['selectedItemIndex'] = [itemIndex];
    cartMap['collection'] = [clctn];

    var json = {'cart': cartMap};

    docUser.update(json);
  } else {
    Map<dynamic, dynamic> cartMap = snapshot.data()!['cart'];
    List<dynamic> cartArr = cartMap['itemsId'];

    for (var i = 0; i < cartArr.length; i++) {
      if (cartMap['itemsId'][i] == itemId &&
          cartMap['selectedItemIndex'][i] == itemIndex) {
        cartMap['itemsQuantity'][i] += itemQuantity;
        break;
      } else if (i == (cartArr.length - 1)) {
        cartMap['itemsId'].add(itemId);
        cartMap['itemsQuantity'].add(itemQuantity);
        cartMap['selectedItemIndex'].add(itemIndex);
        cartMap['collection'].add(clctn);
        break;
      }
    }
    var json = {'cart': cartMap};

    docUser.update(json);
    //print("MAP ${cartMap}");
    //print("Item Quantity ${itemQuantity}");
  }
}

//read data from firestore database once
// Future<User?> readUser(uid) async {
//   final docUser = FirebaseFirestore.instance.collection('users').doc(uid);
//   final snapshot = await docUser.get();
//
//   if (snapshot.exists) {
//     print("Snapshot::: ${User.fromJson(snapshot.data()!).cart}");
//     return User.fromJson(snapshot.data()!);
//   }
// }

class Cart {
  List<dynamic> collection;
  List<dynamic> itemsId;
  List<dynamic> itemsQuantity;
  List<dynamic> selectedItemIndex;

  Cart({
    required this.collection,
    required this.itemsId,
    required this.itemsQuantity,
    required this.selectedItemIndex,
  });

  static Cart fromJson(Map<dynamic, dynamic> json) => Cart(
        collection: json['collection'],
        itemsId: json['itemsId'],
        itemsQuantity: json['itemsQuantity'],
        selectedItemIndex: json['selectedItemIndex'],
      );
}

class FinalCartItems {
  List<dynamic> imageName;
  List<dynamic> name;
  List<dynamic> color;
  List<dynamic> currentPrice;
  List<dynamic> itemsQuantity;
  List<dynamic> collection;
  List<dynamic> itemsId;
  List<dynamic> selectedItemIndex;

  FinalCartItems({
    required this.imageName,
    required this.name,
    required this.color,
    required this.currentPrice,
    required this.itemsQuantity,
    required this.collection,
    required this.itemsId,
    required this.selectedItemIndex,
  });

  static FinalCartItems fromJson(Map<dynamic, dynamic> json) => FinalCartItems(
    imageName: json['imageName'],
    name: json['name'],
    color: json['color'],
    currentPrice: json['currentPrice'],
    itemsQuantity: json['itemsQuantity'],
    collection: json['collection'],
    itemsId: json['itemsId'],
    selectedItemIndex: json['selectedItemIndex'],
  );
}

// Stream<List<Products>> readProducts2(){
//   var collection = FirebaseFirestore.instance.collection('users');
//   var snapshot = collection.snapshots();
//
//   return snapshot.map((event) => event.docs.map((e) => Products.fromJson(e.data())).toList());
//
// }

//read cart
Future<FinalCartItems?> readCart(uid) async {
  Cart cartObj;
  Map<dynamic, List<dynamic>> cartFinalMap = new Map();
  var listOfItemToBeInsertedToMap = ['imageName', 'color', 'currentPrice'];
  final docCart = FirebaseFirestore.instance.collection('users').doc(uid);
  final cartSnapshot = await docCart.get();

  print("readCart Func is called");
  // List<dynamic> imageName;
  // List<dynamic> name;
  // List<dynamic> color;
  // List<dynamic> currentPrice;
  // List<dynamic> itemsQuantity;
  // List<dynamic> collection;
  // List<dynamic> itemsId;
  // List<dynamic> selectedItemIndex;

  for (var i = 0; i < listOfItemToBeInsertedToMap.length; i++) {
    cartFinalMap[listOfItemToBeInsertedToMap[i]] = [];
  }
  cartFinalMap['name'] = [];
  cartFinalMap['itemsQuantity'] = [];

  if (cartSnapshot.exists) {
    try {
      cartObj = Cart.fromJson(cartSnapshot.data()?['cart']!);
      cartFinalMap['collection'] = cartObj.collection;
      cartFinalMap['itemsId'] = cartObj.itemsId;
      cartFinalMap['selectedItemIndex'] = cartObj.selectedItemIndex;
      //print("CartOBJ ${cartObj.collection[0]}");

      for (var i = 0; i < cartObj.collection.length; i++) {
        final docProduct = FirebaseFirestore.instance
            .collection(cartObj.collection[i])
            .doc(cartObj.itemsId[i]);
        final productSnapshot = await docProduct.get();
        //imageName
        //name
        //color
        //currentPrice
        //itemQuantity
        for (var j = 0; j < listOfItemToBeInsertedToMap.length; j++) {
          cartFinalMap[listOfItemToBeInsertedToMap[j]]?.add(
              productSnapshot.data()?[listOfItemToBeInsertedToMap[j]]
                  [cartObj.selectedItemIndex[i]]);
        }
        cartFinalMap['name']?.add(productSnapshot.data()?['name']);
        cartFinalMap['itemsQuantity']?.add(cartObj.itemsQuantity[i]);
        //print("LOOP J ${cartObj.itemsQuantity[i]}");

        // print("Products ${productSnapshot.data()}");
        //listOfProducts.add(productSnapshot.data() as Products);
      }
    } catch (e) {
      print("no items in the cart");
    }
  }
  print(cartFinalMap);
  return FinalCartItems.fromJson(cartFinalMap);
}

//function for updating the quantities of the items in cart
Future updateCart(uid, FinalCartItems cartItems) async {
  try {
    final docCart = FirebaseFirestore.instance
        .collection('users')
        .doc(uid);

    var json = {
      'cart.itemsQuantity': cartItems.itemsQuantity,
    };

    //print("JSON ${cartItems.itemQuantity}");

    await docCart.update(json);
  }catch(e){
    print("Error: ${e}");
  }
}

Future deleteItemInCart(uid, Map<String, List<dynamic>> cartItems, List<dynamic> isItemChecked) async {
  Map<String, List<dynamic>>? newCartItems = {};
  final docCart = FirebaseFirestore.instance
      .collection('users')
      .doc(uid);

  newCartItems['collection'] = [];
  newCartItems['itemsId'] = [];
  newCartItems['itemsQuantity'] = [];
  newCartItems['selectedItemIndex'] = [];
  // List<dynamic> collection;
  // List<dynamic> itemsId;
  // List<dynamic> itemsQuantity;
  // List<dynamic> selectedItemIndex;
  print("ARRAY ${isItemChecked}");
  for(var i = 0; i < isItemChecked.length; i++){
    if(!isItemChecked[i]){
      newCartItems['collection']?.add(cartItems['collection']?.elementAt(i));
      newCartItems['itemsId']?.add(cartItems['itemsId']?.elementAt(i));
      newCartItems['itemsQuantity']?.add(cartItems['itemsQuantity']?.elementAt(i));
      newCartItems['selectedItemIndex']?.add(cartItems['selectedItemIndex']?.elementAt(i));
    }
  }

  if(newCartItems['collection']!.isEmpty){
    newCartItems = null;
  }
  var json = {
    'cart': newCartItems,
  };

  await docCart.update(json);
}


