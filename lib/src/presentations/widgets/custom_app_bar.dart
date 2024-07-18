import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';

class CustomAppBar extends StatelessWidget {
  final bool isAnimated;
  final bool showSearchBar;
  final bool showDefinedName;
  final String? name;
  final bool? showBack;
  final bool? showColor;
  final bool? isfilterOn;
  final Widget? filterWidget;

  const CustomAppBar(
      {super.key,
      this.showColor,
      this.isfilterOn,
      required this.isAnimated,
      required this.showSearchBar,
      this.name,
      required this.showDefinedName,

      this.showBack, this.filterWidget});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    return isAnimated
        ? FadeInDown(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: showBack == false
                        ? const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10)
                        : const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        showBack == true
                            ? IconButton(
                                onPressed: () {
                                  navPop(context);
                                },
                                icon: CircleAvatar(
                                    radius: 25.0,
                                    backgroundColor: showColor == true
                                        ? theme.primaryColor
                                        : Colors.transparent,
                                    child:  Icon(
                                      CupertinoIcons.back,
                                      color: theme.primaryColorDark,
                                    )))
                            : Container(),
                        Text(
                          showDefinedName
                              ? '$name'
                              : '${firebaseAuth.currentUser?.displayName}',
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: theme.primaryColorDark,
                          ),
                        ),
                        const Spacer(),
                        isfilterOn!
                            ? filterWidget ?? Container()
                            : Container(),
                      ],
                    ),
                  ),
                  showSearchBar
                      ? Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey.shade100,
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(3, 3),
                                  blurRadius: 6,
                                  color: Colors.black12,
                                )
                              ]),
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(ViceIcons.search),
                                border: InputBorder.none,
                                hintText: 'Search'),
                          ))
                      : Container(),
                ],
              ),
            ),
          )
        : Container(
            // height: kToolbarHeight,
            padding: showBack == false
                ? const EdgeInsets.only(left: 20.0, right: 20.0, top: 10)
                : const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showBack == true
                        ? IconButton(
                            onPressed: () {
                              navPop(context);
                            },
                            icon: CircleAvatar(
                                radius: 25.0,
                                backgroundColor: showColor == true
                                    ? theme.primaryColor
                                    : Colors.transparent,
                                child:  Icon(
                                  CupertinoIcons.back,
                                  color: theme.primaryColorDark,
                                )))
                        : Container(),
                    Text(
                      showDefinedName
                          ? name.toString()
                          : '${firebaseAuth.currentUser?.displayName}',
                      style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: theme.primaryColorDark,
                      ),
                    ),
                    const Spacer(),
                    isfilterOn!
                            ? filterWidget ?? Container()
                            : Container(),
                  ],
                ),
                showSearchBar
                    ? Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.shade100,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(3, 3),
                                blurRadius: 6,
                                color: Colors.black12,
                              )
                            ]),
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(ViceIcons.search),
                              border: InputBorder.none,
                              hintText: 'Search'),
                        ))
                    : Container(),
              ],
            ),
          );
  }
}
