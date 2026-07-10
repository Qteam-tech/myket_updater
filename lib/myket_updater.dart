/// A Flutter plugin for checking app updates on the Myket store.
///
/// This plugin provides functionality to check for available updates
/// and open the Myket store page for the current application.
library myket_updater;

export 'src/myket_update_result.dart';
export 'src/myket_updater_platform_interface.dart';

import 'package:flutter/material.dart';
import 'src/myket_updater_platform_interface.dart';
import 'src/myket_update_result.dart';

/// A Flutter plugin for checking app updates on the Myket store.
///
/// This class provides static methods to check for available updates
/// and open the Myket store page for the current application.
class MyketUpdater {
  MyketUpdater._();

  /// Checks for available updates on the Myket store.
  ///
  /// Returns a [MyketUpdateResult] containing information about whether
  /// an update is available and its details.
  static Future<MyketUpdateResult> checkForUpdate() {
    return MyketUpdaterPlatform.instance.checkForUpdate();
  }

  /// Opens the Myket store page for the current application.
  ///
  /// Returns `true` if the page was opened successfully, `false` otherwise.
  static Future<bool> openMyketPage() {
    return MyketUpdaterPlatform.instance.openMyketPage();
  }

  /// Strips HTML tags from a string.
  ///
  /// This is useful for cleaning up update descriptions that may contain
  /// HTML formatting from the Myket store.
  static String stripHtmlTags(String html) {
    String result = html.replaceAll(RegExp(r'<br\s*/?>'), '\n');
    result = result.replaceAll(RegExp(r'<[^>]*>'), '');
    result = result.replaceAll('&nbsp;', ' ');
    result = result.replaceAll(RegExp(r'\n{3,}'), '\n\n');
    return result.trim();
  }

  /// Shows an update dialog to the user.
  ///
  /// This dialog informs the user that a new version is available and provides
  /// an option to update or dismiss the dialog.
  static void showUpdateDialog(BuildContext context, String description) {
    final cleanDescription = stripHtmlTags(description);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'به‌روزرسانی موجود است',
          textDirection: TextDirection.rtl,
        ),
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'نسخه جدیدی از برنامه موجود است.',
                textDirection: TextDirection.rtl,
              ),
              if (cleanDescription.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  cleanDescription,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                  maxLines: 10,
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('بعداً'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await MyketUpdater.openMyketPage();
            },
            child: const Text('به‌روزرسانی'),
          ),
        ],
      ),
    );
  }

  /// Checks for updates and shows a dialog if an update is available.
  ///
  /// This is a convenience method that combines [checkForUpdate] and
  /// [showUpdateDialog] into a single call.
  static Future<void> checkAndShowDialog(BuildContext context) async {
    final result = await checkForUpdate();
    if (result.isUpdateAvailable && context.mounted) {
      showUpdateDialog(context, result.description);
    }
  }
}
