import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonCondition extends StatelessWidget {
  const SkeletonCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2/1,
        ),
        itemCount: 7,
        itemBuilder: (context, index) {
          return Card(
            color: Theme.of(context).primaryColor,
            child: ListTile(
              title: Text('Item number $index as title'),
              subtitle: const Text('Subtitle here'),
              trailing: const Icon(Icons.ac_unit),
            ),
            // child: Container(
            //   height: 100.0,
            //   color: Colors.white,
            //   width: MediaQuery.of(context).size.width,
            // )
          );
        },
      ),
    );
  }
}





class BannerSkeletonCondition extends StatelessWidget {
  const BannerSkeletonCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item number $index as title'),
            subtitle: const Text('Subtitle here'),
            trailing: const Icon(Icons.ac_unit),
          );
        },
      ),
    );
  }
}
