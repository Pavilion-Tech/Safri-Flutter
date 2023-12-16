import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';





class AbbBarChat extends StatefulWidget {
  final String avatar,name;
  const AbbBarChat({super.key, required this.avatar, required this.name});

  @override
  State<AbbBarChat> createState() => _AbbBarChatState();
}

class _AbbBarChatState extends State<AbbBarChat> {
  _launchURL(url) async {
    await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [

    ]);
  }
}
