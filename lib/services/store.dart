import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/product.dart';

import '../constants.dart';
class Store{
  Firestore _firestore = Firestore.instance;

  addProduct(Product product){
    _firestore.collection(kProductCollection).add({
      kProductName        : product.pName,
      kProductPrice       : product.pPrice,
      kProductCategory    : product.pCategory,
      kProductDescription : product.pDescription,
      kProductLocation    : product.pLocation
    }
    );
  }
  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(kProductCollection).snapshots();
  }

  deleteDocument(documentId){
    _firestore.collection(kProductCollection).document(documentId).delete();
  }

  editProduct(data , documentId){
    _firestore.collection(kProductCollection).document(documentId).updateData(data);
  }
  storeOrders(data, List<Product> products) {
    var documentRef = _firestore.collection(kOrders).document();
    documentRef.setData(data);
    for (var product in products) {
      documentRef.collection(kOrderDetails).document().setData({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kProductQuantity: product.pQuantity,
        kProductLocation: product.pLocation,
        kProductCategory: product.pCategory
      });
    }
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _firestore
        .collection(kOrders)
        .document(documentId)
        .collection(kOrderDetails)
        .snapshots();
  }

}
