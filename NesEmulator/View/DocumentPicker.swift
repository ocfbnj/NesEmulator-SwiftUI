//
//  DocumentPicker.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct DocumentPicker: UIViewControllerRepresentable {
    var complete: ((URL) -> Void)?

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.data], asCopy: false)
        controller.allowsMultipleSelection = false
        controller.shouldShowFileExtensions = true
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        // do nothing
    }

    func makeCoordinator() -> DocumentPickerCoordinator {
        let coordinator = DocumentPickerCoordinator()
        coordinator.complete = complete
        return coordinator
    }
}

class DocumentPickerCoordinator: NSObject, UIDocumentPickerDelegate {
    var complete: ((URL) -> Void)?

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        controller.navigationController?.popViewController(animated: true)
        guard let url = urls.first else { return }

        complete?(url)
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.navigationController?.popViewController(animated: true)
    }
}

struct DocumentPicker_Previews: PreviewProvider {
    static var previews: some View {
        DocumentPicker()
    }
}
