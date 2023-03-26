import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/employees_controller.dart';
import 'controllers/reports_controller.dart';
import 'controllers/squads_controller.dart';
import 'core/responsiveness/screen_size.dart';
import 'modules/employees/pages/employees_page.dart';
import 'modules/home/pages/home_page.dart';
import 'modules/squads/pages/squads_page.dart';
import 'modules/squads/views/squads_data_view.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EmployeesController>(
          create: (context) => EmployeesController(),
        ),
        ChangeNotifierProvider<ReportsController>(
          create: (context) => ReportsController(),
        ),
        ChangeNotifierProvider<SquadsController>(
          create: (context) => SquadsController(),
        ),
        Provider<ScreenSize>(
          create: (context) => ScreenSize(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (_) => const HomePage(),
          '/squads': (_) => const SquadsPage(),
          '/squadsData': (_) => const SquadsDataView(),
          '/employees': (_) => const EmployeesPage(),
        },
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF4263EB),
            secondary: Color(0xFFFFFFFF),
            onSecondary: Color(0xFF495057),
            surface: Color(0xFFDDE2E5),
            tertiary: Color(0xFF212429),
            background: Color(0xFFF8F9FA),
            error: Color(0xFFF03D3E),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w500,
              color: Color(0xFF212429),
              fontFamily: 'Roboto',
            ),
            titleMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFFACB5BD),
              fontFamily: 'Roboto',
            ),
            titleSmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFFACB5BD),
              fontFamily: 'Roboto',
            ),
            bodyLarge: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4263EB),
              fontFamily: 'Roboto',
            ),
            bodyMedium: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w500,
              color: Color(0xFF212429),
              fontFamily: 'Roboto',
            ),
            bodySmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFFF03D3E),
              fontFamily: 'Roboto',
            ),
            displayLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Color(0xFF000000),
              fontFamily: 'Roboto',
            ),
            displayMedium: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w400,
              color: Color(0xFFDDE2E5),
              fontFamily: 'Roboto',
            ),
            displaySmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFFFFFF),
              fontFamily: 'Roboto',
            ),
            headlineMedium: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w400,
              color: Color(0xFF495057),
              fontFamily: 'Roboto',
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 1,
            backgroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFF4263EB),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          tabBarTheme: const TabBarTheme(
            labelColor: Color(0xFF212429),
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
            ),
            unselectedLabelColor: Color(0xFFACB5BD),
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
            ),
            indicatorSize: TabBarIndicatorSize.label,
          ),
          dataTableTheme: DataTableThemeData(
            headingRowColor:
                MaterialStateProperty.all<Color>(const Color(0xFF4263EB)),
            decoration: BoxDecoration(
              color: const Color(0XFFF8F9FA),
              borderRadius: BorderRadius.circular(13),
            ),
            headingTextStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
            ),
            dataTextStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xFF000000),
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }
}
