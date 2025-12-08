import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef _AppLocale = ({String icon, Locale locale, String name});

class AppSelectLocaleWidget extends StatelessWidget {
  const AppSelectLocaleWidget({super.key});

  static const List<_AppLocale> _locales = [
    (name: 'English', locale: Locale('en'), icon: '🇺🇸'),
    (name: 'Bahasa Indonesia', locale: Locale('id'), icon: '🇮🇩'),
  ];

  Widget _buildDisplayName(_AppLocale locale) {
    return Row(
      spacing: 8.w,
      children: [
        DefaultText(locale.icon, fontSize: 14.sp),
        DefaultText(locale.name, fontSize: 14.sp),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final currentLocale = state.locale.data?.value ?? const Locale('en');
          final selectedAppLocale = _locales.firstWhere(
            (e) => e.locale == currentLocale,
            orElse: () => _locales.first,
          );
          return Select<_AppLocale>(
            value: selectedAppLocale,
            onChanged: (value) async {
              if (value == null) {
                context.showMyToast(
                  'Failed to change locale',
                  type: ToastType.failed,
                );
                return;
              }
              await context.read<AppCubit>().updateLocale(value.locale);
            },
            itemBuilder: (context, value) {
              return _buildDisplayName(value);
            },
            popup: (context) {
              return SelectPopup<_AppLocale>(
                items: SelectItemList(
                  children: [
                    DefaultText(
                      context.l10n.select_your_preferred_language,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ).withPadding(all: 8.h),
                    const Divider(),
                    ..._locales.map((e) {
                      return SelectItemButton(
                        value: e,
                        child: _buildDisplayName(e),
                      ).withPadding(vertical: 4.h);
                    }),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
