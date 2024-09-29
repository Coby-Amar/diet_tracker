import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/dialogs/are_you_sure.dart.dart';
import 'package:diet_tracker/widgets/report_item.dart';
import 'package:diet_tracker/resources/provider.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:diet_tracker/widgets/floating_add_button.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.read<AppProvider>();
    final reports = context.watch<AppProvider>().searchReportsFiltered;
    return Scaffold(
      appBar: const AppBarThemed(title: 'Reports'),
      body: RefreshIndicator(
        onRefresh: appProvider.loadReports,
        child: Column(
          children: [
            SearchBar(
              hintText: 'Search by date',
              keyboardType: TextInputType.datetime,
              leading: const Icon(Icons.search),
              shape: const WidgetStatePropertyAll(RoundedRectangleBorder()),
              elevation: const WidgetStatePropertyAll(10),
              onChanged: (value) => appProvider.searchReportsQuery = value,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => ReportItem(
                  report: reports.elementAt(index),
                  onEdit: () => context.pushNamed('update_report',
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
          ],
        ),
      ),
      floatingActionButton: FloatingAddButton(
        onPressed: () => context.pushNamed("create_report"),
      ),
    );
  }
}
