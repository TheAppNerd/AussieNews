//
//  TrendingCategoryVCViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 23/3/2022.
//

import UIKit

//create 5 lines across top with 2 second animation left to right color fill - Complete
//create view to fill with article data - complete
//create func to make articles change every 3 seconds
//add left and right tap gestures
//create fab at bottom to go to page
//create x top right to dismiss and return to home




class TrendingCategoryVC: UIViewController {
    
    var newsArticles: [Article] = []
    var progressViewArray: [UIProgressView] = []
    let progressStack = UIStackView()
    let trendingView = TrendingView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureProgressStack()
        layoutUI()
        animateProgressViews()
        trendingView.set(imageString: newsArticles[0].media!, labelText: newsArticles[0].title!)
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        
    }
   
    private func configureProgressStack() {
        
        for _ in 0...4 {
            let progressView = UIProgressView(progressViewStyle: .bar)
            progressView.translatesAutoresizingMaskIntoConstraints = false
            progressView.backgroundColor = .systemGray3
            progressView.progressTintColor = .orange
            progressViewArray.append(progressView)
        }
        
        
        progressStack.translatesAutoresizingMaskIntoConstraints = false
        for view in progressViewArray {
            progressStack.addArrangedSubview(view)
        }
        progressStack.alignment = .fill
        progressStack.spacing = 10
        progressStack.distribution = .fillEqually
        progressStack.axis = .horizontal
        
    }
    
    private func layoutUI() {
       
        view.addSubviews(progressStack, trendingView)
        
        NSLayoutConstraint.activate([
            progressStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            progressStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            progressStack.heightAnchor.constraint(equalToConstant: 10),
            
            trendingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trendingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            trendingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            trendingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])
    }
    
    func set(articles: [Article]) {
        newsArticles = articles
    }
    
    
    func animate(num: Int, duration: Double) {

        UIView.animate(withDuration: duration, delay: 0) {
            let progress: Float = 1.0
            self.progressViewArray[num].setProgress(progress, animated: true)
        } completion: { _ in
            let article = self.newsArticles[num]
            self.trendingView.set(imageString: article.media!, labelText: article.title!)
        }

    }
    
    func animateProgressViews() {
        var num = 0
        let duration = 4.0
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { timer in
            self.animate(num: num, duration: duration)
            num += 1
            if num == 5 {
                timer.invalidate()
            }
        }
    }
    
}
