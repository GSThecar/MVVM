//
//  GithubService+Reactive.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/07.
//

import RxSwift

protocol ReactiveGithubServiceType {
    func fetchObservable(setting: GithubSetting) -> Observable<ServiceResult<GithubRepositories, ServiceError>>
}

extension GithubService: ReactiveGithubServiceType {
    func fetchObservable(setting: GithubSetting) -> Observable<ServiceResult<GithubRepositories, ServiceError>> {
        return Observable<ServiceResult<GithubRepositories, ServiceError>>.create { [weak self] observer -> Disposable in
            self?.fetchGithubRepositories(by: setting, completion: { result in
                observer.onNext(result)
            })
            return Disposables.create()
        }
    }
}
