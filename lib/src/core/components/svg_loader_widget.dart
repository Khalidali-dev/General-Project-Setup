import 'package:iserve/src/src.dart';

class SvgLoaderWidget extends StatelessWidget {
  const SvgLoaderWidget({
    super.key,
    required this.svg,
    this.color,
    this.width,
    this.height,
  });
  final String svg;
  final Color? color;
  final double? width, height;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    "assets/svg/$svg.svg",
    width: width,
    height: height,
    color: color,
  );
}
