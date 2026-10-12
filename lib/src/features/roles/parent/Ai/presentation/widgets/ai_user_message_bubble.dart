import 'dart:io';

import 'package:alurei/src/imports/imports.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/parent_ai_message.dart';

class AiUserMessageBubble extends StatelessWidget {
  const AiUserMessageBubble({
    super.key,
    required this.message,
  });

  final ParentAiMessage message;

  @override
  Widget build(BuildContext context) {
    final bool hasImage = message.imageUrl != null && message.imageUrl!.isNotEmpty;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.75,
        ),
        padding: EdgeInsets.all(hasImage ? 4.r : 16.r),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 158, 158, 0.08),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(4.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasImage) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  height: 180.h,
                  width: double.infinity,
                  child: _buildImageWidget(message.imageUrl!),
                ),
              ),
            ],
            if (message.text.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.all(hasImage ? 8.r : 0),
                child: Text(
                  message.text,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.primary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    height: 24 / 16,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(color: Colors.grey.shade200),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey.shade300,
          child: Icon(Icons.broken_image, size: 40.r, color: Colors.grey.shade600),
        ),
      );
    } else if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey.shade300,
          child: Icon(Icons.broken_image, size: 40.r, color: Colors.grey.shade600),
        ),
      );
    } else {
      final file = File(url);
      if (file.existsSync()) {
        return Image.file(
          file,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey.shade300,
            child: Icon(Icons.broken_image, size: 40.r, color: Colors.grey.shade600),
          ),
        );
      }
      return Container(
        color: Colors.grey.shade300,
        child: Icon(Icons.broken_image, size: 40.r, color: Colors.grey.shade600),
      );
    }
  }
}
