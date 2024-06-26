import 'package:ecogest_front/models/category_model.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/tag_model.dart';
import 'package:ecogest_front/services/category_service.dart';
import 'package:ecogest_front/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part './form_post_state.dart';

class PostFormCubit extends Cubit<PostFormState> {
  PostFormCubit()
      : super(const SelectionState(
          selectableTypes: PostType.values,
          selectableCategories: [],
          selectableLevels: PostLevel.values,
          selectedType: PostType.action,
          selectedCategory: 1,
          selectedLevel: PostLevel.easy,
        ));

  static final PostService postService = PostService();
  static final CategoryService categoryService = CategoryService();

  Future<void> getDefaults() async {
    final categories = await categoryService.getCategories();
    final firstCategory =
        categories.firstWhere((element) => element.id == 1).id;

    emit(SelectionState(
      selectableTypes: PostType.values,
      selectableCategories: categories,
      selectableLevels: PostLevel.values,
      selectedType: PostType.action,
      selectedCategory: firstCategory ?? 0,
      selectedLevel: PostLevel.easy,
    ));
  }

  Future<void> getValuesEdit(
      PostType type, int categoryId, PostLevel level) async {
    final categories = await categoryService.getCategories();

    emit(SelectionState(
      selectableTypes: PostType.values,
      selectableCategories: categories,
      selectableLevels: PostLevel.values,
      selectedType: type,
      selectedCategory: categoryId,
      selectedLevel: level,
    ));
  }

  String? selectPostType(PostType type) {
    if (state is SelectionState) {
      final selectionState = state as SelectionState;
      emit(selectionState.copyWith(selectedType: type));
      return type.name;
    }
    return null;
  }

  void selectPostLevel(PostLevel level) {
    if (state is SelectionState) {
      final selectionState = state as SelectionState;
      emit(selectionState.copyWith(selectedLevel: level));
    }
  }

  void selectCategory(int id) {
    if (state is SelectionState) {
      final selectionState = state as SelectionState;
      emit(selectionState.copyWith(selectedCategory: id));
    }
  }

  Future<void> createPost({
    required String title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? position,
    List<TagModel>? tags,
    String? image,
  }) async {
    if (state is! SelectionState) {
      return;
    }
    final selectionState = state as SelectionState;
    final post = PostModel(
      categoryId: selectionState.selectedCategory,
      position: position,
      title: title,
      description: description,
      image: image,
      tags: tags,
      startDate: startDate?.toIso8601String(),
      endDate: endDate?.toIso8601String(),
      type: selectionState.selectedType.name,
      level: selectionState.selectedLevel.name,
    );

    try {
      final result = await postService.createPost(post);
      emit(PostFormStateSuccess(result));
    } catch (e) {
      emit(const PostFormStateError(
          "Erreur rencontrée lors de la création de votre publication. Veuillez réessayer."));
    }
  }

  Future<void> updatePost({
    required int? postId,
    required String title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? position,
    List<TagModel>? tags,
    String? image,
  }) async {
    if (state is! SelectionState) {
      return;
    }
    final selectionState = state as SelectionState;
    final post = PostModel(
      id: postId,
      categoryId: selectionState.selectedCategory,
      position: position,
      title: title,
      description: description,
      image: image,
      tags: tags,
      startDate: startDate?.toIso8601String(),
      endDate: endDate?.toIso8601String(),
      type: selectionState.selectedType.name,
      level: selectionState.selectedLevel.name,
    );

    try {
      final result = await postService.updatePost(post);
      emit(PostFormStateSuccess(result));
    } catch (e) {
      if (e.toString().contains('participants')) {
        emit(const PostFormStateError(
            "Vous ne pouvez pas mettre à jour cette publication car il y a d'autres participants."));
      } else {
        emit(const PostFormStateError(
            "Erreur rencontrée lors de la mise à jour de votre publication. Veuillez réessayer."));
      }
    }
  }
}
