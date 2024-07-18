import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/consts/uiconst.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('assets/img/shopping.gif'),
            ),
            Text('No Orders Yet!',style: ViceStyle.titleStyle,),

            // InkWell(
            //   onTap: () {
            //     navNameReplacement(context, '/');
            //   },
              
            //   child: Container(
            //     margin: const EdgeInsets.symmetric(
            //         horizontal: 20, vertical: 20),
            //     padding: const EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       borderRadius:
            //           BorderRadius.circular(10.0),
            //       color: Colors.blue,
            //     ),
            //     child: Center(
            //       child: Text(
            //         'Continue Shopping',
            //         style: ViceStyle.normalStyle.copyWith(color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}
