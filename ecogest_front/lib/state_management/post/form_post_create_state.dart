part of 'form_post_create_cubit.dart';


abstract class FormPostCreateState  {
  const FormPostCreateState();
}

class SelectionState extends FormPostCreateState {
  const SelectionState(this.title, this.description, this.position, this.startDate, this.endDate, {
    required this.selectableTypes,
    required this.selectableCategories,
    required this.selectableLevels,
    required this.selectedType,
    required this.selectedCategory,
    required this.selectedLevel, 
  });

  final List<PostType> selectableTypes;
  final List<PostLevel> selectableLevels;
  final List<CategoryModel> selectableCategories;
  final PostType selectedType;
  final PostLevel selectedLevel;
  final int selectedCategory;
  final String title;
  final String description;
  final String position;
  final String startDate;
  final String endDate;

  // SelectionState copyWith({
  //   List<PostType>? selectableTypes,
  //   List<PostLevel>? selectableLevels,
  //   List<CategoryModel>? selectableCategories,
  //   PostType? selectedType,
  //   PostLevel? selectedLevel,
  //   int? selectedCategory,
  //   String? title,
  //   String? description,
  //   String? position,
  //   String? startDate,
  //   String? endDate,
  // }) {
  //   return SelectionState(
  //     // title: title ?? this.title,
  //     // description: description ?? this.description,
  //     // position: position ?? this.position,
  //     // startDate: startDate ?? this.startDate,
  //     // endDate: endDate ?? this.endDate,
  //     selectableTypes: selectableTypes ?? this.selectableTypes,
  //     selectableLevels: selectableLevels ?? this.selectableLevels,
  //     selectableCategories: selectableCategories ?? this.selectableCategories,
  //     selectedType: selectedType ?? this.selectedType,
  //     selectedLevel: selectedLevel ?? this.selectedLevel,
  //     selectedCategory: selectedCategory ?? this.selectedCategory,
  //   );
  // }

}


/// The initial state of the form cubit.
class FormPostCreateInitial extends FormPostCreateState {
}

/// The state of the form cubit when the form is completed.
class FormPostCreateCompleted extends FormPostCreateState {

}

/// The state of the form cubit when the form is successful.
class FormPostCreateSuccess extends FormPostCreateState {
  const FormPostCreateSuccess(this.post);

  final PostModel post;
}

/// The state of the form cubit when an error occurred.
class FormPostCreateError extends FormPostCreateState {
  final String message;

  const FormPostCreateError(this.message);
}
  

