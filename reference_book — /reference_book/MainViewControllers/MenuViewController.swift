//
//  MenuViewController.swift
//  reference_book
//
//  Created by юра шинкар on 22.01.23.
//

import UIKit
import PDFKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuViewController.MenuOptions)
    func didTapMenuButton()
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: MenuViewControllerDelegate?
    
    enum MenuOptions: String, CaseIterable {
        case home = "Главная"
        case doc = "Документы МЧС"
        case res = "Обязанности"
        case base = "База знаний"
        case normativ = "Нормативы"
        case sxrz = "СХРЗ"
        case grafics = "График дежурств"
        
        
        var imageName: String {
            switch self {
            case .home:
                return "house"
            case .doc:
                return "list.clipboard.fill"
            case .res:
                return "list.clipboard.fill"
            case .base:
                return "list.clipboard.fill"
            case .normativ:
                return "list.clipboard.fill"
            case .sxrz:
                return "list.clipboard.fill"
            case .grafics:
                return "list.clipboard.fill"
            
            }
        }
        
        var docName: String {
            switch self {
            case .res:
                return "Положение"
            default:
                return ""
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = nil
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
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

    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        cell.backgroundColor = blueColor
        cell.contentView.backgroundColor = blueColor
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
}
