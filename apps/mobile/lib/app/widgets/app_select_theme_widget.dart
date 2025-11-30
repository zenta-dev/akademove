import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef _AppTheme = ({String name, ThemeMode themeMode, IconData icon});

class AppSelectThemeWidget extends StatelessWidget {
  const AppSelectThemeWidget({super.key});

  List<_AppTheme> _getThemes(BuildContext context) {
    return [
      (
        name: context.l10n.system_mode,
        themeMode: ThemeMode.system,
        icon: LucideIcons.smartphone,
      ),
      (
        name: context.l10n.light_mode,
        themeMode: ThemeMode.light,
        icon: LucideIcons.sun,
      ),
      (
        name: context.l10n.dark_mode,
        themeMode: ThemeMode.dark,
        icon: LucideIcons.moon,
      ),
    ];
  }

  Widget _buildDisplayName(_AppTheme theme) {
    return Row(
      spacing: 8.w,
      children: [
        Icon(theme.icon, size: 16.sp),
        DefaultText(theme.name, fontSize: 14.sp),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final currentThemeMode = state.data?.themeMode ?? ThemeMode.system;
          final themes = _getThemes(context);
          final selectedTheme = themes.firstWhere(
            (e) => e.themeMode == currentThemeMode,
            orElse: () => themes.first,
          );
          return Select<_AppTheme>(
            value: selectedTheme,
            onChanged: (value) async {
              if (value == null) {
                context.showMyToast(
                  'Failed to change theme',
                  type: ToastType.failed,
                );
                return;
              }
              await context.read<AppCubit>().updateThemeMode(value.themeMode);
            },
            itemBuilder: (context, value) {
              return _buildDisplayName(value);
            },
            popup: (BuildContext context) {
              return SelectPopup<_AppTheme>(
                items: SelectItemList(
                  children: [
                    DefaultText(
                      context.l10n.select_your_preferred_theme,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ).withPadding(all: 8.h),
                    const Divider(),
                    ...themes.map((e) {
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
