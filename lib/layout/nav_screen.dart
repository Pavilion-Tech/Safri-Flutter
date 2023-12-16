import 'package:flutter/material.dart';
import '../../shared/styles/colors.dart';
import 'cubit/cubit.dart';

class NavBar extends StatelessWidget {
  final List<Map<String, Widget>> items;
  NavBar({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = FastCubit.get(context);
    return SizedBox(
      height: 60,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            color: Colors.white,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((e) {
              return GestureDetector(
                onTap: () {

                  cubit.changeIndex(items.indexOf(e));
                },
                child: Container(
                  width: 100,
                    child: cubit.currentIndex == (items.indexOf(e))
                        ? e['activeIcon']
                        : e['icon']!),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
