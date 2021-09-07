//
//  GithubRepositoryTableViewCell.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/07.
//

import UIKit

class GithubRepositoryTableViewCell: UITableViewCell {

    private let titleLabel: UILabel = UILabel().then {
        $0.lineBreakMode = .byTruncatingHead
        $0.font = .preferredFont(forTextStyle: .headline)
        $0.textColor = .black
    }
    
    private let descriptionLabel: UILabel = UILabel().then {
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = .preferredFont(forTextStyle: .caption1)
        $0.textColor = .gray
    }
    
    private let numericalLabel: UILabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.textColor = .blue
    }
    
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
        setUpUI()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        contentView.backgroundColor = .white
        selectionStyle = .none
        [titleLabel, descriptionLabel, numericalLabel].forEach { contentView.addSubview($0) }
    }
    
    private func setUpLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalTo(UI.defaultMargin)
            $0.trailing.equalToSuperview().inset(UI.defaultMargin)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(UI.smallMargin)
            $0.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        numericalLabel.snp.makeConstraints {
            $0.leading.equalTo(descriptionLabel.snp.leading)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(UI.smallMargin)
            $0.trailing.equalTo(descriptionLabel.snp.trailing)
            $0.bottom.equalToSuperview().inset(UI.bigMargin)
        }
    }
    
    func configure(title: String?, description: String?, numeric: Int) {
        titleLabel.text = title
        descriptionLabel.text = description
        numericalLabel.text = String(describing: numeric)
    }

}
