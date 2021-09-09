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

final class GithubRepositoryViewController: ViewController, ViewType {
    
    typealias T = GithubViewModel
    
    var viewModel: T!
    var disposeBag: DisposeBag!
    
    private let tableView: UITableView = UITableView().then {
        $0.separatorColor = .systemRed
        $0.register(cell: GithubRepositoryTableViewCell.self)
    }
    
    private let searchBar: UISearchBar = UISearchBar()
    
    func setUpUI() {
        view.backgroundColor = .white
        [searchBar, tableView].forEach { view.addSubview($0) }
    }
    
    func setUpLayout() {
        searchBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.equalTo(searchBar.snp.leading)
            $0.top.equalTo(searchBar.snp.bottom)
            $0.trailing.equalTo(searchBar.snp.trailing)
            $0.bottom.equalToSuperview()
        }
    }
    
    func setUpBinding() {
        
        let viewWillAppear = rx.viewWillAppear.asDriver().map { [weak self] in self?.searchBar.text ?? "" }
        
        let searchEditChanged = searchBar.searchTextField.rx.editingChanged.asDriver().map { [weak self] in self?.searchBar.text ?? ""}
        
        let selectedItem = tableView.rx.modelSelected(GithubRepositoriesData.Item.self).asDriver()
        
        let input =
            GithubViewModel
            .Input(
                viewWillAppear: viewWillAppear,
                searchEditChanged: searchEditChanged,
                selectedItem: selectedItem
            )
        
        let output = viewModel.transform(input: input)
        
        let datasource = RxTableViewSectionedReloadDataSource<GithubRepositoriesData> { _, tableview, indexPath, item in
            let cell = tableview.dequeue(GithubRepositoryTableViewCell.self)!
            cell.configure(title: item.fullName, description: item.description, numeric: item.starCount)
            return cell
        }
        
        output
            .repositories
            .drive(tableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        output
            .pushWebview
            .drive(onNext: { [weak self] webviewViewmodel in
                guard let weakSelf = self,
                      let coordinator = weakSelf.coordinator as? TabCoordinator
                else { return }
                coordinator.detailRepository(with: webviewViewmodel)
            })
            .disposed(by: disposeBag)
        
    }
    
}

