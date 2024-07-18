import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/presentations/views/dashboard/components/product_category.dart';
import 'package:shop_init_admin/src/presentations/widgets/custom_app_bar.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(
              isAnimated: false,
              showSearchBar: false,
              showDefinedName: true,
              name: 'Management',
              showBack: false,
              isfilterOn: false,
              showColor: false,
            ),
          const Gap(10.0),
          Expanded(
            flex: 1,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3/2,
              ),
              itemCount: managementNames.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    switch (managementNames[index]) {
                      case 'Users Management':
                        navName(context, '/users');
                      case 'Orders Management':
                        navName(context, '/orderLists');
                      case 'Products Management':
                        navName(context, '/topSelling');
                      case 'Banner Management':
                        navName(context, '/viewBanners');
                    }
                  },
                  child: ProductCategoryWidget(name: managementNames[index], image: images[index]));
              },
            ),
          ),
          // Text("Popular Product",style: ViceStyle.titleStyle),
          // Expanded(child: StreamBuilder(
          //   // stream: orderLengthRef.doc('7882976').collection('orderLength').snapshots(),
          //   stream: orderLengthRef.snapshots(),
          //     builder: (context,snapshot)  {
          //       if(!snapshot.hasData){
          //         return Text("Empty");
          //       }
          //       else if (snapshot.hasError){
          //         return Text("Error");
          //       }
          //       else{
          //         // getTotalLength();
          //         if(snapshot.data!.docs.isEmpty){
          //           return Text("Nothing Place Yet.");
          //         }
          //         else{
          //           return Text(snapshot.data!.docs[0].id);
          //         }
          //       }
          //     },
          // ),)
        ],
      ),
    );
  }
}


