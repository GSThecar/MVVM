//
//  WebView.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/08.
//

import WebKit

class WebView: WKWebView {

    init() {
        super.init(frame: .zero, configuration: WKWebViewConfiguration())
        backgroundColor = .white
        allowsBackForwardNavigationGestures = true
        allowsLinkPreview = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
