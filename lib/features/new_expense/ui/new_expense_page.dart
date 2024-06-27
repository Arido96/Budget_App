import 'package:budget_app/features/shared/category/ui/cubit/category_cubit.dart';
import 'package:budget_app/features/new_category.dart/ui/new_category_dialog.dart';
import 'package:budget_app/features/shared/category/domain/models/expense_category.dart';
import 'package:budget_app/features/shared/category/ui/cubit/category_state.dart';
import 'package:budget_app/features/shared/theme/custom_widgets.dart';
import 'package:budget_app/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewExpensePage extends StatelessWidget {
  const NewExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => getIt<CategoryCubit>()..getAllCategories(),
          child: _NewExpenseView()),
    );
  }
}

class _NewExpenseView extends StatelessWidget {
  _NewExpenseView();

  final TextEditingController datePickerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Add new expense',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const TextInput(
              label: 'Name',
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                return _CategoryDropDown(categories: state.categories);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            _DatePicker(
              textEditingController: datePickerController,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: const ButtonStyle(
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                  ),
                ),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => const NewCategoryDialog(),
                ),
                child: const Text('Create'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CategoryDropDown extends StatefulWidget {
  const _CategoryDropDown({required this.categories});

  final List<ExpenseCategory> categories;

  @override
  State<_CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<_CategoryDropDown> {
  ExpenseCategory? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: DropdownMenu<ExpenseCategory?>(
            expandedInsets: EdgeInsets.zero,
            hintText: 'Select category',
            onSelected: (ExpenseCategory? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            dropdownMenuEntries: widget.categories
                .map<DropdownMenuEntry<ExpenseCategory?>>(
                    (ExpenseCategory? value) {
              return DropdownMenuEntry<ExpenseCategory?>(
                  value: value, label: value!.name);
            }).toList(),
          ),
        ),
        IconButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => const NewCategoryDialog(),
          ).then(
            (value) {
              context.read<CategoryCubit>().getAllCategories();
            },
          ),
          icon: const Icon(
            Icons.add,
          ),
        ),
      ],
    );
  }
}

class _DatePicker extends StatefulWidget {
  const _DatePicker({
    required this.textEditingController,
  });
  final TextEditingController textEditingController;
  @override
  State<_DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<_DatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextInput(
      label: 'Select Date',
      readOnly: true,
      suffixIcon: const Icon(Icons.calendar_today),
      onTap: () async => _openDatePicker(),
      controller: widget.textEditingController,
    );
  }

  Future<void> _openDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd.MM.yyyy').format(pickedDate);
      setState(() {
        widget.textEditingController.text = formattedDate;
      });
    }
  }
}
