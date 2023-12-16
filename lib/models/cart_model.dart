class CartModel {
  String? message;
  bool? status;
  Data? data;

  CartModel({this.message, this.status, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {
  List<Cart>? cart;
  InvoiceSummary? invoiceSummary;

  Data({this.cart, this.invoiceSummary});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    invoiceSummary = json['invoice_summary'] != null
        ? new InvoiceSummary.fromJson(json['invoice_summary'])
        : null;
  }


}






class CartData {
  List<Cart>? cart;
  InvoiceSummary? invoiceSummary;

  CartData.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    invoiceSummary = json['invoice_summary'] != null
        ? new InvoiceSummary.fromJson(json['invoice_summary'])
        : null;
  }

}

class Cart {
  String? id;
  String? quantity;
  String? productTitle;
  String? productSelectedSizeTitle;
  String? productSelectedSizeId;
  String? productRate;
  String? productImage;
  String? productPrice;
  String? productId;
  String? userId;
  List<Extras>? extras;
  List<Types>? types;


  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'].toString();
    productTitle = json['product_title'];
    productSelectedSizeTitle = json['product_selected_size_title'];
    productSelectedSizeId = json['product_selected_size_id'];
    productRate = json['product_rate'].toString();
    productImage = json['product_image'];
    productPrice = json['product_price'].toString();
    productId = json['product_id'];
    userId = json['user_id'];
    if (json['extras'] != null) {
      extras = <Extras>[];
      json['extras'].forEach((v) {
        extras!.add(Extras.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(Types.fromJson(v));
      });
    }
  }

}

class InvoiceSummary {
  String? subTotalPrice;
  String? vatValue;
  String? appFees;
  String? totalPrice;
  String? shippingCharges;


  InvoiceSummary.fromJson(Map<String, dynamic> json) {
    subTotalPrice = json['sub_total_price'].toString();
    vatValue = json['vat_value'].toString();
    appFees = json['app_fees'].toString();
    shippingCharges = json['shipping_charges'].toString();
    totalPrice = json['total_price'].toString();
  }

}

class Extras {
  String? selectedExtra;
  String? selectedExtraName;
  String? selectedExtraPrice;

  Extras.fromJson(Map<String, dynamic> json) {
    selectedExtra = json['selected_extra'];
    selectedExtraName = json['selected_extra_name'];
    selectedExtraPrice = json['selected_extra_price'].toString();
  }
}

class Types {
  String? selectedType;
  String? selectedTypeName;
  String? selectedTypePrice;

  Types.fromJson(Map<String, dynamic> json) {
    selectedType = json['selected_type'];
    selectedTypeName = json['selected_type_name'];
    selectedTypePrice = json['selected_type_price'].toString();
  }

}
