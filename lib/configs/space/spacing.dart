// ignore_for_file: library_private_types_in_public_api

part of '../configs.dart';

class Space {
  /// Horizontal sized boxes
  static _H get x => _H();

  /// Vertical sized boxes
  static _V get y => _V();

  /// Padding presets
  static _Padding get p => _Padding();

  /// Margin presets
  static _Margin get m => _Margin();
}

/// Horizontal spacing widgets
class _H {
  SizedBox get t04 => const SizedBox(width: 4);
  SizedBox get t08 => const SizedBox(width: 8);
  SizedBox get t10 => const SizedBox(width: 10);
  SizedBox get t12 => const SizedBox(width: 12);
  SizedBox get t16 => const SizedBox(width: 16);
  SizedBox get t20 => const SizedBox(width: 20);
  SizedBox get t30 => const SizedBox(width: 30);
}

/// Vertical spacing widgets
class _V {
  SizedBox get t02 => const SizedBox(height: 2);
  SizedBox get t04 => const SizedBox(height: 4);
  SizedBox get t06 => const SizedBox(height: 6);
  SizedBox get t08 => const SizedBox(height: 8);
  SizedBox get t10 => const SizedBox(height: 10);
  SizedBox get t12 => const SizedBox(height: 12);
  SizedBox get t15 => const SizedBox(height: 15);
  SizedBox get t20 => const SizedBox(height: 20);
  SizedBox get t26 => const SizedBox(height: 26);
  SizedBox get t30 => const SizedBox(height: 30);
}

/// Padding options
class _Padding {
  final vertical = _VerticalPadding();
  final horizontal = _HorizontalPadding();
  final top = _TopPadding();
  final bottom = _BottomPadding();
  final all = _AllPadding();

  /// Common screen padding
  EdgeInsets get screen =>
      const EdgeInsets.symmetric(vertical: 15, horizontal: 20);

  /// Common list/grid view padding
  EdgeInsets get listView => const EdgeInsets.fromLTRB(16, 0, 16, 60);
}

class _VerticalPadding {
  EdgeInsets get t04 => const EdgeInsets.symmetric(vertical: 4);
  EdgeInsets get t08 => const EdgeInsets.symmetric(vertical: 8);
  EdgeInsets get t10 => const EdgeInsets.symmetric(vertical: 10);
  EdgeInsets get t15 => const EdgeInsets.symmetric(vertical: 15);
  EdgeInsets get t26 => const EdgeInsets.symmetric(vertical: 26);
}

class _HorizontalPadding {
  EdgeInsets get t04 => const EdgeInsets.symmetric(horizontal: 4);
  EdgeInsets get t08 => const EdgeInsets.symmetric(horizontal: 8);
  EdgeInsets get t10 => const EdgeInsets.symmetric(horizontal: 10);
  EdgeInsets get t16 => const EdgeInsets.symmetric(horizontal: 16);
  EdgeInsets get t20 => const EdgeInsets.symmetric(horizontal: 20);
}

class _TopPadding {
  EdgeInsets get t04 => const EdgeInsets.only(top: 4);
  EdgeInsets get t08 => const EdgeInsets.only(top: 8);
  EdgeInsets get t10 => const EdgeInsets.only(top: 10);
  EdgeInsets get t16 => const EdgeInsets.only(top: 16);
  EdgeInsets get t20 => const EdgeInsets.only(top: 20);
}

class _BottomPadding {
  EdgeInsets get t04 => const EdgeInsets.only(bottom: 4);
  EdgeInsets get t08 => const EdgeInsets.only(bottom: 8);
  EdgeInsets get t10 => const EdgeInsets.only(bottom: 10);
  EdgeInsets get t16 => const EdgeInsets.only(bottom: 16);
  EdgeInsets get t20 => const EdgeInsets.only(bottom: 20);
  EdgeInsets get t60 => const EdgeInsets.only(bottom: 60);
  EdgeInsets get t100 => const EdgeInsets.only(bottom: 100);
}

class _AllPadding {
  EdgeInsets get t04 => const EdgeInsets.all(4);
  EdgeInsets get t08 => const EdgeInsets.all(8);
  EdgeInsets get t10 => const EdgeInsets.all(10);
  EdgeInsets get t16 => const EdgeInsets.all(16);
  EdgeInsets get t20 => const EdgeInsets.all(20);
}

/// Margin options (same structure as Padding for consistency)
class _Margin {
  final vertical = _VerticalPadding();
  final horizontal = _HorizontalPadding();
  final top = _TopPadding();
  final bottom = _BottomPadding();
  final all = _AllPadding();

  /// Example common use
  EdgeInsets get card =>
      const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
}
