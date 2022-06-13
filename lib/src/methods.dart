import 'package:flutter/material.dart';

import 'res/styles.dart';

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
