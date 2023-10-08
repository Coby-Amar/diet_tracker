import 'package:diet_tracker/providers/models.dart';
import 'package:diet_tracker/widgets/create_entry.dart';
import 'package:diet_tracker/widgets/date_picker_form_field.dart';
import 'package:flutter/material.dart';

import 'package:diet_tracker/providers/products.dart';
import 'package:diet_tracker/validations.dart';
import 'package:provider/provider.dart';

class CreateEditReportDialog extends StatefulWidget {
  const CreateEditReportDialog({super.key});

  @override
  State<CreateEditReportDialog> createState() => _CreateEditReportDialogState();
}

class _CreateEditReportDialogState extends State<CreateEditReportDialog> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  List<EntryModel> _entryies = [];
  List<CreateEntry> _additionalCreateEntry = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final products = context.read<ProductsProvider>().products;
    final validations = Validations();
    return Scaffold(
      appBar: AppBar(
        title: const Text('יצירת דוח'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
                child: Column(
                  children: [
                    DatePicketFormField(
                      label: 'date',
                      onSaved: (p0) => setState(() {
                        _date = p0!;
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Material(
                              color: theme.primaryColorDark,
                              child: InkWell(
                                splashColor: theme.primaryColorLight,
                                onTap: () =>
                                    setState(() => _additionalCreateEntry.add(
                                          CreateEntry(
                                            date: _date,
                                            onSaved: (entryData) =>
                                                setState(() {
                                              if (entryData == null) return;
                                              _entryies.add(EntryModel(
                                                  product: entryData.product!,
                                                  date: _date,
                                                  amount: entryData.amount));
                                            }),
                                          ),
                                        )),
                                child: const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                          ),
                          SizedBox.fromSize(size: const Size.square(20)),
                          Visibility(
                            visible: _additionalCreateEntry.isNotEmpty,
                            child: ClipOval(
                              child: Material(
                                color: theme.primaryColorDark,
                                child: InkWell(
                                  splashColor: theme.primaryColorLight,
                                  onTap: () => setState(() =>
                                      _additionalCreateEntry.removeLast()),
                                  child: const SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            CreateEntry(
                              date: _date,
                              onSaved: (entryData) => setState(() {
                                if (entryData == null) return;
                                _entryies.add(EntryModel(
                                    product: entryData.product!,
                                    date: _date,
                                    amount: entryData.amount));
                              }),
                            ),
                            ..._additionalCreateEntry,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final result = _formKey.currentState?.validate();
                if (result == null || !result) {
                  return;
                }
                _formKey.currentState?.save();
                Navigator.of(context)
                    .pop(ReportModel(date: _date, entries: _entryies));
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
