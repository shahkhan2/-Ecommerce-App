import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_toast.dart';
import '../../../core/widgets/app_text.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';

/// User profile screen.
///
/// Features:
/// - Static mock profile with stats (Orders / Wishlist / Wallet)
/// - Theme toggle (light ↔ dark) powered by [ThemeProvider]
/// - Language toggle (English ↔ Spanish) powered by [LocaleProvider]
/// - Preference tiles (Notifications, Privacy, Logout)
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final isEnglish = context.watch<LocaleProvider>().isEnglish;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // ---------------------------------------------------------------- Header
            _ProfileHeader(scheme: scheme),

            // ---------------------------------------------------------------- Stats
            _StatsRow(),

            const SizedBox(height: 24),

            // --------------------------------------------------------------- Settings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(title: l10n.profileSettings),
                  const SizedBox(height: 8),

                  _SettingsCard(
                    children: [
                      // Dark Mode
                      _ToggleTile(
                        icon: Icons.dark_mode_outlined,
                        iconColor: AppColors.primaryDark,
                        title: l10n.profileDarkMode,
                        subtitle: AppStrings.profileThemeFeature,
                        value: isDark,
                        onChanged: (_) =>
                            context.read<ThemeProvider>().toggleTheme(),
                      ),

                      _Divider(),

                      // Language
                      _ToggleTile(
                        icon: Icons.translate_rounded,
                        iconColor: AppColors.secondary,
                        title: l10n.profileLanguage,
                        subtitle: isEnglish
                            ? AppStrings.langEnglish
                            : AppStrings.langSpanish,
                        value: !isEnglish,
                        onChanged: (_) =>
                            context.read<LocaleProvider>().toggleLocale(),
                      ),

                      _Divider(),

                      // Notifications
                      _ToggleTile(
                        icon: Icons.notifications_outlined,
                        iconColor: AppColors.accent,
                        title: l10n.profileNotifications,
                        subtitle: 'Push & email alerts',
                        value: true,
                        onChanged: (_) => AppToast.show(
                          context,
                          'Notification preference saved',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ---- Navigation tiles ----
                  _SettingsCard(
                    children: [
                      _NavTile(
                        icon: Icons.receipt_long_outlined,
                        iconColor: AppColors.info,
                        title: 'My Orders',
                        subtitle:
                            '${AppStrings.profileOrdersCount} recent orders',
                        onTap: () =>
                            AppToast.show(context, 'Orders coming soon!'),
                      ),
                      _Divider(),
                      _NavTile(
                        icon: Icons.favorite_border_rounded,
                        iconColor: AppColors.error,
                        title: 'Wishlist',
                        subtitle:
                            '${AppStrings.profileWishlistCount} saved items',
                        onTap: () =>
                            AppToast.show(context, 'Wishlist coming soon!'),
                      ),
                      _Divider(),
                      _NavTile(
                        icon: Icons.account_balance_wallet_outlined,
                        iconColor: AppColors.success,
                        title: 'Wallet',
                        subtitle: AppStrings.profileWalletBalance,
                        onTap: () =>
                            AppToast.show(context, 'Wallet coming soon!'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _SettingsCard(
                    children: [
                      _NavTile(
                        icon: Icons.privacy_tip_outlined,
                        iconColor: AppColors.textSecondaryLight,
                        title: l10n.profilePrivacy,
                        onTap: () =>
                            AppToast.show(context, 'Opening privacy policy…'),
                      ),
                      _Divider(),
                      _NavTile(
                        icon: Icons.logout_rounded,
                        iconColor: AppColors.error,
                        title: l10n.profileLogout,
                        titleColor: AppColors.error,
                        onTap: () => _confirmLogout(context, l10n),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Version
                  Center(
                    child: AppText.labelSmall(
                      AppStrings.profileVersion,
                      color: scheme.onSurface.withAlpha(100),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------------- helpers
  Future<void> _confirmLogout(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.commonCancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              AppToast.show(context, 'Logged out (demo)');
            },
            child: Text(l10n.profileLogout),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------- Header
class _ProfileHeader extends StatelessWidget {
  final ColorScheme scheme;
  const _ProfileHeader({required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withAlpha(30),
              border: Border.all(color: Colors.white.withAlpha(120), width: 3),
            ),
            child: const Center(
              child: Text(
                'AJ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            AppStrings.profileName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppStrings.profileEmail,
            style: TextStyle(color: Colors.white.withAlpha(190), fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            AppStrings.profileJoined,
            style: TextStyle(color: Colors.white.withAlpha(160), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------- Stats Row
class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDark ? 20 : 8),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _StatItem(
            value: AppStrings.profileOrdersCount,
            label: AppStrings.profileOrders,
            icon: Icons.receipt_long_outlined,
          ),
          VerticalDivider(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          _StatItem(
            value: AppStrings.profileWishlistCount,
            label: AppStrings.profileWishlist,
            icon: Icons.favorite_border_rounded,
          ),
          VerticalDivider(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          _StatItem(
            value: AppStrings.profileWalletBalance,
            label: AppStrings.profileWallet,
            icon: Icons.account_balance_wallet_outlined,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: scheme.primary, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: scheme.onSurface,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: scheme.onSurface.withAlpha(140),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------- Helpers
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: AppText.titleMedium(
        title,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(160),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
        ),
      ),
      child: Column(children: children),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _IconBox(icon: icon, color: iconColor),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(value: value, onChanged: onChanged),
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final VoidCallback? onTap;

  const _NavTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.titleColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _IconBox(icon: icon, color: iconColor),
      title: Text(
        title,
        style: titleColor != null ? TextStyle(color: titleColor) : null,
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: const Icon(Icons.chevron_right_rounded, size: 20),
      onTap: onTap,
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _IconBox({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 56,
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.dividerDark
          : AppColors.dividerLight,
    );
  }
}
