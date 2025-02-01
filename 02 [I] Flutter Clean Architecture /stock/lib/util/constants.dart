import 'package:flutter/material.dart';

cOutlineInputBorder(BuildContext context) => OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 2.0,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    );

const cLargeTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  overflow: TextOverflow.ellipsis,
);

const cMediumItalicTextStyle = TextStyle(
  fontStyle: FontStyle.italic,
  overflow: TextOverflow.ellipsis,
);

const cMediumTextStyle = TextStyle(
  overflow: TextOverflow.ellipsis,
);

const cSmallTextStyle = TextStyle(
  fontSize: 12.0,
);
