import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/consts/style.dart';

class SubCategoryWidget extends StatelessWidget {
  final String name;
  final String number;
  final bool upOrDown;
  final Widget amountWidget;
  const SubCategoryWidget({super.key, required this.name, required this.number, required this.upOrDown, required this.amountWidget});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width/2 -20,
      height: 130,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: theme.primaryColorDark,
        boxShadow: [
          BoxShadow(
            offset: const Offset(3, 3),
            color: theme.primaryColorDark.withOpacity(.5),
            blurRadius:10,
          ),
        ],
        // border: Border.all(width: 1,color: theme.primaryColorDark),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,style: AccountStyle.emailStyle.copyWith(fontSize: 12,color: theme.primaryColorLight)),
          const Gap(10.0),
          amountWidget,

          const Gap(10),
          Container(
            width: 80,
            decoration: BoxDecoration(
              color: upOrDown == true ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(10.0)
            ),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon( upOrDown == true ? Icons.arrow_upward : Icons.arrow_downward,size: 12.0,color: theme.primaryColorLight,),
                Text(number.toString(),style: AccountStyle.settingDescStyle.copyWith(fontSize: 12.0,color: theme.primaryColorLight),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TotalSalesWidget extends StatelessWidget {
  const TotalSalesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    int total = 0;
    return StreamBuilder(
      stream: orderListRef.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.hasError) {
          return const CircularProgressIndicator();
        } else {
          return Builder(
            
            builder: (BuildContext context) {
              for(int i = 0 ; i < snapshot.data!.docs.length ; i++){
                total = snapshot.data!.docs[i].get('total')+total;
              }
              return Text(
                '$total.00 Ks',
                style: AccountStyle.nameStyle.copyWith(fontSize: 14,color: theme.primaryColorLight),
              );
            },
          );
        }
      },
    );
  }
}



class TotalCustomersWidget extends StatelessWidget {
  const TotalCustomersWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    return Expanded(
      child: StreamBuilder(
        stream: userRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.hasError) {
            return const CircularProgressIndicator();
          } else {
            return Builder(
              builder: (BuildContext context) {
                return Text(
                  '${snapshot.data!.docs.length}',
                  style: AccountStyle.nameStyle.copyWith(color: theme.primaryColorLight),
                );
              },
            );
          }
        },
      ),
    );
  }
}



class TotalOrdersWidget extends StatelessWidget {
  const TotalOrdersWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    return Expanded(
      child: StreamBuilder(
        stream: orderListRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.hasError) {
            return const CircularProgressIndicator();
          } else {
            return Builder(
              builder: (BuildContext context) {
                return Text(
                  '${snapshot.data!.docs.length}',
                  style: AccountStyle.nameStyle.copyWith(color: theme.primaryColorLight),
                );
              },
            );
          }
        },
      ),
    );
  }
}



class TotalRevenuesWidget extends StatelessWidget {
  const TotalRevenuesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    int total = 0;
    return Expanded(
      child: StreamBuilder(
        stream: orderListRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.hasError) {
            return const CircularProgressIndicator();
          } else {
            return Builder(
              
              builder: (BuildContext context) {
                for(int i = 0 ; i < snapshot.data!.docs.length ; i++){
                  total = snapshot.data!.docs[i].get('total')+total;
                }
                var invest = total/2;
                return Text(
                  '${total-invest.toInt()}.00 Ks',
                  style: AccountStyle.nameStyle.copyWith(fontSize: 14,color: theme.primaryColorLight),
                );
              },
            );
          }
        },
      ),
    );
  }
}