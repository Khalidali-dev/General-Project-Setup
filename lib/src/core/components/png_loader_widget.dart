import 'package:iserve/src/src.dart';

class PngLoaderWidget extends StatelessWidget {
  const PngLoaderWidget({super.key, required this.png, required this.color});
  final String png;
  final Color color;

  @override
  Widget build(BuildContext context) =>
      Image.asset("assets/images/$png.png", color: color);
}
