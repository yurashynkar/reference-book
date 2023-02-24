//
//  PDFViewerViewController.swift
//  reference_book
//
//  Created by юра шинкар on 25.01.23.
//
import UIKit
import PDFKit
import SnapKit
import Foundation

final class PDFViewerViewController: UIViewController, UISearchBarDelegate {

    private let pdfView = PDFView()
    private var document: PDFDocument?
    private var currentSelectionIndex = 0
    private var currentSearchText: String = ""
    private var selections: [PDFSelection] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        setupPDFView()
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        view.backgroundColor = .yellow
    }

    func setPdfDocument(document: PDFDocument) {
        self.document = document
        pdfView.document = document
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        if text != currentSearchText,
           let newSelections = document?.findString(text) {
            selections = newSelections
            currentSearchText = text
            currentSelectionIndex = 0
        }
        
        if currentSelectionIndex >= selections.count {
            currentSelectionIndex = 0
        }
        guard !selections.isEmpty else { return }
        let selection = selections[currentSelectionIndex]
        let page = selection.pages.first!
        pdfView.setCurrentSelection(selection, animate: true)
//        PDFAnnotation
        pdfView.go(to: selection.bounds(for: page), on: page)
//        pdfView.scrollSelectionToVisible(selections[currentSelectionIndex])
        currentSelectionIndex += 1
    }
}



private extension PDFViewerViewController {
    func setupPDFView() {
        pdfView.displayDirection = .vertical
        pdfView.maxScaleFactor = 1.1
        pdfView.minScaleFactor = 1.1
        pdfView.autoScales = true
        view.addSubview(pdfView)
        pdfView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }
}
