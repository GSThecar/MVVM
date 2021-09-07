//
//  GithubRepositoryViewController.swift
//  MVVM
//
//  Created by 이덕화 on 2021/08/28.
//

import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class GithubRepositoryViewController: UIViewController, ViewType {
    typealias T = GithubViewModel
    
    var viewModel: T!
    var disposeBag: DisposeBag!
    
    private let tableView: UITableView = UITableView().then {
        $0.separatorColor = .systemRed
        $0.register(cell: GithubRepositoryTableViewCell.self)
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    func setUpLayout() {
        tableView.snp.makeConstraints { $0.directionalEdges.equalToSuperview() }
    }
    
    func setUpBinding() {
        let output = viewModel.transform(input: .init(viewWillAppear: rx.viewWillAppear.asDriver()))
        
        let datasource = RxTableViewSectionedReloadDataSource<GithubRepositoriesData> { _, tableview, indexPath, item in
            let cell = tableview.dequeue(GithubRepositoryTableViewCell.self)!
            cell.configure(title: item.fullName, description: item.description, numeric: item.starCount)
            return cell
        }
        
        output
            .repositories
            .drive(tableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
    }
    
}

