//
//  GithubViewModel.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/07.
//

import RxSwift
import RxCocoa
import RxDataSources

typealias GithubRepositoriesData = SectionModel<String, GithubRepository>

class GithubViewModel: ViewModelType {
    
    private var setting: GithubSetting
    
    init(with service: ReactiveGithubServiceType, setting: GithubSetting) {
        self.service = service
        self.setting = setting
    }
    
    let service: ReactiveGithubServiceType
    
    struct Input {
        let viewWillAppear: Driver<String>
        let searchEditChanged: Driver<String>
        let selectedItem: Driver<GithubRepository>
    }
    
    struct Output {
        let repositories: Driver<[GithubRepositoriesData]>
        let pushWebview: Driver<WebViewViewModel>
    }
    
    func transform(input: Input) -> Output {
        
        let fetchAPI =
            Driver<String>
            .merge([input.viewWillAppear, input.searchEditChanged])
            .asObservable()
            .flatMap { [weak self] userID -> Observable<ServiceResult<GithubRepositories, ServiceError>> in
                guard let weakSelf = self else { return Observable.empty() }
                if weakSelf.setting.userID != userID { weakSelf.setting.userID = userID }
                return weakSelf.service.fetchObservable(setting: weakSelf.setting)
            }
            .share()
            .asDriver(onErrorDriveWith: Driver.empty())
        
        let isSuccess = fetchAPI.filter { $0.isSuccess }
        
        let repositories = isSuccess.map { result -> [GithubRepositoriesData] in
            switch result {
            case .success(let item):
                return [GithubRepositoriesData(model: "", items: item.items
                )]
            case .failure(_):
                return []
            }
        }.asDriver(onErrorDriveWith: Driver.empty())
        
        let pushWebview = input.selectedItem.compactMap { $0.url.url }.map { WebViewViewModel(with: $0) }.asDriver(onErrorDriveWith: Driver.empty())
        
        
        return Output(repositories: repositories, pushWebview: pushWebview)
    }
    
    
}
