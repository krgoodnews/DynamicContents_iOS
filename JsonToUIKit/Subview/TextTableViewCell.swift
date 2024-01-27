//
//  TextTableViewCell.swift
//  JsonToUIKit
//
//  Created by Tim Guk on 1/27/24.
//

import UIKit

import SnapKit

class TextTableViewCell: UITableViewCell {

    private var titleLabel = UILabel()

    override var textLabel: UILabel? { titleLabel }

    func setup(element: UIElement) {
        titleLabel.text = element.title
        titleLabel.numberOfLines = 0

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }

}
