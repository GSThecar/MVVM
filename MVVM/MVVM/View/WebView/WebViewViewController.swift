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

class WebViewViewController: UIViewController, ViewType {
    typealias T = WebViewViewModel
    private let webView: WKWebView = WKWebView()
    
    var viewModel: T!
    
    var disposeBag: DisposeBag!
    
    func setUpUI() {
        view.backgroundColor = .white
        view.addSubview(webView)
    }
    
    func setUpLayout() {
        webView.snp.makeConstraints { $0.directionalEdges.equalToSuperview() }
    }
    
    func setUpBinding() {
        let input = WebViewViewModel.Input(viewWillAppear: rx.viewWillAppear.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.load.drive(onNext: { [weak self] request in
            guard let weakSelf = self else { return }
            weakSelf.webView.load(request)
        }).disposed(by: disposeBag)
    }

}
