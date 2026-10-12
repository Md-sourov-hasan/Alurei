import 'dart:io';

import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_document_data.dart';

class DocumentsController extends GetxController {
  final selectedTab = ParentDocumentsTab.mine.obs;
  final selectedNannyIndex = 0.obs;
  final myDocuments = <ParentDocumentItem>[
    const ParentDocumentItem(
      id: 'passport',
      title: 'Passport',
      status: 'Verified',
      dateLabel: '12 May 2026',
    ),
    const ParentDocumentItem(
      id: 'national-id',
      title: 'National ID',
      status: 'Verified',
      dateLabel: '12 May 2026',
    ),
  ].obs;

  final nannyDocumentGroups = const <ParentNannyDocumentGroup>[
    ParentNannyDocumentGroup(
      id: 'deepa',
      name: 'Deepa Sanjana',
      documents: [
        ParentDocumentItem(
          id: 'deepa-passport',
          title: 'Passport',
          status: 'Verified',
          dateLabel: '12 May 2026',
        ),
        ParentDocumentItem(
          id: 'deepa-national-id',
          title: 'National ID',
          status: 'Verified',
          dateLabel: '12 May 2026',
        ),
      ],
    ),
    ParentNannyDocumentGroup(
      id: 'sanjana',
      name: 'Sanjana Kumari',
      documents: [
        ParentDocumentItem(
          id: 'sanjana-passport',
          title: 'Passport',
          status: 'Verified',
          dateLabel: '12 May 2026',
        ),
      ],
    ),
    ParentNannyDocumentGroup(
      id: 'priya',
      name: 'Priya Das',
      documents: [
        ParentDocumentItem(
          id: 'priya-national-id',
          title: 'National ID',
          status: 'Verified',
          dateLabel: '12 May 2026',
        ),
      ],
    ),
  ].obs;

  ParentNannyDocumentGroup get selectedNanny =>
      nannyDocumentGroups[selectedNannyIndex.value];

  set tab(ParentDocumentsTab tab) => selectedTab.value = tab;

  set nannyIndex(int index) => selectedNannyIndex.value = index;

  Future<void> uploadDocument(ParentDocumentItem item) async {
    final result = await DocumentFileService.instance.pickDocument();
    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      (file) {
        if (file == null) return;
        final index = myDocuments.indexWhere((doc) => doc.id == item.id);
        if (index == -1) return;
        myDocuments[index] = myDocuments[index].copyWith(file: file);
        showGlobalToast(message: LangKey.parentHome.documentUploaded);
      },
    );
  }

  void viewDocument(ParentDocumentItem item) {
    FullScreenDocumentViewer.open<void>(
      title: item.title,
      status: item.status,
      dateLabel: item.dateLabel,
      file: item.file,
    );
  }

  Future<void> downloadDocument(ParentDocumentItem item) async {
    final file = item.file ?? await _fallbackDocumentFile(item);
    final result = await DocumentFileService.instance.saveToFileManager(
      file,
      fileName: item.title,
    );
    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      (savedFile) => showGlobalToast(
        message: '${LangKey.parentHome.documentDownloaded}: ${savedFile.path}',
      ),
    );
  }

  Future<File> _fallbackDocumentFile(ParentDocumentItem item) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/${item.id}.pdf');
    if (await file.exists()) return file;
    await file.writeAsString(
      'Alurei document placeholder\n${item.title}\n'
      '${item.status} • ${item.dateLabel}\n',
    );
    return file;
  }
}
