import 'package:flutter/cupertino.dart';
import 'package:iserve/src/src.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: CupertinoActivityIndicator(color: Colors.white, radius: 15),
  );
}
