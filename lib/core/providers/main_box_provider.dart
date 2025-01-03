import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resto_lite/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_box_provider.g.dart';

@Riverpod(keepAlive: true)
MainBoxMixin mainBoxMixin(Ref ref) {
  return MainBoxMixin();
}
