//
//  ImageTableViewCell.swift
//  JsonToUIKit
//
//  Created by Tim Guk on 1/27/24.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    private var qdsImageView = UIImageView()
    override var imageView: UIImageView? { qdsImageView }

    func setup(element: UIElement) {
        guard let imageURLString = element.imageURLString else { return }
        guard let imageURL = URL(string: imageURLString) else { return }

        let dataTask = URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            guard let data = data else { return }

            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView?.image = image

                if let image = image {
                    let aspectRatio = image.size.height / image.size.width
                    self.qdsImageView.snp.remakeConstraints {
                        $0.edges.equalToSuperview().inset(16)
                        $0.height.equalTo(self.qdsImageView.snp.width).multipliedBy(aspectRatio)
                    }
                }
                self.invalidateIntrinsicContentSize()

            }
        }
        dataTask.resume()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(qdsImageView)
        qdsImageView.contentMode = .scaleAspectFit
        qdsImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        qdsImageView.image = nil
    }


}
