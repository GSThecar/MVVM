//
//  WebViewViewController.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/08.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class WebViewViewController: ViewController, ViewType {
    typealias T = WebViewViewModel
    
    private let progressView: UIProgressView = UIProgressView().then {
        $0.backgroundColor = .clear
        $0.trackTintColor = .gray
        $0.tintColor = .cyan
    }
    
    private let webView: WebView = WebView()
    
    var viewModel: T!
    var disposeBag: DisposeBag!
    
    func setUpUI() {
        view.backgroundColor = .white
        [webView, progressView].forEach { view.addSubview($0) }
    }
    
    func setUpLayout() {
        webView.snp.makeConstraints { $0.directionalEdges.equalToSuperview() }
        
        progressView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    func setUpBinding() {
        let viewWillAppear = rx.viewWillAppear.asDriver()
        
        let estimatedProgress = webView.rx.estimatedProgress.asDriver()
        
        let input = WebViewViewModel.Input(viewWillAppear: viewWillAppear, estimatedProgress: estimatedProgress)
        
        let output = viewModel.transform(input: input)
        
        output.load.drive(onNext: { [weak self] request in
            guard let weakSelf = self else { return }
            weakSelf.webView.load(request)
        }).disposed(by: disposeBag)
        
        output.estimatedProgress.drive(onNext: { [weak self] progress in
            guard let weakSelf = self else { return }
            weakSelf.progressView.progress = progress
            weakSelf.progressView.isHidden = progress == .zero || progress == 1.0
        }).disposed(by: disposeBag)
    }

}
