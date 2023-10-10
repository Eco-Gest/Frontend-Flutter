part of 'form_post_cubit.dart';


abstract class PostFormState  {
  const PostFormState();
}

class SelectionState extends PostFormState {
  const SelectionState({
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

  SelectionState copyWith({
    List<PostType>? selectableTypes,
    List<PostLevel>? selectableLevels,
    List<CategoryModel>? selectableCategories,
    PostType? selectedType,
    PostLevel? selectedLevel,
    int? selectedCategory,

  }) {
    return SelectionState(
      selectableTypes: selectableTypes ?? this.selectableTypes,
      selectableLevels: selectableLevels ?? this.selectableLevels,
      selectableCategories: selectableCategories ?? this.selectableCategories,
      selectedType: selectedType ?? this.selectedType,
      selectedLevel: selectedLevel ?? this.selectedLevel,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

}


/// The initial state of the form cubit.
class PostFormStateInitial extends PostFormState {
}

/// The state of the form cubit when the form is completed.
class PostFormStateCompleted extends PostFormState {

}

/// The state of the form cubit when the form is successful.
class PostFormStateSuccess extends PostFormState {
  const PostFormStateSuccess(this.post);

  final PostModel post;
}

/// The state of the form cubit when an error occurred.
class PostFormStateError extends PostFormState {
  final String message;

  const PostFormStateError(this.message);
}
  

