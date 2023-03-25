import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/reports_controller.dart';
import '../../../core/ui/ui_button.dart';
import '../../../core/utils/app_images.dart';
import '../../employees/pages/employees_page.dart';
import '../../squads/pages/squads_page.dart';
import '../../squads/views/squads_data_view.dart';
import '../widgets/reports_register_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(AppImages.logo),
                  Text(
                    'Interface para lançamento de horas',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            toolbarHeight: 150,
            title: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'PD Hours',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Consumer<ReportsController>(builder: (_, reports, __) {
                    return UiButton(
                      textButton: 'Lançar horas',
                      onPressedButton: () {
                        reports.clearText();

                        showDialog(
                          context: context,
                          builder: (context) => const ReportsRegisterDialog(),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
            bottom: const TabBar(
              indicatorWeight: 5,
              tabs: [
                Tab(
                  child: Text('Squads'),
                ),
                Tab(
                  child: Text('Usuários'),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Navigator(
                initialRoute: '/squads',
                onGenerateRoute: (settings) {
                  var route = settings.name;
                  Widget page;

                  switch (route) {
                    case '/squads':
                      page = const SquadsPage();
                      break;
                    case '/squadsData':
                      page = const SquadsDataView();
                      break;
                    default:
                      return null;
                  }

                  return MaterialPageRoute(
                    builder: (context) => page,
                    settings: settings,
                  );
                },
              ),
              const EmployeesPage(),
            ],
          ),
        ),
      ),
    );
  }
}
