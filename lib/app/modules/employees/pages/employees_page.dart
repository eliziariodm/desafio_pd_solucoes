import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/employees_controller.dart';
import '../../../core/responsiveness/screen_size.dart';
import '../../../core/ui/ui_button.dart';
import '../../../core/utils/app_images.dart';
import '../../home/widgets/employees_register_dialog.dart';
import '../views/employees_datatable_view.dart';

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = Provider.of<ScreenSize>(context);

    return Scaffold(
      body: Container(
        height: screen.totalHeight(context),
        width: screen.totalWidth(context),
        padding: screen.isMobile(context)
            ? EdgeInsets.zero
            : EdgeInsets.only(left: screen.columnTwo(context)),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Consumer<EmployeesController>(
          builder: (_, employees, __) {
            if (employees.employeesList.isEmpty) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: screen.isMobile(context)
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Container(
                      height: screen.isMobile(context) ? 370 : 411,
                      width: screen.isMobile(context) ? 355 : 490,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 64),
                          SvgPicture.asset(
                            AppImages.emoji,
                            height: screen.isMobile(context) ? 98 : 128,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Nenhum usuário cadastrado. Crie um usuário para começar.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 64),
                          UiButton(
                            textButton: 'Criar usuário',
                            onPressedButton: () {
                              employees.clearText();

                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const EmployeesRegisterDialog(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            } else {
              return const EmployeesDataTableView();
            }
          },
        ),
      ),
    );
  }
}
