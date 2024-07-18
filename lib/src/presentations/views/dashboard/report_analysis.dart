import 'package:flutter/material.dart';
import 'package:shop_init_admin/src/consts/constant.dart';
import 'package:shop_init_admin/src/presentations/views/dashboard/components/sub_category.dart';

class ReportAnalysisPart extends StatelessWidget {
  const ReportAnalysisPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubCategoryWidget(
              name: 'Total Sales',
              number: "12 %",
              upOrDown: subCategoryBools[0],
              amountWidget: const TotalSalesWidget(),
            ),
            SubCategoryWidget(
              name: 'Total Customers',
              number: "10 %",
              upOrDown: subCategoryBools[1],
              amountWidget: const TotalCustomersWidget(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubCategoryWidget(
              name: 'Total Orders',
              number: "11 %",
              upOrDown: subCategoryBools[1],
              amountWidget: const TotalOrdersWidget(),
            ),
            SubCategoryWidget(
              name: 'Total Revenues',
              number: "9 %",
              upOrDown: subCategoryBools[0],
              amountWidget: const TotalRevenuesWidget(),
            ),
          ],
        )
      ],
    );
  }
}
