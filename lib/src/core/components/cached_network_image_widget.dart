import 'package:iserve/src/src.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  const CachedNetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.borderRadius = 12,
    this.height,
    this.width,
    this.iconSize = 24,
  });

  final String imageUrl;
  final BoxFit fit;
  final double borderRadius;
  final double? height;
  final double? width;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) => _buildShimmer(context),

      errorWidget: (context, url, error) => _buildErrorIcon(context),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return Container(
      color: Colors.grey.shade300.withValues(alpha: 0.4),
      alignment: Alignment.center,
      child: LoadingWidget(),
    );
  }

  Widget _buildErrorIcon(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: Icon(
        Icons.broken_image_outlined,
        color: Colors.grey.shade600,
        size: iconSize,
      ),
    );
  }
}
