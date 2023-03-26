import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/reports_controller.dart';
import '../../../core/responsiveness/screen_size.dart';
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
    final screen = Provider.of<ScreenSize>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 200,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(top: 24),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                spacing: screen.columnSix(context),
                children: [
                  SvgPicture.asset(AppImages.logo),
                  Text(
                    'Interface para lançamento de horas',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
          title: Container(
            padding: const EdgeInsets.only(top: 100, bottom: 40),
            width: screen.totalWidth(context),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              spacing: screen.isMobile(context)
                  ? screen.columnTwelve(context)
                  : screen.columnSix(context),
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
          bottom: screen.isMobile(context)
              ? const TabBar(
                  indicatorWeight: 5,
                  tabs: [
                    Tab(
                      child: Text('Squads'),
                    ),
                    Tab(
                      child: Text('Usuários'),
                    )
                  ],
                )
              : PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screen.columnTwo(context),
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        indicatorWeight: 5,
                        isScrollable: true,
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
                  ),
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
    );
  }
}
