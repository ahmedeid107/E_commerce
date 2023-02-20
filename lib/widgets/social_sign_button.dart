import 'package:e_commerce/style/constants.dart';
import 'package:flutter/material.dart';

class CustomSocialButon extends StatelessWidget {
  const CustomSocialButon(
      {super.key, this.onTap, required this.text, this.icon = const Text('')});
  final VoidCallback? onTap;
  final String text;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            side: MaterialStateProperty.all(
                const BorderSide(color: Color(0xFFEBF0FF))),
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 255, 255, 255)),
            elevation: MaterialStateProperty.all(0)),
        onPressed: onTap,
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Container(margin: const EdgeInsets.only(top: 7), child: icon),
            Container(
              margin: const EdgeInsets.all(18),
              child: Center(
                //  width: double.infinity,

                child: Text(
                  text,
                  style: small14700180,
                ),
              ),
            )
          ],
        ));
  }
}
