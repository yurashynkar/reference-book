//
//  InfoNornativViewController.swift
//  reference_book
//
//  Created by юра шинкар on 23.01.23.
//

import Foundation
import UIKit
import PDFKit
protocol InfoNormativViewControllerDelegate: AnyObject {
    func didSelect(menuItem: InfoNormativViewController.MenuOptionsNormativ)
    func didTapMenuButton()
}

class InfoNormativViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    
    weak var delegate: InfoNormativViewControllerDelegate?
    
    enum MenuOptionsNormativ: String, CaseIterable {
        case normativ1 = "Нормативы ПАСП"
        case normativ2 = "Нормативы по ФП"
        
        
    
                var imageNormativName: String {
                    switch self {
                    case .normativ1:
                        return "list.clipboard.fill"
                    case .normativ2:
                        return "list.clipboard.fill"

                    }
                }
                var NormativName: String {
                    switch self {
                    case .normativ1:
                        return "нормативы по пасп"
                    case .normativ2:
                        return "нормативы по фп"
                  
                    }
                    
                    
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = nil
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var blueColor = UIColor(red: 0, green: 0.5608, blue: 0.9373, alpha: 1.0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = blueColor
        overrideUserInterfaceStyle = .light

    
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height:
                view.bounds.size.height)
    }

    func showPdfFor(option: MenuOptionsNormativ) {
        guard
            let url = Bundle.main.url(forResource: option.NormativName, withExtension: "pdf"),
            let document = PDFDocument(url: url)
        else { return }
        let pdfViewer = PDFViewerViewController()
        pdfViewer.setPdfDocument(document: document)
        navigationController?.pushViewController(pdfViewer, animated: true)
    }

    
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptionsNormativ.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptionsNormativ.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName: MenuOptionsNormativ.allCases[indexPath.row].imageNormativName)
        cell.imageView?.tintColor = .white
        cell.backgroundColor = blueColor
        cell.contentView.backgroundColor = blueColor
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptionsNormativ.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
}

