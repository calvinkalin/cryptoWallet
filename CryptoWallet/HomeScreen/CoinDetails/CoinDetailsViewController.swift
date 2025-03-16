//
//  CoinDetailsViewController.swift
//  CryptoWallet
//
//  Created by Ilya Kalin on 16.03.2025.
//

import UIKit

class CoinDetailsViewController: UIViewController {
    private let viewModel: CoinDetailsViewModel
    
    init(viewModel: CoinDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["24H", "1W", "1Y", "ALL", "Point"])
        control.selectedSegmentIndex = 0
        return control
    }()
    
    private let statsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let marketCapLabel = UILabel()
    private let circulatingSupplyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        setupUI()
        configureData()
    }
    
    private func setupUI() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(priceChangeLabel)
        view.addSubview(segmentControl)
        view.addSubview(statsView)
        
        statsView.addSubview(marketCapLabel)
        statsView.addSubview(circulatingSupplyLabel)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        priceChangeLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(priceChangeLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        statsView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(120)
        }
        
        marketCapLabel.snp.makeConstraints { make in
            make.top.equalTo(statsView).offset(20)
            make.left.equalTo(statsView).offset(16)
        }
        
        circulatingSupplyLabel.snp.makeConstraints { make in
            make.top.equalTo(marketCapLabel.snp.bottom).offset(10)
            make.left.equalTo(statsView).offset(16)
        }
    }
    
    private func configureData() {
        titleLabel.text = "\(viewModel.name) \(viewModel.symbol)"
        priceLabel.text = viewModel.price
        priceChangeLabel.text = viewModel.priceChange
        priceChangeLabel.textColor = viewModel.isPriceUp ? .green : .red
//        marketCapLabel.text = "Market Capitalization: \(viewModel.marketCap)"
//        circulatingSupplyLabel.text = "Circulating Supply: \(viewModel.circulatingSupply)"
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
