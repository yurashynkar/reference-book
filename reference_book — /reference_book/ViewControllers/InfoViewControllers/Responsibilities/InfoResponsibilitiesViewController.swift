//
//  ResponsibilitiesViewController.swift
//  reference_book
//
//  Created by юра шинкар on 25.01.23.
//

import UIKit
import PDFKit
protocol InfoResponsibilitiesViewControllerDelegate: AnyObject {
    func didSelect(menuItem: InfoResponsibilitiesViewController.MenuOptions3)
    func didTapMenuButton()
}

class InfoResponsibilitiesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: InfoResponsibilitiesViewControllerDelegate?

    enum MenuOptions3: String, CaseIterable {
        case head = "Начальник караула"
        case fire = "Спасатель-пожарный"
        case part = "Командир отделения"
        case driver = "Водитель"
        case dispet = "Диспетчер ЦОУ Гарнизона"
        case dispet2 = "Диспетчер ЦОУ Г(Р)ОЧС (ПСЧ)"
        case shiftat = "Дежурный по смене"
        case orderly = "Дневальный по гаражу(КПП)"
        case flight = "Командир звена ГДЗС"
        case gas = "Газодымозащитник"
        case guardon = "Постовой на ПБ(ГДЗС)"
        case head2 = "Начальник гарнизона"
        case incharge = "Отвественный по гарнизону"
        case cheif = "Гл. Оперативный дежурный"
        
        
    
                var imageResName: String {
                    switch self {
                    case .head:
                        return "person"
                    case .fire:
                        return "person"
                    case .part:
                        return "person"
                    case .driver:
                        return "person"
                    case .dispet:
                        return "person"
                    case .dispet2:
                        return "person"
                    case .shiftat:
                        return "person"
                    case .orderly:
                        return "person"
                    case .flight:
                        return "person"
                    case .gas:
                        return "person"
                    case .guardon:
                        return "person"
                    case .head2:
                        return "person"
                    case .incharge:
                        return "person"
                    case .cheif:
                        return "person"

                    }
                }
                var resName: String {
                    switch self {
                    case .head:
                        return "начальник караула"
                    case .fire:
                        return "спасатель-пожарный"
                    case .part:
                        return "командир отделения"
                    case .driver:
                        return "водитель"
                    case .dispet:
                        return "диспетчер цоу гарнизона"
                    case .dispet2:
                        return "диспетчер цоу г(р)очс (псч)"
                    case .shiftat:
                        return "дежурный по смнене"
                    case .orderly:
                        return "дневальный по гаражу(кпп)"
                    case .flight:
                        return "командир звена гдзс"
                    case .gas:
                        return "газодымозащитник"
                    case .guardon:
                        return "постовой на пб(гдзс)"
                    case .head2:
                        return "начальник гарнизона"
                    case .incharge:
                        return "отвественный по гарнизону"
                    case .cheif:
                        return "главный оперативный дежурный"
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

    func showPdfFor(option: MenuOptions3) {
        guard
            let url = Bundle.main.url(forResource: option.resName, withExtension: "pdf"),
            let document = PDFDocument(url: url)
        else { return }
        let pdfViewer = PDFViewerViewController()
        pdfViewer.setPdfDocument(document: document)
        navigationController?.pushViewController(pdfViewer, animated: true)
    }
    
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions3.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions3.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName: MenuOptions3.allCases[indexPath.row].imageResName)
        cell.imageView?.tintColor = .white
        cell.backgroundColor = blueColor
        cell.contentView.backgroundColor = blueColor
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions3.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
}
