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
    
    init(with service: ReactiveGithubServiceType, setting: GithubSetting) {
        self.service = service
    }
    
    let service: ReactiveGithubServiceType
    
    struct Input {
        let viewWillAppear: Driver<Void>
    }
    
    struct Output {
        let repositories: Driver<[GithubRepositoriesData]>
    }
    
    func transform(input: Input) -> Output {
        let fetchAPI = input
            .viewWillAppear
            .asObservable()
            .flatMap { [weak self] () -> Observable<ServiceResult<GithubRepositories, ServiceError>> in
                guard let weakSelf = self else { return Observable.empty() }
                return weakSelf.service.fetchObservable(setting: GithubSetting())
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
