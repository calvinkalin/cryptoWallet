//
//  HomeViewController.swift
//  CryptoWallet
//
//  Created by Ilya Kalin on 11.03.2025.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    private let tableView = UITableView()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let viewModel: CurrencyViewModelProtocol
    private let headerView = UIView()
    private let pinkView = UIView()
    
    init(viewModel: CurrencyViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupBindings()
        viewModel.fetchData()
    }
    
    private func setupBindings() {
        viewModel.didChangeLoadingState = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.loadingIndicator.startAnimating()
                    self?.tableView.isHidden = true
                } else {
                    self?.loadingIndicator.stopAnimating()
                    self?.tableView.isHidden = false
                }
            }
        }
        
        viewModel.didUpdateData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupUI() {
        setupPinkView()
        setupHeaderView()
        setupTableView()
        setupLoadingIndicator()
    }
    
    private func setupPinkView() {
        pinkView.backgroundColor = .systemPink.withAlphaComponent(0.5)
        view.addSubview(pinkView)
        
        pinkView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(270)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Home"
        titleLabel.font = .poppinsBold(size: 32)
        titleLabel.textColor = .white
        pinkView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(48)
        }
        
        let affiliateLabel = UILabel()
        affiliateLabel.text = "Affiliate program"
        affiliateLabel.font = .poppinsRegular(size: 20)
        affiliateLabel.textColor = .white
        pinkView.addSubview(affiliateLabel)
        
        affiliateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(25)
            make.top.equalTo(titleLabel.snp.bottom).offset(46)
        }
        
        let learnMoreButton = UIButton(type: .system)
        learnMoreButton.setTitle("Learn more", for: .normal)
        learnMoreButton.setTitleColor(.black, for: .normal)
        learnMoreButton.backgroundColor = .white
        learnMoreButton.layer.cornerRadius = 16
        learnMoreButton.titleLabel?.font = .poppinsRegular(size: 16)
        
        pinkView.addSubview(learnMoreButton)
        
        learnMoreButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(25)
            make.top.equalTo(affiliateLabel.snp.bottom).offset(16)
            make.width.equalTo(127)
            make.height.equalTo(35)
        }
        
        let imageView = UIImageView(image: UIImage(named: "object"))
        imageView.tintColor = .white
        pinkView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(101)
            make.left.equalToSuperview().offset(189)
            make.width.height.equalTo(242)
        }
        
        var dropdownConfig = UIButton.Configuration.filled()
        dropdownConfig.image = UIImage(systemName: "ellipsis")
        dropdownConfig.baseBackgroundColor = .white
        dropdownConfig.baseForegroundColor = .black
        dropdownConfig.cornerStyle = .capsule
        dropdownConfig.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        let dropdownButton = UIButton(configuration: dropdownConfig)
        dropdownButton.clipsToBounds = true
        pinkView.addSubview(dropdownButton)
        
        dropdownButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(titleLabel)
            make.width.height.equalTo(40)
        }
        
        let logoutAction = UIAction(title: "Выйти", image: UIImage(named: "logout")) { _ in
            self.logout()
        }
        
        let refreshAction = UIAction(title: "Обновить", image: UIImage(named: "reload")) { _ in
            self.refreshTable()
        }
        
        dropdownButton.menu = UIMenu(title: "", children: [refreshAction, logoutAction])
        dropdownButton.showsMenuAsPrimaryAction = true
    }
    
    private func logout() {
        UserDefaults.standard.set(false, forKey: "isAuthenticated")
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = LoginViewController()
        }
    }
    
    private func refreshTable() {
        loadingIndicator.startAnimating()
        viewModel.fetchData()
    }
    
    private func setupHeaderView() {
        headerView.backgroundColor = .white
        view.addSubview(headerView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Trending"
        titleLabel.font = .poppinsRegular(size: 20)
        titleLabel.textColor = .black
        
        let sortButton = UIButton(type: .system)
        sortButton.setImage(UIImage(named: "sort"), for: .normal)
        sortButton.tintColor = .black
        sortButton.addTarget(self, action: #selector(sortTapped), for: .touchUpInside)
        
        headerView.addSubview(titleLabel)
        headerView.addSubview(sortButton)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
        }
        
        sortButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(pinkView.snp.bottom).offset(-10)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        headerView.layer.cornerRadius = 16
        headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        headerView.layer.masksToBounds = true
    }
    
    private func setupTableView() {
        tableView.rowHeight = 72
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CryptoCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        loadingIndicator.startAnimating()
    }
    
    @objc private func sortTapped() {
        viewModel.toggleSort()
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CryptoCell
        let currency = viewModel.currencies[indexPath.row]
        cell.configure(with: currency)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // переход
    }
}
