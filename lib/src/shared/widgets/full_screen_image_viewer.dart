import 'package:alurei/src/imports/imports.dart';

class FullScreenImageViewer extends StatefulWidget {
  const FullScreenImageViewer({
    super.key,
    required this.imageUrl,
    this.imageUrls,
    this.initialIndex = 0,
    this.title,
    this.subtitle,
    this.index = 1,
    this.total = 1,
    this.heroTag,
    this.onDelete,
    this.onDownload,
  });

  final String imageUrl;
  final List<String>? imageUrls;
  final int initialIndex;
  final String? title;
  final String? subtitle;
  final int index;
  final int total;
  final Object? heroTag;
  final VoidCallback? onDelete;
  final VoidCallback? onDownload;

  static Future<T?> open<T>({
    required String imageUrl,
    List<String>? imageUrls,
    int initialIndex = 0,
    String? title,
    String? subtitle,
    int index = 1,
    int total = 1,
    Object? heroTag,
    VoidCallback? onDelete,
    VoidCallback? onDownload,
  }) {
    return Get.to<T>(
          () => FullScreenImageViewer(
            imageUrl: imageUrl,
            imageUrls: imageUrls,
            initialIndex: initialIndex,
            title: title,
            subtitle: subtitle,
            index: index,
            total: total,
            heroTag: heroTag,
            onDelete: onDelete,
            onDownload: onDownload,
          ),
          transition: Transition.fadeIn,
          duration: AppDurations.fast,
          fullscreenDialog: true,
        ) ??
        Future<T?>.value();
  }

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late final List<String> _images;
  late final PageController _pageController;
  late final int _initialPage;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    final imageUrls = widget.imageUrls;
    _images = imageUrls == null || imageUrls.isEmpty
        ? [widget.imageUrl]
        : imageUrls.toList(growable: false);
    _initialPage = widget.initialIndex.clamp(0, _images.length - 1);
    _currentIndex = _initialPage;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final image = _ZoomableImage(imageUrl: _images[index]);
                  if (widget.heroTag == null || index != _initialPage) {
                    return image;
                  }
                  return Hero(tag: widget.heroTag!, child: image);
                },
              ),
            ),
            PositionedDirectional(
              top: 24.h,
              start: 24.w,
              end: 24.w,
              child: Row(
                children: [
                  _ViewerIconButton(
                    icon: IconsaxPlusLinear.arrow_left,
                    onPressed: Get.back<void>,
                  ),
                  const Spacer(),
                  Text(
                    _counterText,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const Spacer(),
                  if (widget.onDelete != null)
                    _ViewerIconButton(
                      icon: IconsaxPlusLinear.trash,
                      onPressed: widget.onDelete!,
                      transparent: true,
                    )
                  else
                    SizedBox(width: 44.w), // To keep the 1/1 centered
                ],
              ),
            ),
            if ((widget.title?.trim().isNotEmpty ?? false) ||
                (widget.subtitle?.trim().isNotEmpty ?? false))
              PositionedDirectional(
                start: 24.w,
                end: 24.w,
                bottom: 48.h,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.title?.trim().isNotEmpty ?? false)
                      Text(
                        widget.title!.trim(),
                        textAlign: TextAlign.center,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 16.sp,
                          height: 24 / 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    if (widget.subtitle?.trim().isNotEmpty ?? false) ...[
                      SizedBox(height: 2.h),
                      Text(
                        widget.subtitle!.trim(),
                        textAlign: TextAlign.center,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 12.sp,
                          height: 18 / 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.neutral400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String get _counterText {
    if (_images.length == 1 && widget.total > 1) {
      return '${widget.index} / ${widget.total}';
    }
    return '${_currentIndex + 1} / ${_images.length}';
  }
}

class _ZoomableImage extends StatelessWidget {
  const _ZoomableImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: _imageProvider(imageUrl),
      backgroundDecoration: const BoxDecoration(
        color: AppColors.blackColor,
      ),
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 3,
      loadingBuilder: (context, event) => const Center(
        child: CircularProgressIndicator(color: AppColors.whiteColor),
      ),
      errorBuilder: (context, error, stackTrace) => Center(
        child: Icon(
          IconsaxPlusBold.image,
          size: 56.sp,
          color: AppColors.neutral500,
        ),
      ),
    );
  }

  ImageProvider<Object> _imageProvider(String value) {
    if (value.startsWith('http')) return CachedNetworkImageProvider(value);
    return AssetImage(value);
  }
}

class _ViewerIconButton extends StatelessWidget {
  const _ViewerIconButton({
    required this.icon,
    required this.onPressed,
    this.transparent = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool transparent;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: transparent
          ? AppColors.transparentColor
          : AppColors.whiteColor.withValues(alpha: 0.1),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40.w,
          height: 40.w,
          child: Icon(
            icon,
            size: 22.sp,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
