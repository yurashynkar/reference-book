//
//  InfoGraficsViewController.swift
//  reference_book
//
//  Created by юра шинкар on 23.01.23.
//
//


import UIKit
import PDFKit
class InfoGraficsViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad(animated)
//        title = "График дежурств"
//        view.backgroundColor = .systemBackground
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light


        // ...

        // Add PDFView to view controller.
        let pdfView = PDFView(frame: self.view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(pdfView)

        // Fit content in PDFView.
        pdfView.autoScales = true

        // Load Sample.pdf file from app bundle.
        let fileURL = Bundle.main.url(forResource: "график", withExtension: "pdf")
        pdfView.document = PDFDocument(url: fileURL!)
    }
}
