class Product {
  int productId;
  double productPrice;
  String productName, productDescription, productImg, category;
  bool isLike;
  Product(
      {this.productId,
        this.productPrice,
        this.productName,
        this.productDescription,
        this.productImg,
        this.category,
        this.isLike});

  Map<String, dynamic> objectToMap() {
    return {
      'id': this.productId,
      'price': this.productPrice,
      'pName': this.productName,
      'pDescription': this.productDescription,
      'img': this.productImg,
      'category': this.category,
      'isLike': this.isLike,
    };
  }



}
