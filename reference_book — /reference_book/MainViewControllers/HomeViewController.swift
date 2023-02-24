//
//  HomeViewController.swift
//  reference_book
//
//  Created by юра шинкар on 22.01.23.
//

import UIKit
import SnapKit

protocol HomeViewControllerDelegate: AnyObject {
        func didTapMenuButton()
}

class HomeViewController: BaseViewController {
    
    private let logoImageView = UIImageView()
    
    
    weak var delegate: HomeViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        setupView()
    }
    
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton() 
    }
}

private extension HomeViewController {
    func setupView() {
        view.backgroundColor = .white
        title = "Справочник МЧС"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.dash"),
            style: .done,
            target: self,
            action: #selector(didTapMenuButton)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        setupLogoView()
        logoImageView.image = UIImage(named: "img-logo")
        
    }
    
    func setupLogoView() {
    
         
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(32)
        }
    }
}

