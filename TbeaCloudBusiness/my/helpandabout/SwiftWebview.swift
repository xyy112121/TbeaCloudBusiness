//
//  SwiftWebview.swift
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/11/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class SwiftWebview:UIViewController, WKNavigationDelegate{
    
    
    var FCStrURL:String = "http://www.baidu.com"
    var FCtitle:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let cButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let leftImage = UIImage(named: "returnback")!
        cButton.setImage(leftImage, for: UIControlState())
        cButton.addTarget(self, action: #selector(returnback), for: .touchUpInside)
        cButton.contentMode = UIViewContentMode.scaleAspectFit
        let leftItem = UIBarButtonItem(customView: cButton)
        self.navigationItem.leftBarButtonItem = leftItem
        
        initview();
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor(red:0,green:170/255.0,blue:238/255.0,alpha:1)
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0,green:170/255.0,blue:238/255.0,alpha:1)
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.systemFont(ofSize:17)]
    }

    
    func initview()
    {
        print("宽\(view.frame.size.width)"+"高\(view.frame.size.height)")
        self.view.backgroundColor = UIColor.gray
        self.title = FCtitle;
        let configuration = WKWebViewConfiguration()
        let webview = WKWebView(frame:CGRect(x:0,y:0,width:self.view.frame.size.width,height:self.view.frame.size.height) , configuration: configuration)
        webview.uiDelegate = self as? WKUIDelegate// as? WKUIDelegate;
        webview.navigationDelegate = self
        self.view.addSubview(webview)
        
        let myurl = URL(string: self.FCStrURL)
        
        let request = URLRequest(url: myurl!)
        webview.load(request);
    }
    
    func returnback()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
        //        NSLog(@"%@",navigationResponse.response.URL.absoluteString);
        //        String *requestString = navigationResponse.response.URL.absoluteString;
        //页面开始加载时调用
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(#function)
        
        //当内容开始返回时调用
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(#function)
        //页面加载完成之后调用
    }
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
        //服务器重定向页面时调用.
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(#function)
        print(error.localizedDescription)
        //页面加载失败时调用
    }
    
}
