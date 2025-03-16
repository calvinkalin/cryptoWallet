//
//  CryptoCell.swift
//  CryptoWallet
//
//  Created by Ilya Kalin on 16.03.2025.
//

import UIKit

class CryptoCell: UITableViewCell {
    private let logoImageView = UIImageView()
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    private let priceLabel = UILabel()
    private let changeLabel = UILabel()
    
    func configure(with currency: Currency) {
        logoImageView.image = UIImage(named: currency.logoName)
        nameLabel.text = currency.name
        symbolLabel.text = currency.symbol.uppercased()
        priceLabel.text = String(format: "$%.2f", currency.price)
        changeLabel.text = String(format: "%.1f%%", currency.changePercent)
        changeLabel.textColor = currency.changePercent >= 0 ? .systemGreen : .systemRed
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let textStack = UIStackView(arrangedSubviews: [nameLabel, symbolLabel])
        textStack.axis = .vertical
        textStack.spacing = 4
        
        let rightStack = UIStackView(arrangedSubviews: [priceLabel, changeLabel])
        rightStack.axis = .vertical
        rightStack.alignment = .trailing
        rightStack.spacing = 4
        
        logoImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(textStack)
        contentView.addSubview(rightStack)
        
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        textStack.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
        }
        
        rightStack.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(textStack.snp.trailing).offset(8)
        }
        
        nameLabel.font = .poppinsRegular(size: 18)
        symbolLabel.font = .poppinsRegular(size: 14)
        symbolLabel.textColor = .secondaryLabel
        priceLabel.font = .poppinsRegular(size: 18)
        changeLabel.font = .poppinsRegular(size: 14)
    }
}
