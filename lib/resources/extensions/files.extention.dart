import 'dart:io';

import 'package:flutter/material.dart';

extension FileExtensions on File? {
  Widget? get widgetOrNull => this != null ? Image.file(this!) : null;
}
