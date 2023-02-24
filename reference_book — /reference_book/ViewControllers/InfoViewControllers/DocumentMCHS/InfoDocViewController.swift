//
//  InfoDocViewController.swift
//  reference_book
//
//  Created by юра шинкар on 27.01.23.
//

import Foundation
import UIKit
import PDFKit
protocol InfoDocViewControllerDelegate: AnyObject {
    func didSelect(menuItem: InfoDocViewController.MenuOptions1)
    func didTapMenuButton()
}

class InfoDocViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    
    weak var delegate: InfoDocViewControllerDelegate?
    
    enum MenuOptions1: String, CaseIterable {
        case fight = "Боевой устав"
        case ustav = "Устав службы"
        case ispit = "Испытания ПТВ, АСИ, АСО"
        case rulesorg1 = "Правила организации ГДЗС"
        case rulesorg2 = "Правила организации Тех. службы"
        case rulesruc = "Инструкция по рукавам"
        case tush = "Тушение электроустановок"
        case rulesgsv = "Инструкция ГСВ"
        case rulespo = "Инструкция по ОПиОК"
        case forms = "Правила ношения формы"
        
        
    
                var imageDocName: String {
                    switch self {
                    case .fight:
                        return "list.clipboard.fill"
                    case .ustav:
                        return "list.clipboard.fill"
                    case .ispit:
                        return "list.clipboard.fill"
                    case .rulesorg1:
                        return "list.clipboard.fill"
                    case .rulesorg2:
                        return "list.clipboard.fill"
                    case .rulesruc:
                        return "list.clipboard.fill"
                    case .tush:
                        return "list.clipboard.fill"
                    case .rulesgsv:
                        return "list.clipboard.fill"
                    case .rulespo:
                        return "list.clipboard.fill"
                    case .forms:
                        return "list.clipboard.fill"

                    }
                }
                var docName: String {
                    switch self {
                    case .fight:
                        return "боевой устав"
                    case .ustav:
                        return "устав службы"
                    case .ispit:
                        return "испытания птв аси асо"
                    case .rulesorg1:
                        return "правила гдзс"
                    case .rulesorg2:
                        return "правила организации тех.службы"
                    case .rulesruc:
                        return "инструкция по рукавам"
                    case .tush:
                        return "тэу"
                    case .rulesgsv:
                        return "инструкция гсв"
                    case .rulespo:
                        return "инструкция оп и ок"
                    case .forms:
                        return "правила ношения формы док мчс"
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

    func showPdfFor(option: MenuOptions1) {
        guard
            let url = Bundle.main.url(forResource: option.docName, withExtension: "pdf"),
            let document = PDFDocument(url: url)
        else { return }
        let pdfViewer = PDFViewerViewController()
        pdfViewer.setPdfDocument(document: document)
        navigationController?.pushViewController(pdfViewer, animated: true)
    }

    
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions1.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions1.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName: MenuOptions1.allCases[indexPath.row].imageDocName)
        cell.imageView?.tintColor = .white
        cell.backgroundColor = blueColor
        cell.contentView.backgroundColor = blueColor
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions1.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
}
