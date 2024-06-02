
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
  String? allowedPaymentMethods;
  Gifts? gifts;

  Data({this.cart, this.invoiceSummary});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    allowedPaymentMethods = json['allowed_payment_methods'];
    gifts = json['gifts'] != null ? new Gifts.fromJson(json['gifts']) : null;
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
  String? providerId;
  List<Extras>? extras;
  List<Types>? types;


  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'].toString();
    productTitle = json['product_title'];
    providerId = json['provider_id'];
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

class Gifts {
  List<GiftProducts>? products;
  List<Coupouns>? coupouns;
  List<WalletsPrices>? walletsPrices;

  Gifts({this.products, this.coupouns, this.walletsPrices});

  Gifts.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <GiftProducts>[];
      json['products'].forEach((v) {
        products!.add(new GiftProducts.fromJson(v));
      });
    }
    if (json['coupouns'] != null) {
      coupouns = <Coupouns>[];
      json['coupouns'].forEach((v) {
        coupouns!.add(new Coupouns.fromJson(v));
      });
    }
    if (json['wallets_prices'] != null) {
      walletsPrices = <WalletsPrices>[];
      json['wallets_prices'].forEach((v) {
        walletsPrices!.add(new WalletsPrices.fromJson(v));
      });
    }
  }

}

class GiftProducts {
  ProviderId? provider;
  String? title;
  String? id;
  String? mainImage;
  dynamic requiredPriceToUse;
  bool? isPriceEnoughToUse;


  GiftProducts.fromJson(Map<String, dynamic> json) {
    provider = json['provider_id'] != null ? new ProviderId.fromJson(json['provider_id']) : null;
    title = json['title'];
    id = json['id'];
    mainImage = json['main_image'];
    requiredPriceToUse = json['required_price_to_use'];
    isPriceEnoughToUse = json['is_price_enough_to_use'];
  }
}


class ProviderId{
  String? id;
  ProviderId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

}

class Coupouns {
  String? id;
  String? title;
  String? code;
  int? discountType;
  dynamic discountValue;
  dynamic requiredPriceToUse;
  bool? isPriceEnoughToUse;


  Coupouns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    requiredPriceToUse = json['required_price_to_use'];
    isPriceEnoughToUse = json['is_price_enough_to_use'];
  }
}


class WalletsPrices {
  String? id;
  dynamic requiredPriceToUse;
  bool? isPriceEnoughToUse;
  dynamic price;


  WalletsPrices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    requiredPriceToUse = json['required_price_to_use'];
    isPriceEnoughToUse = json['is_price_enough_to_use'];
  }
}
