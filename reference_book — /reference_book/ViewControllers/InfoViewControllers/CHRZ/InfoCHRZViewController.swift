//
//  InfoCHRZViewController.swift
//  reference_book
//
//  Created by юра шинкар on 23.01.23.
//
import UIKit
import PDFKit
protocol InfoCHRZViewControllerDelegate: AnyObject {
    func didSelect(menuItem: InfoCHRZViewController.MenuOptions6)
    func didTapMenuButton()
}

class InfoCHRZViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: InfoCHRZViewControllerDelegate?
    
    enum MenuOptions6: String, CaseIterable {
                case equip = "Оборудование и снаряжение СХРЗ"
                case algorithm1 = "Алгоритм и при ЧС с ОХВ"
                case algorithm2 = "Алгоритм и при ЧС с ИИИ"
                case carrying = "Проведение демеркуризации"
                case charect = "Характеристики основных ОХВ"
        
    
                var imageCHRZName: String {
                    switch self {
                    case .equip:
                        return "list.clipboard.fill"
                    case .algorithm1:
                        return "list.clipboard.fill"
                    case .algorithm2:
                        return "list.clipboard.fill"
                    case .carrying:
                        return "list.clipboard.fill"
                    case .charect:
                        return "list.clipboard.fill"

                    }
                }
                var chrzName: String {
                    switch self {
                    case .equip:
                        return "оборудование и снаряжение"
                    case .algorithm1:
                        return "алгоритм чс с охв"
                    case .algorithm2:
                        return "алгоритм действий чс с иии"
                    case .carrying:
                        return "демеркуризация"
                    case .charect:
                        return "характеристики основных охв"
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
    func showPdfFor(option: MenuOptions6) {
        guard
            let url = Bundle.main.url(forResource: option.chrzName, withExtension: "pdf"),
            let document = PDFDocument(url: url)
        else { return }
        let pdfViewer = PDFViewerViewController()
        pdfViewer.setPdfDocument(document: document)
        navigationController?.pushViewController(pdfViewer, animated: true)
    }
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions6.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions6.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName: MenuOptions6.allCases[indexPath.row].imageCHRZName)
        cell.imageView?.tintColor = .white
        cell.backgroundColor = blueColor
        cell.contentView.backgroundColor = blueColor
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions6.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
}
