import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'core/config/app_theme.dart';
import 'core/network/custom_http_client.dart';
import 'core/routes/app_router.dart';
import 'features/configuration/presentation/bloc/configuration_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/branch_management/presentation/bloc/branch_bloc.dart';
import 'core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  await di.init();

  runApp(const SellShebaConnectApp());
}

class SellShebaConnectApp extends StatefulWidget {
  const SellShebaConnectApp({super.key});

  @override
  State<SellShebaConnectApp> createState() => _SellShebaConnectAppState();
}

class _SellShebaConnectAppState extends State<SellShebaConnectApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    localization.init(
      mapLocales: [
        const MapLocale('en', {}), // Add translation maps here eventually
        const MapLocale('bn', {}),
      ],
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ConfigurationBloc>()),
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<BranchBloc>()),
      ],
      child: MaterialApp.router(
        title: 'SellSheba Connect',
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.system,
        routerConfig: router,
        supportedLocales: localization.supportedLocales,
        localizationsDelegates: localization.localizationsDelegates,
      ),
    );
  }
}
