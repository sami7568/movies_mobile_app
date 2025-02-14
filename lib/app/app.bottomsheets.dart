// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/bottom_sheets/notice/notice_sheet.dart';
import '../ui/bottom_sheets/proceed_to_pay/proceed_to_pay_sheet.dart';

enum BottomSheetType {
  notice,
  proceedToPay,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.notice: (context, request, completer) =>
        NoticeSheet(request: request, completer: completer),
    BottomSheetType.proceedToPay: (context, request, completer) =>
        ProceedToPaySheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
