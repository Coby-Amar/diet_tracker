import 'package:diet_tracker/dialogs/dialog_scaffold_form.dart';
import 'package:diet_tracker/providers/models.dart';
import 'package:diet_tracker/widgets/create_entry.dart';
import 'package:diet_tracker/widgets/date_picker_form_field.dart';
import 'package:flutter/material.dart';

class CreateReportDialog extends StatefulWidget {
  const CreateReportDialog({super.key});

  @override
  State<CreateReportDialog> createState() => _CreateReportDialogState();
}

class _CreateReportDialogState extends State<CreateReportDialog> {
  DateTime _date = DateTime.now();
  final List<EntryModel> _entryies = [];
  final List<CreateEntry> _additionalCreateEntry = [];

  @override
  Widget build(BuildContext context) => DialogScaffoldForm(
        title: 'יצירת דוח',
        onSuccess: () => Report(date: _date, entries: _entryies),
        formBuilder: (theme, validations) => Column(
          children: [
            DatePicketFormField(
              label: 'date',
              onSaved: (date) => setState(() => _date = date!),
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
                        onTap: () => setState(() => _additionalCreateEntry.add(
                              CreateEntry(
                                date: _date,
                                onSaved: (entryData) => setState(() {
                                  if (entryData == null) return;
                                  _entryies.add(EntryModel(
                                      product: entryData.product!,
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
                          onTap: () => setState(
                              () => _additionalCreateEntry.removeLast()),
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
      );
}
