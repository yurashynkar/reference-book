//
//  infoResViewController.swift
//  reference_book
//
//  Created by юра шинкар on 22.01.23.
//

import UIKit
import PDFKit
protocol InfoBaseViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuOptions3)
    func didTapMenuButton()
}

struct Options {
    var name: String
    var imageBaseName: String
    var docName: String
}

enum MenuOptions3: String, CaseIterable {
            case ptv = "ПТВ|АСИ|АСО"
            case teachmeans = "Технические средства"
            case work = "Работа с веревками"
            case dress = "Форма одежды"

            var imageBaseName: String {
                switch self {
                case .ptv:
                    return "list.clipboard.fill"
                case .teachmeans:
                    return "list.clipboard.fill"
                case .work:
                    return "list.clipboard.fill"
                case .dress:
                    return "list.clipboard.fill"

                }
            }
            var docName: String {
                switch self {
                case .ptv:
                    return "птв|аси|асо"
                case .teachmeans:
                    return "транспортные средства"
                case .work:
                    return "работа с веревками"
                case .dress:
                    return "боевая одежда"
                }
    }
}

class InfoBaseViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: InfoBaseViewControllerDelegate?
    private var options: [Options] = []
    
    
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
    
    func setOptions(_ options: [Options]) {
        self.options = options
        tableView.reloadData()
    }
    func showPdfFor(docName: String) {
        guard
            let url = Bundle.main.url(forResource: docName, withExtension: "pdf"),
            let document = PDFDocument(url: url)
        else { return }
        let pdfViewer = PDFViewerViewController()
        pdfViewer.setPdfDocument(document: document)
        navigationController?.pushViewController(pdfViewer, animated: true)
    }
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row].name
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName: options[indexPath.row].imageBaseName)
        cell.imageView?.tintColor = .white
        cell.backgroundColor = blueColor
        cell.contentView.backgroundColor = blueColor
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = options[indexPath.row].docName
        showPdfFor(docName: item)

    }
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
}
