import 'dart:io';

import 'package:equatable/equatable.dart';

enum ParentDocumentsTab { mine, nanny }

class ParentDocumentItem extends Equatable {
  const ParentDocumentItem({
    required this.id,
    required this.title,
    required this.status,
    required this.dateLabel,
    this.file,
  });

  final String id;
  final String title;
  final String status;
  final String dateLabel;
  final File? file;

  ParentDocumentItem copyWith({File? file}) {
    return ParentDocumentItem(
      id: id,
      title: title,
      status: status,
      dateLabel: dateLabel,
      file: file ?? this.file,
    );
  }

  @override
  List<Object?> get props => [id, title, status, dateLabel, file?.path];
}

class ParentNannyDocumentGroup extends Equatable {
  const ParentNannyDocumentGroup({
    required this.id,
    required this.name,
    required this.documents,
  });

  final String id;
  final String name;
  final List<ParentDocumentItem> documents;

  @override
  List<Object?> get props => [id, name, documents];
}
