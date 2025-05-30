import 'package:diet_tracker/resources/extensions/dates.extension.dart';
import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/dialogs/are_you_sure.dialog.dart';
import 'package:diet_tracker/widgets/report_item.dart';
import 'package:diet_tracker/resources/provider.dart';
import 'package:diet_tracker/widgets/floating_add_button.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.read<AppProvider>();
    final reports = context.watch<AppProvider>().searchReportsFiltered;
    final todaysReport = reports.singleWhere(
        (report) =>
            report.date.normalize.isAtSameMomentAs(DateTime.now().normalize),
        orElse: () => Report());
    final dailyLimit = appProvider.dailyLimit;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          appProvider.searchReportsQuery = '';
          await appProvider.loadReports();
        },
        child: Column(
          children: [
            if (dailyLimit.isNotEmpty && todaysReport.id != -1)
              Container(
                color: theme.primaryColorDark,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'כמות שנשאר להיום',
                    ),
                    Column(
                      children: [
                        Text(
                          'פחממה',
                        ),
                        Text(
                          '${dailyLimit.totalCarbohydrates - todaysReport.totalCarbohydrates}',
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'חלבון',
                        ),
                        Text(
                          '${dailyLimit.totalProteins - todaysReport.totalProteins}',
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'שומן',
                        ),
                        Text(
                          '${dailyLimit.totalFats - todaysReport.totalFats}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            SearchBar(
              hintText: 'חיפוש לפי תאריך',
              keyboardType: TextInputType.datetime,
              leading: const Icon(Icons.search),
              shape: const WidgetStatePropertyAll(RoundedRectangleBorder()),
              elevation: const WidgetStatePropertyAll(10),
              onChanged: (value) => appProvider.searchReportsQuery = value,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemBuilder: (context, index) => ReportItem(
                    report: reports.elementAt(index),
                    onEdit: () => context.goNamed('update_report',
                        extra: reports.elementAt(index)),
                    onDelete: () async {
                      final response = await showDialog(
                        context: context,
                        builder: (context) => const AreYouSureDialog(
                          content: 'This report will be lost FOREVER',
                        ),
                      );
                      if (response != null && response) {
                        appProvider.deleteReport(reports.elementAt(index).id);
                      }
                    },
                  ),
                  itemCount: reports.length,
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingAddButton(
        onPressed: () => context.goNamed("create_report"),
      ),
    );
  }
}
