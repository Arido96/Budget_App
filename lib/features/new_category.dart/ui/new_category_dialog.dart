import 'package:budget_app/features/shared/category/ui/cubit/category_cubit.dart';
import 'package:budget_app/features/shared/category/domain/models/expense_category.dart';
import 'package:budget_app/features/shared/theme/custom_widgets.dart';
import 'package:budget_app/injection/injection.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class NewCategoryDialog extends StatefulWidget {
  const NewCategoryDialog({super.key});

  @override
  State<NewCategoryDialog> createState() => _NewCategoryDialogState();
}

class _NewCategoryDialogState extends State<NewCategoryDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<CategoryCubit>(),
        child: const _DialogView());
  }
}

class _DialogView extends StatefulWidget {
  const _DialogView();

  @override
  State<_DialogView> createState() => _DialogViewState();
}

class _DialogViewState extends State<_DialogView> {
  var _selectedColor = const Color.fromARGB(
    255,
    255,
    255,
    255,
  );

  final TextEditingController _nameTextEditingCOntroller =
      TextEditingController();

  @override
  void dispose() {
    _nameTextEditingCOntroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Text(
                  'Add new category',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextInputField(
                  label: 'Name',
                  controller: _nameTextEditingCOntroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                ColorPicker(
                  onColorChanged: (color) {
                    setState(
                      () {
                        _selectedColor = color;
                      },
                    );
                  },
                  pickersEnabled: const {
                    ColorPickerType.wheel: true,
                    ColorPickerType.accent: false,
                    ColorPickerType.primary: false
                  },
                ),
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
                      final category = ExpenseCategory(
                        id: const Uuid().v4(),
                        name: _nameTextEditingCOntroller.text,
                        color: _selectedColor,
                      );

                      context.read<CategoryCubit>().create(category: category);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
