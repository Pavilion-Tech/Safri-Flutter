class SettingsModel {
  String? message;
  bool? status;
  Data? data;

  SettingsModel({this.message, this.status, this.data});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? projectLogo;
  int? isProjectInFactoryMode;
  String? projectMainBackgroundColor;
  String? projectMainTextColor;
  String? projectWhatsAppNumber;
  String? projectPhoneNumber;
  String? projectEmailAddress;
  String? projectFacebookLink;
  String? projectTwitterLink;
  String? projectInstagramLink;
  double? shippingChargers;
  int? vatValue;
  int? appFees;

  Data(
      {this.projectLogo,
        this.isProjectInFactoryMode,
        this.projectMainBackgroundColor,
        this.projectMainTextColor,
        this.projectWhatsAppNumber,
        this.projectPhoneNumber,
        this.projectEmailAddress,
        this.projectFacebookLink,
        this.projectTwitterLink,
        this.projectInstagramLink,
        this.shippingChargers,
        this.vatValue,
        this.appFees});

  Data.fromJson(Map<String, dynamic> json) {
    projectLogo = json['project_logo'];
    isProjectInFactoryMode = json['is_project_In_factory_mode'];
    projectMainBackgroundColor = json['project_main_background_color'];
    projectMainTextColor = json['project_main_text_color'];
    projectWhatsAppNumber = json['project_whats_app_number'];
    projectPhoneNumber = json['project_phone_number'];
    projectEmailAddress = json['project_email_address'];
    projectFacebookLink = json['project_facebook_link'];
    projectTwitterLink = json['project_twitter_link'];
    projectInstagramLink = json['project_instagram_link'];
    shippingChargers = json['shipping_chargers'];
    vatValue = json['vat_value'];
    appFees = json['app_fees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_logo'] = this.projectLogo;
    data['is_project_In_factory_mode'] = this.isProjectInFactoryMode;
    data['project_main_background_color'] = this.projectMainBackgroundColor;
    data['project_main_text_color'] = this.projectMainTextColor;
    data['project_whats_app_number'] = this.projectWhatsAppNumber;
    data['project_phone_number'] = this.projectPhoneNumber;
    data['project_email_address'] = this.projectEmailAddress;
    data['project_facebook_link'] = this.projectFacebookLink;
    data['project_twitter_link'] = this.projectTwitterLink;
    data['project_instagram_link'] = this.projectInstagramLink;
    data['shipping_chargers'] = this.shippingChargers;
    data['vat_value'] = this.vatValue;
    data['app_fees'] = this.appFees;
    return data;
  }
}