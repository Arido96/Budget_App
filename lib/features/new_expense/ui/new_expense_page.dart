import 'package:budget_app/features/shared/category/ui/cubit/category_cubit.dart';
import 'package:budget_app/features/new_category.dart/ui/new_category_dialog.dart';
import 'package:budget_app/features/shared/category/domain/models/expense_category.dart';
import 'package:budget_app/features/shared/category/ui/cubit/category_state.dart';
import 'package:budget_app/features/shared/expense/cubit/expense_cubit.dart';
import 'package:budget_app/features/shared/expense/domain/models/expense.dart';
import 'package:budget_app/features/shared/theme/custom_widgets.dart';
import 'package:budget_app/injection/injection.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewExpensePage extends StatelessWidget {
  const NewExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<CategoryCubit>()..getAllCategories(),
          ),
          BlocProvider<ExpenseCubit>(
            create: (context) => getIt<ExpenseCubit>(),
          )
        ],
        child: const _NewExpenseView(),
      ),
    );
  }
}

class _NewExpenseView extends StatefulWidget {
  const _NewExpenseView();

  @override
  State<_NewExpenseView> createState() => _NewExpenseViewState();
}

class _NewExpenseViewState extends State<_NewExpenseView> {
  final TextEditingController _datePickerController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter.currency(locale: 'de');
  ExpenseCategory? dropdownValue;

  @override
  void dispose() {
    _datePickerController.dispose();
    _nameController.dispose();
    _valueController.dispose();

    super.dispose();
  }

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
            TextInputField(
              label: 'Name',
              controller: _nameController,
            ),
            const SizedBox(
              height: 15,
            ),
            TextInputField(
              label: 'Value',
              controller: _valueController,
              textInputType: TextInputType.number,
              inputFormatters: [
                _formatter,
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                return _CategoryDropDown(
                  categories: state.categories,
                  onExpenseCategoryChange: (p0) {
                    dropdownValue = p0;
                  },
                );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            _DatePicker(
              textEditingController: _datePickerController,
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
                onPressed: () {
                  final value = _formatter.getUnformattedValue();

                  final newExpense = Expense(
                    name: _nameController.text,
                    value: double.parse(value.toString()),
                    category: dropdownValue,
                    dateTime: DateTime.parse(_datePickerController.text),
                  );

                  context
                      .read<ExpenseCubit>()
                      .createExpense(expense: newExpense);

                  Navigator.of(context).pop();
                },
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
  const _CategoryDropDown({
    required this.categories,
    required this.onExpenseCategoryChange,
  });

  final List<ExpenseCategory> categories;
  final Function(ExpenseCategory) onExpenseCategoryChange;

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
              if (value != null) {
                setState(() {
                  dropdownValue = value;
                  widget.onExpenseCategoryChange(value);
                });
              }
            },
            dropdownMenuEntries:
                widget.categories.map<DropdownMenuEntry<ExpenseCategory?>>(
              (ExpenseCategory? value) {
                return DropdownMenuEntry<ExpenseCategory?>(
                  value: value,
                  label: value!.name,
                );
              },
            ).toList(),
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
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextInputField(
      label: 'Select Date',
      readOnly: true,
      suffixIcon: const Icon(Icons.calendar_today),
      onTap: () async => _openDatePicker(),
      controller: _dateController,
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
        _dateController.text = formattedDate;
        widget.textEditingController.text = pickedDate.toString();
      });
    }
  }
}
