//
//  RickAndMortyTableViewCell.swift
//  RickAndMorty-WithoutSB
//
//  Created by Kadir Yılmaz on 18.05.2023.
//

import UIKit
import SnapKit
import AlamofireImage

class RickAndMortyTableViewCell: UITableViewCell {
    
    static let reuseID = "RickAndMortyCell"
    
    private let customImage: UIImageView = UIImageView()
    private let title: UILabel = UILabel()
    private let customDescription: UILabel = UILabel()
    
    private let randomImage: String = "https://picsum.photos/200/300"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(customImage)
        addSubview(title)
        addSubview(customDescription)
        
        title.font = .boldSystemFont(ofSize: 18)
        title.textAlignment = .center
        customDescription.font = .italicSystemFont(ofSize: 14)
        customImage.contentMode = .scaleAspectFit
        customDescription.textAlignment = .center
        
        customImage.snp.makeConstraints { make in
            make.height.equalTo(contentView.snp.height).multipliedBy(0.5)
            make.top.equalTo(contentView).offset(5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(customImage.snp.bottom).offset(10)
            make.right.left.equalTo(contentView)
        }

        customDescription.snp.makeConstraints { make in
            make.top.equalTo(title).offset(5)
            make.right.left.equalTo(title)
            make.bottom.equalToSuperview().offset(5)
        }
    }
    
    func saveModel(model: Result) {
        title.text = model.name
        customDescription.text = model.status
        customImage.af.setImage(withURL: URL(string: model.image ?? randomImage) ?? URL(string: randomImage)!)
    }
    
}
