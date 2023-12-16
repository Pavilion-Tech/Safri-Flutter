import 'package:flutter/material.dart';
import 'package:safri/modules/worng_screenss/wrong_screen.dart';
import 'package:safri/shared/images/images.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrongScreen(
        image: Images.maintenance,
        title: 'maintenance_title',
        desc: 'maintenance_desc',
      ),
    );
  }
}
