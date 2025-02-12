import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/asset_images.dart';

class NotificationMessage {
  static showError(BuildContext context, {required String message}) {
    _showMessage(context, message: message, isError: true);
  }

  static showSuccess(BuildContext context, {required String message}) {
    _showMessage(context, message: message, isError: false);
  }

  static Future _showMessage(BuildContext context,
      {required String message, required bool isError}) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 95.h,
        right: 0.0,
        child: _Messenger(
          message: message,
          isErrorMessage: isError,
        ),
      ),
    );
    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 2));
    overlayEntry.remove();
  }
}

class _Messenger extends StatelessWidget {
  final String message;
  final bool isErrorMessage;
  _Messenger({required this.message, required this.isErrorMessage});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: 69.h,
        width: MediaQuery.of(context).size.width * 0.65,
        decoration: BoxDecoration(
          color: Color(isErrorMessage ? 0xFFFFF5F4 : 0xFFE5F6EB),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 20.w, right: 18.w),
                child: SvgPicture.asset(isErrorMessage
                    ? AssetResources.ERROR_ICON
                    : AssetResources.SUCCESS_CHECK)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Text(
                  message,
                  maxLines: 3,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.sp,
                      color: Color(isErrorMessage ? 0xffEA4336 : 0xFF2FC55B)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
