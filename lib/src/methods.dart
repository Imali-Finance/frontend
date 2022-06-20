import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'res/styles.dart';

Future<void> storeData(String key,
    {bool? boolean, String? string, int? integer, List<String>? list, double? doub}) async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  if (boolean != null) {
    await _pref.setBool(key, boolean);
  }
  if (string != null) {
    await _pref.setString(key, string);
  }
  if (integer != null) {
    await _pref.setInt(key, integer);
  }
  if (list != null) {
    await _pref.setStringList(key, list);
  }
  if (doub != null) {
    await _pref.setDouble(key, doub);
  }
}

reloadPreferences() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  _pref.reload();
}

showSnackbar(BuildContext context, String message, {var action, String? actionLabel}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: background(context).withOpacity(0.5),
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              onPressed: action,
              textColor: primary(context),
            )
          : null,
      content: Text(
        message,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: primary(context),
        ),
      ),
    ),
  );
}

showBanner(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      backgroundColor: background(context),
      content: Text(message),
      actions: [
        IconButton(
          icon: Icon(
            Icons.close,
            color: primary(context),
          ),
          onPressed: () => ScaffoldMessenger.of(context).clearMaterialBanners(),
        )
      ],
    ),
  );
}
