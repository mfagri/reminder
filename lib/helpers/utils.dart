import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remindly/helpers/icon_constants.dart';

Widget appIcon(
    String path, bool isDark, BuildContext context, double height, double width,
    {Color color = Colors.transparent}) {
  return SvgPicture.asset(
    path,
    matchTextDirection: true,
    height: height,
    width: width,
    theme: (isDark)
        ? SvgTheme(
            currentColor: Theme.of(context).colorScheme.primaryContainer,
          )
        : const SvgTheme(
            currentColor: Colors.white,
          ),
    fit: BoxFit.fill,
    colorFilter: (isDark)
        ? ColorFilter.mode(
            Theme.of(context).colorScheme.primaryContainer, BlendMode.srcIn)
        : (color != Colors.transparent)
            ? ColorFilter.mode(color, BlendMode.srcIn)
            : null,
  );
}

AppBar myAppbar(BuildContext context, String title) {
  return AppBar(
    forceMaterialTransparency: true,
    scrolledUnderElevation: 0,
    leading: Container(
      height: 100,
      color: const Color(0xffE3E3E3),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0.06,
                ),
              ),
              const Spacer(),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: appIcon(IconsConstants.back, false, context, 15, 15))
            ],
          ),
        ),
      ),
    ),
    leadingWidth: MediaQuery.of(context).size.width,
  );
}

Future<dynamic> loadingWidget(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff007AFF)),
            ),
          ));
}
