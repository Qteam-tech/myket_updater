library myket_updater;

export 'src/myket_update_result.dart';
export 'src/myket_updater_platform_interface.dart';

import 'package:flutter/material.dart';
import 'src/myket_updater_platform_interface.dart';
import 'src/myket_update_result.dart';

class MyketUpdater {
  MyketUpdater._();

  static Future<MyketUpdateResult> checkForUpdate() {
    return MyketUpdaterPlatform.instance.checkForUpdate();
  }

  static Future<bool> openMyketPage() {
    return MyketUpdaterPlatform.instance.openMyketPage();
  }

  static String stripHtmlTags(String html) {
    String result = html.replaceAll(RegExp(r'<br\s*/?>'), '\n');
    result = result.replaceAll(RegExp(r'<[^>]*>'), '');
    result = result.replaceAll('&nbsp;', ' ');
    result = result.replaceAll(RegExp(r'\n{3,}'), '\n\n');
    return result.trim();
  }

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

  static Future<void> checkAndShowDialog(BuildContext context) async {
    final result = await checkForUpdate();
    if (result.isUpdateAvailable && context.mounted) {
      showUpdateDialog(context, result.description);
    }
  }
}
