import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../class/helper.dart';

class CustomBottomBar extends StatelessWidget {
  final String? dateTime;
  final void Function()? onTapColorIcon;

  const CustomBottomBar({super.key,this.dateTime,required this.onTapColorIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            SvgPicture.asset("assets/dots.svg"),
            Expanded(
              child: Text(
                getDate(dateTime),
                textAlign: TextAlign.center,
              ),
            ),
            //color icon
            GestureDetector(
              onTap: onTapColorIcon,
              child: const Icon(Icons.color_lens_outlined),
            )
          ],
        ),
      ),
    );
  }
}
