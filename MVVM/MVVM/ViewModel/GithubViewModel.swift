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
    }
    
    struct Output {
        let repositories: Driver<[GithubRepositoriesData]>
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
        
        return Output(repositories: repositories)
    }
    
    
}
