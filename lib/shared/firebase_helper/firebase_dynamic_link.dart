

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import '../../models/provider_category_model.dart';
import '../../models/single_provider_model.dart';


class FirebaseDynamicLinkService {
  static Future<Uri> createDynamicLinkProvider({required ProviderData  ProviderData}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      // This should match firebase but without the username query param
      uriPrefix: 'https://safriapp.page.link',
      // This can be whatever you want for the uri, https://yourapp.com/groupinvite?username=$userName
      link: Uri.parse('https://safriapp.page.link/provider?id=${ProviderData.id}&name=RestaurantScreen'),
      androidParameters: AndroidParameters(
        // fallbackUrl: ,
        packageName: 'com.safri.pavilion',
        minimumVersion: 1,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.safri.pavilion',
        minimumVersion: '1',
        appStoreId: '6470750165',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title:tr("Picture_of_the_restaurant"),
        imageUrl:  Uri.parse("${ProviderData.personalPhoto}/${ProviderData.name}")

      ),
    );
    // final link = await parameters.buildUrl();
    // final ShortDynamicLink shortenedLink = await DynamicLinkParameters.shortenUrl(
    //   link,
    //   DynamicLinkParametersOptions(shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    // );
    // return shortenedLink.shortUrl;

    final ShortDynamicLink shortenedLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    return shortenedLink.shortUrl;
  }


}
