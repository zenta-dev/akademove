import 'package:akademove/l10n/gen/app_localizations.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

export 'package:akademove/l10n/gen/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

// class IndonesianMaterialLocalizations
//     implements MaterialLocalizations {
//   /// Membuat objek yang mendefinisikan string terlokalisasi widget material
//   /// untuk Bahasa Indonesia.
//   ///
//   /// Implementasi [LocalizationsDelegate] biasanya memanggil fungsi statis [load],
//   /// daripada membuat kelas ini secara langsung.
//   const IndonesianMaterialLocalizations();

//   // Diurutkan sesuai DateTime.monday=1, DateTime.sunday=6
//   static const List<String> _shortWeekdays = <String>[
//     'Sen',
//     'Sel',
//     'Rab',
//     'Kam',
//     'Jum',
//     'Sab',
//     'Min',
//   ];

//   // Diurutkan sesuai DateTime.monday=1, DateTime.sunday=6
//   static const List<String> _weekdays = <String>[
//     'Senin',
//     'Selasa',
//     'Rabu',
//     'Kamis',
//     'Jumat',
//     'Sabtu',
//     'Minggu',
//   ];

//   static const List<String> _narrowWeekdays = <String>[
//     'M',
//     'S',
//     'S',
//     'R',
//     'K',
//     'J',
//     'S',
//   ];

//   static const List<String> _shortMonths = <String>[
//     'Jan',
//     'Feb',
//     'Mar',
//     'Apr',
//     'Mei',
//     'Jun',
//     'Jul',
//     'Agu',
//     'Sep',
//     'Okt',
//     'Nov',
//     'Des',
//   ];

//   static const List<String> _months = <String>[
//     'Januari',
//     'Februari',
//     'Maret',
//     'April',
//     'Mei',
//     'Juni',
//     'Juli',
//     'Agustus',
//     'September',
//     'Oktober',
//     'November',
//     'Desember',
//   ];

//   /// Mengembalikan jumlah hari dalam sebulan, menurut kalender
//   /// Gregorian proleptik.
//   ///
//   /// Ini menerapkan logika tahun kabisat yang diperkenalkan oleh reformasi Gregorian
//   /// tahun 1582. Tidak akan memberikan hasil yang valid untuk tanggal sebelum waktu itu.
//   int _getDaysInMonth(int year, int month) {
//     if (month == DateTime.february) {
//       final bool isLeapYear =
//           (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
//       if (isLeapYear) {
//         return 29;
//       }
//       return 28;
//     }
//     const List<int> daysInMonth = <int>[
//       31,
//       -1,
//       31,
//       30,
//       31,
//       30,
//       31,
//       31,
//       30,
//       31,
//       30,
//       31,
//     ];
//     return daysInMonth[month - 1];
//   }

//   @override
//   String formatHour(
//     TimeOfDay timeOfDay, {
//     bool alwaysUse24HourFormat = false,
//   }) {
//     final TimeOfDayFormat format = timeOfDayFormat(
//       alwaysUse24HourFormat: alwaysUse24HourFormat,
//     );
//     switch (format) {
//       case TimeOfDayFormat.h_colon_mm_space_a:
//         return formatDecimal(
//           timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod,
//         );
//       case TimeOfDayFormat.HH_colon_mm:
//         return _formatTwoDigitZeroPad(timeOfDay.hour);
//       case TimeOfDayFormat.a_space_h_colon_mm:
//       case TimeOfDayFormat.frenchCanadian:
//       case TimeOfDayFormat.H_colon_mm:
//       case TimeOfDayFormat.HH_dot_mm:
//         throw AssertionError('$runtimeType tidak mendukung $format.');
//     }
//   }

//   /// Memformat [number] menggunakan dua digit, dengan asumsi dalam rentang
//   /// inklusif 0-99. Tidak dirancang untuk memformat nilai di luar rentang ini.
//   String _formatTwoDigitZeroPad(int number) {
//     assert(0 <= number && number < 100);

//     if (number < 10) {
//       return '0$number';
//     }

//     return '$number';
//   }

//   @override
//   String formatMinute(TimeOfDay timeOfDay) {
//     final int minute = timeOfDay.minute;
//     return minute < 10 ? '0$minute' : minute.toString();
//   }

//   @override
//   String formatYear(DateTime date) => date.year.toString();

//   @override
//   String formatCompactDate(DateTime date) {
//     // Menggunakan format dd/mm/yyyy untuk Indonesia
//     final String day = _formatTwoDigitZeroPad(date.day);
//     final String month = _formatTwoDigitZeroPad(date.month);
//     final String year = date.year.toString().padLeft(4, '0');
//     return '$day/$month/$year';
//   }

//   @override
//   String formatShortDate(DateTime date) {
//     final String month = _shortMonths[date.month - DateTime.january];
//     return '${date.day} $month ${date.year}';
//   }

//   @override
//   String formatMediumDate(DateTime date) {
//     final String day = _shortWeekdays[date.weekday - DateTime.monday];
//     final String month = _shortMonths[date.month - DateTime.january];
//     return '$day, ${date.day} $month';
//   }

//   @override
//   String formatFullDate(DateTime date) {
//     final String month = _months[date.month - DateTime.january];
//     return '${_weekdays[date.weekday - DateTime.monday]}, ${date.day} $month ${date.year}';
//   }

//   @override
//   String formatMonthYear(DateTime date) {
//     final String year = formatYear(date);
//     final String month = _months[date.month - DateTime.january];
//     return '$month $year';
//   }

//   @override
//   String formatShortMonthDay(DateTime date) {
//     final String month = _shortMonths[date.month - DateTime.january];
//     return '${date.day} $month';
//   }

//   @override
//   DateTime? parseCompactDate(String? inputString) {
//     if (inputString == null) {
//       return null;
//     }

//     // Menggunakan format dd/mm/yyyy untuk Indonesia
//     final List<String> inputParts = inputString.split('/');
//     if (inputParts.length != 3) {
//       return null;
//     }

//     final int? year = int.tryParse(inputParts[2], radix: 10);
//     if (year == null || year < 1) {
//       return null;
//     }

//     final int? month = int.tryParse(inputParts[1], radix: 10);
//     if (month == null || month < 1 || month > 12) {
//       return null;
//     }

//     final int? day = int.tryParse(inputParts[0], radix: 10);
//     if (day == null || day < 1 || day > _getDaysInMonth(year, month)) {
//       return null;
//     }

//     try {
//       return DateTime(year, month, day);
//     } on ArgumentError {
//       return null;
//     }
//   }

//   @override
//   List<String> get narrowWeekdays => _narrowWeekdays;

//   @override
//   int get firstDayOfWeekIndex => 0; // narrowWeekdays[0] adalah 'M' untuk Minggu

//   @override
//   String get dateSeparator => '/';

//   @override
//   String get dateHelpText => 'dd/mm/yyyy';

//   @override
//   String get selectYearSemanticsLabel => 'Pilih tahun';

//   @override
//   String get unspecifiedDate => 'Tanggal';

//   @override
//   String get unspecifiedDateRange => 'Rentang Tanggal';

//   @override
//   String get dateInputLabel => 'Masukkan Tanggal';

//   @override
//   String get dateRangeStartLabel => 'Tanggal Mulai';

//   @override
//   String get dateRangeEndLabel => 'Tanggal Selesai';

//   @override
//   String dateRangeStartDateSemanticLabel(String formattedDate) =>
//       'Tanggal mulai $formattedDate';

//   @override
//   String dateRangeEndDateSemanticLabel(String formattedDate) =>
//       'Tanggal selesai $formattedDate';

//   @override
//   String get invalidDateFormatLabel => 'Format tidak valid.';

//   @override
//   String get invalidDateRangeLabel => 'Rentang tidak valid.';

//   @override
//   String get dateOutOfRangeLabel => 'Di luar rentang.';

//   @override
//   String get saveButtonLabel => 'Simpan';

//   @override
//   String get datePickerHelpText => 'Pilih tanggal';

//   @override
//   String get dateRangePickerHelpText => 'Pilih rentang';

//   @override
//   String get calendarModeButtonLabel => 'Beralih ke kalender';

//   @override
//   String get inputDateModeButtonLabel => 'Beralih ke input';

//   @override
//   String get timePickerDialHelpText => 'Pilih waktu';

//   @override
//   String get timePickerInputHelpText => 'Masukkan waktu';

//   @override
//   String get timePickerHourLabel => 'Jam';

//   @override
//   String get timePickerMinuteLabel => 'Menit';

//   @override
//   String get invalidTimeLabel => 'Masukkan waktu yang valid';

//   @override
//   String get dialModeButtonLabel => 'Beralih ke mode pemilih dial';

//   @override
//   String get inputTimeModeButtonLabel => 'Beralih ke mode input teks';

//   String _formatDayPeriod(TimeOfDay timeOfDay) {
//     return switch (timeOfDay.period) {
//       DayPeriod.am => anteMeridiemAbbreviation,
//       DayPeriod.pm => postMeridiemAbbreviation,
//     };
//   }

//   @override
//   String formatDecimal(int number) {
//     if (number > -1000 && number < 1000) {
//       return number.toString();
//     }

//     final String digits = number.abs().toString();
//     final StringBuffer result = StringBuffer(number < 0 ? '-' : '');
//     final int maxDigitIndex = digits.length - 1;
//     for (int i = 0; i <= maxDigitIndex; i += 1) {
//       result.write(digits[i]);
//       if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) {
//         result.write('.');
//       }
//     }
//     return result.toString();
//   }

//   @override
//   String formatTimeOfDay(
//     TimeOfDay timeOfDay, {
//     bool alwaysUse24HourFormat = false,
//   }) {
//     final StringBuffer buffer = StringBuffer();

//     // Tambahkan jam:menit.
//     buffer
//       ..write(
//         formatHour(timeOfDay, alwaysUse24HourFormat: alwaysUse24HourFormat),
//       )
//       ..write(':')
//       ..write(formatMinute(timeOfDay));

//     if (alwaysUse24HourFormat) {
//       // Tidak ada indikator AM/PM dalam format 24 jam.
//       return '$buffer';
//     }

//     // Tambahkan indikator AM/PM.
//     buffer
//       ..write(' ')
//       ..write(_formatDayPeriod(timeOfDay));
//     return '$buffer';
//   }

//   @override
//   String get openAppDrawerTooltip => 'Buka menu navigasi';

//   @override
//   String get backButtonTooltip => 'Kembali';

//   @override
//   String get clearButtonTooltip => 'Hapus teks';

//   @override
//   String get closeButtonTooltip => 'Tutup';

//   @override
//   String get deleteButtonTooltip => 'Hapus';

//   @override
//   String get moreButtonTooltip => 'Lainnya';

//   @override
//   String get nextMonthTooltip => 'Bulan berikutnya';

//   @override
//   String get previousMonthTooltip => 'Bulan sebelumnya';

//   @override
//   String get nextPageTooltip => 'Halaman berikutnya';

//   @override
//   String get previousPageTooltip => 'Halaman sebelumnya';

//   @override
//   String get firstPageTooltip => 'Halaman pertama';

//   @override
//   String get lastPageTooltip => 'Halaman terakhir';

//   @override
//   String get showMenuTooltip => 'Tampilkan menu';

//   @override
//   String get drawerLabel => 'Menu navigasi';

//   @override
//   String get menuBarMenuLabel => 'Menu bar menu';

//   @override
//   String get popupMenuLabel => 'Menu popup';

//   @override
//   String get dialogLabel => 'Dialog';

//   @override
//   String get alertDialogLabel => 'Peringatan';

//   @override
//   String get searchFieldLabel => 'Cari';

//   @override
//   String get currentDateLabel => 'Hari ini';

//   @override
//   String get selectedDateLabel => 'Dipilih';

//   @override
//   String get scrimLabel => 'Scrim';

//   @override
//   String get bottomSheetLabel => 'Bottom Sheet';

//   @override
//   String scrimOnTapHint(String modalRouteContentName) =>
//       'Tutup $modalRouteContentName';

//   @override
//   String aboutListTileTitle(String applicationName) =>
//       'Tentang $applicationName';

//   @override
//   String get licensesPageTitle => 'Lisensi';

//   @override
//   String licensesPackageDetailText(int licenseCount) {
//     assert(licenseCount >= 0);
//     return switch (licenseCount) {
//       0 => 'Tidak ada lisensi.',
//       1 => '1 lisensi.',
//       _ => '$licenseCount lisensi.',
//     };
//   }

//   @override
//   String pageRowsInfoTitle(
//     int firstRow,
//     int lastRow,
//     int rowCount,
//     bool rowCountIsApproximate,
//   ) {
//     return rowCountIsApproximate
//         ? '$firstRow–$lastRow dari sekitar $rowCount'
//         : '$firstRow–$lastRow dari $rowCount';
//   }

//   @override
//   String get rowsPerPageTitle => 'Baris per halaman:';

//   @override
//   String tabLabel({required int tabIndex, required int tabCount}) {
//     assert(tabIndex >= 1);
//     assert(tabCount >= 1);
//     return 'Tab $tabIndex dari $tabCount';
//   }

//   @override
//   String selectedRowCountTitle(int selectedRowCount) {
//     return switch (selectedRowCount) {
//       0 => 'Tidak ada item yang dipilih',
//       1 => '1 item dipilih',
//       _ => '$selectedRowCount item dipilih',
//     };
//   }

//   @override
//   String get cancelButtonLabel => 'Batal';

//   @override
//   String get closeButtonLabel => 'Tutup';

//   @override
//   String get continueButtonLabel => 'Lanjutkan';

//   @override
//   String get copyButtonLabel => 'Salin';

//   @override
//   String get cutButtonLabel => 'Potong';

//   @override
//   String get scanTextButtonLabel => 'Pindai teks';

//   @override
//   String get okButtonLabel => 'OK';

//   @override
//   String get pasteButtonLabel => 'Tempel';

//   @override
//   String get selectAllButtonLabel => 'Pilih semua';

//   @override
//   String get lookUpButtonLabel => 'Cari';

//   @override
//   String get searchWebButtonLabel => 'Cari di Web';

//   @override
//   String get shareButtonLabel => 'Bagikan';

//   @override
//   String get viewLicensesButtonLabel => 'Lihat lisensi';

//   @override
//   String get anteMeridiemAbbreviation => 'AM';

//   @override
//   String get postMeridiemAbbreviation => 'PM';

//   @override
//   String get timePickerHourModeAnnouncement => 'Pilih jam';

//   @override
//   String get timePickerMinuteModeAnnouncement => 'Pilih menit';

//   @override
//   String get modalBarrierDismissLabel => 'Tutup';

//   @override
//   String get menuDismissLabel => 'Tutup menu';

//   @override
//   ScriptCategory get scriptCategory =>
//       ScriptCategory.englishLike;

//   @override
//   TimeOfDayFormat timeOfDayFormat({
//     bool alwaysUse24HourFormat = false,
//   }) {
//     return alwaysUse24HourFormat
//         ? TimeOfDayFormat.HH_colon_mm
//         : TimeOfDayFormat.h_colon_mm_space_a;
//   }

//   @override
//   String get signedInLabel => 'Masuk';

//   @override
//   String get hideAccountsLabel => 'Sembunyikan akun';

//   @override
//   String get showAccountsLabel => 'Tampilkan akun';

//   @override
//   String get reorderItemUp => 'Pindah ke atas';

//   @override
//   String get reorderItemDown => 'Pindah ke bawah';

//   @override
//   String get reorderItemLeft => 'Pindah ke kiri';

//   @override
//   String get reorderItemRight => 'Pindah ke kanan';

//   @override
//   String get reorderItemToEnd => 'Pindah ke akhir';

//   @override
//   String get reorderItemToStart => 'Pindah ke awal';

//   @override
//   String get expandedIconTapHint => 'Ciutkan';

//   @override
//   String get collapsedIconTapHint => 'Perluas';

//   @override
//   String get expansionTileExpandedHint => 'ketuk dua kali untuk menciutkan';

//   @override
//   String get expansionTileCollapsedHint => 'ketuk dua kali untuk memperluas';

//   @override
//   String get expansionTileExpandedTapHint => 'Ciutkan';

//   @override
//   String get expansionTileCollapsedTapHint =>
//       'Perluas untuk detail lebih lanjut';

//   @override
//   String get expandedHint => 'Diciutkan';

//   @override
//   String get collapsedHint => 'Diperluas';

//   @override
//   String get RefreshTriggerSemanticLabel => 'Segarkan';

//   /// Membuat objek yang menyediakan nilai resource Bahasa Indonesia untuk
//   /// widget pustaka
//   ///
//   /// Parameter [locale] diabaikan.
//   ///
//   /// Metode ini biasanya digunakan untuk membuat [LocalizationsDelegate].
//   /// [MaterialApp] melakukannya secara default.
//   static Future<MaterialLocalizations> load(Locale locale) {
//     return SynchronousFuture<MaterialLocalizations>(
//       const IndonesianMaterialLocalizations(),
//     );
//   }

//   /// [LocalizationsDelegate] yang menggunakan [IndonesianMaterialLocalizations.load]
//   /// untuk membuat instance kelas ini.
//   ///
//   /// [MaterialApp] secara otomatis menambahkan nilai ini ke [MaterialApp.localizationsDelegates].
//   static const LocalizationsDelegate<MaterialLocalizations>
//   delegate = _MaterialLocalizationsDelegate();

//   @override
//   String remainingTextFieldCharacterCount(int remaining) {
//     return switch (remaining) {
//       0 => 'Tidak ada karakter tersisa',
//       1 => '1 karakter tersisa',
//       _ => '$remaining karakter tersisa',
//     };
//   }

//   @override
//   String get keyboardKeyAlt => 'Alt';

//   @override
//   String get keyboardKeyAltGraph => 'AltGr';

//   @override
//   String get keyboardKeyBackspace => 'Backspace';

//   @override
//   String get keyboardKeyCapsLock => 'Caps Lock';

//   @override
//   String get keyboardKeyChannelDown => 'Channel Down';

//   @override
//   String get keyboardKeyChannelUp => 'Channel Up';

//   @override
//   String get keyboardKeyControl => 'Ctrl';

//   @override
//   String get keyboardKeyDelete => 'Del';

//   @override
//   String get keyboardKeyEject => 'Eject';

//   @override
//   String get keyboardKeyEnd => 'End';

//   @override
//   String get keyboardKeyEscape => 'Esc';

//   @override
//   String get keyboardKeyFn => 'Fn';

//   @override
//   String get keyboardKeyHome => 'Home';

//   @override
//   String get keyboardKeyInsert => 'Insert';

//   @override
//   String get keyboardKeyMeta => 'Meta';

//   @override
//   String get keyboardKeyMetaMacOs => 'Command';

//   @override
//   String get keyboardKeyMetaWindows => 'Win';

//   @override
//   String get keyboardKeyNumLock => 'Num Lock';

//   @override
//   String get keyboardKeyNumpad1 => 'Num 1';

//   @override
//   String get keyboardKeyNumpad2 => 'Num 2';

//   @override
//   String get keyboardKeyNumpad3 => 'Num 3';

//   @override
//   String get keyboardKeyNumpad4 => 'Num 4';

//   @override
//   String get keyboardKeyNumpad5 => 'Num 5';

//   @override
//   String get keyboardKeyNumpad6 => 'Num 6';

//   @override
//   String get keyboardKeyNumpad7 => 'Num 7';

//   @override
//   String get keyboardKeyNumpad8 => 'Num 8';

//   @override
//   String get keyboardKeyNumpad9 => 'Num 9';

//   @override
//   String get keyboardKeyNumpad0 => 'Num 0';

//   @override
//   String get keyboardKeyNumpadAdd => 'Num +';

//   @override
//   String get keyboardKeyNumpadComma => 'Num ,';

//   @override
//   String get keyboardKeyNumpadDecimal => 'Num .';

//   @override
//   String get keyboardKeyNumpadDivide => 'Num /';

//   @override
//   String get keyboardKeyNumpadEnter => 'Num Enter';

//   @override
//   String get keyboardKeyNumpadEqual => 'Num =';

//   @override
//   String get keyboardKeyNumpadMultiply => 'Num *';

//   @override
//   String get keyboardKeyNumpadParenLeft => 'Num (';

//   @override
//   String get keyboardKeyNumpadParenRight => 'Num )';

//   @override
//   String get keyboardKeyNumpadSubtract => 'Num -';

//   @override
//   String get keyboardKeyPageDown => 'PgDown';

//   @override
//   String get keyboardKeyPageUp => 'PgUp';

//   @override
//   String get keyboardKeyPower => 'Power';

//   @override
//   String get keyboardKeyPowerOff => 'Power Off';

//   @override
//   String get keyboardKeyPrintScreen => 'Print Screen';

//   @override
//   String get keyboardKeyScrollLock => 'Scroll Lock';

//   @override
//   String get keyboardKeySelect => 'Select';

//   @override
//   String get keyboardKeyShift => 'Shift';

//   @override
//   String get keyboardKeySpace => 'Space';
// }

// class _MaterialLocalizationsDelegate
//     extends LocalizationsDelegate<MaterialLocalizations> {
//   const _MaterialLocalizationsDelegate();

//   @override
//   bool isSupported(Locale locale) => locale.languageCode == 'id';
//   @override
//   Future<MaterialLocalizations> load(Locale locale) {
//     return IndonesianMaterialLocalizations.load(locale);
//   }

//   @override
//   bool shouldReload(_MaterialLocalizationsDelegate old) => false;
// }
