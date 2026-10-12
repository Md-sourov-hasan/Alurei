import 'dart:io';

import 'package:alurei/src/imports/imports.dart';

class EditProfileAvatarPicker extends StatelessWidget {
  const EditProfileAvatarPicker({
    super.key,
    required this.imageFile,
    required this.photoUrl,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  final File? imageFile;
  final String? photoUrl;
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => _showImageSourceSheet(context),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(AppSpacing.xs.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.appColors.elevatedBackground,
              ),
              child: CircleAvatar(
                radius: 50.r,
                backgroundColor: AppColors.brandTealTrack,
                backgroundImage: _imageProvider(),
                child: _imageProvider() == null
                    ? Icon(
                        IconsaxPlusLinear.user,
                        size: 40.sp,
                        color: context.colors.primary,
                      )
                    : null,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(AppSpacing.sm.w),
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.appColors.elevatedBackground,
                    width: 2.w,
                  ),
                ),
                child: Icon(
                  IconsaxPlusLinear.export_1,
                  color: context.colors.onPrimary,
                  size: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider? _imageProvider() {
    if (imageFile != null) return FileImage(imageFile!);
    if (photoUrl != null && photoUrl!.isNotEmpty) {
      return CachedNetworkImageProvider(photoUrl!);
    }
    return null;
  }

  void _showImageSourceSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.appColors.elevatedBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: AppBorders.bottomSheet,
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  LangKey.editProfile.choosePhotoSource,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.colors.onSurface,
                  ),
                ),
                SizedBox(height: AppSpacing.md.h),
                _ImageSourceTile(
                  icon: IconsaxPlusLinear.camera,
                  title: LangKey.shared.takePhotoCamera,
                  onTap: () {
                    Navigator.of(context).pop();
                    onCameraTap();
                  },
                ),
                _ImageSourceTile(
                  icon: IconsaxPlusLinear.gallery,
                  title: LangKey.shared.choosePhotoGallery,
                  onTap: () {
                    Navigator.of(context).pop();
                    onGalleryTap();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ImageSourceTile extends StatelessWidget {
  const _ImageSourceTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: context.colors.primary),
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.appColors.primaryText,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
    );
  }
}
