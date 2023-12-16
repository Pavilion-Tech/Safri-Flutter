import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safri/modules/menu/cubit/menu_cubit.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/widgets/item_shared/default_appbar.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constant.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../widgets/menu/contact_us/compaints.dart';
import '../../../../widgets/menu/contact_us/track_complaints.dart';
// import '../../../chat/chat_screen.dart';
import '../../../chat/presentation/presentation/chat_screen.dart';


class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    _tabController =  TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          navigateTo(context, ChatScreen());
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFBDBDBD), // Shadow Grey Lite color
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: SvgPicture.asset(Images.chat,height: 40,width: 40,),

                  ),
                  AutoSizeText(tr("Chat_Now"),
                    minFontSize: 8,
                    maxLines: 1,style: TextStyle(color: Color(0xff4B4B4B),fontWeight: FontWeight.w600,fontSize: 14),)
                ],
              )),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () {
              return Future.delayed(Duration.zero,(){
                MenuCubit.get(context).getAllContactUs();
              });
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: size!.height,
              child: Column(
                children: [
                  DefaultAppBar(tr('contact_us')),
                  Expanded(
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.black,
                          indicatorColor: defaultColor,
                          indicatorPadding: EdgeInsets.zero,
                          labelStyle:const TextStyle(fontSize: 13),
                          tabs: [
                            Tab(
                              text: tr('complaints'),
                            ),
                            Tab(
                              text: tr('track_complaints'),
                            )
                          ],
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.label,
                        ),
                        Expanded(
                          child: TabBarView(
                              controller: _tabController,
                              children: [
                                Compaints(),
                                TrackComplaints(),
                              ]
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
