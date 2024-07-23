// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_bloc.dart';

@immutable
abstract class FilterEvents {}

class FilterEvent extends FilterEvents {
  final String slug;
  FilterEvent({
    required this.slug,
  });
}

class ClearFilterEvent extends FilterEvents {}

class SelectCheckBoxSizeEvent extends FilterEvents {
  final bool value;
  final int index;
  final int sizeId;
  SelectCheckBoxSizeEvent({
    required this.value,
    required this.index,
    required this.sizeId,
  });
}

class SelectCheckBoxBrandEvent extends FilterEvents {
  final bool value;
   final int index;
  final int brandId;
  SelectCheckBoxBrandEvent({
    required this.value,
     required this.index,
    required this.brandId,
  });
}
