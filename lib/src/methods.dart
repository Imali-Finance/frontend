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
