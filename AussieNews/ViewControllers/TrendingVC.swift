//
//  TrendingCategoryVCViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 23/3/2022.
//

import UIKit

class TrendingVC: UIViewController, SafariProtocol, UIGestureRecognizerDelegate {


    // MARK: - Properties

    let pageControl             = UIPageControl()
    let scrollView              = UIScrollView()
    var topicLabel              = CustomLabel()
    var newsArticles: [Article] = []
    var topic: String           = ""
    var array: [CardView]       = []

    // MARK: - Class Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        NewsManager.Shared.topic = topic
        getArticles(params: .topic)
        configure()
        configurePageControl()
        configureScrollView()
        layoutUI()
        // TODO: - move all this out of view did load
        let tap = UITapGestureRecognizer(target: self, action: #selector(articleTapped))
        tap.delegate = self
        scrollView.addGestureRecognizer(tap)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureScrollView()
    }

    // MARK: - Methods

    private func configure() {
        view.backgroundColor     = .systemBackground
        topicLabel.text          = topic.uppercased()
        topicLabel.font          = UIFont.boldSystemFont(ofSize: 30)
        topicLabel.textAlignment = .center
        topicLabel.sizeToFit()
    }

    private func configurePageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.layer.cornerRadius            = 15
        pageControl.numberOfPages                 = 6
        pageControl.pageIndicatorTintColor        = .secondaryLabel
        pageControl.currentPageIndicatorTintColor = .label
        pageControl.backgroundColor               = Color.aussieGreen
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
    }

    @objc func articleTapped(sender: UITapGestureRecognizer) {
        showArticle(self, article: newsArticles[pageControl.currentPage])
    }

    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.delegate        = self

        let numberOfPages          = 6
        scrollView.contentSize     = CGSize(width: scrollView.frame.size.width * CGFloat(numberOfPages), height: scrollView.frame.size.height)

        for num in 0...numberOfPages - 1 {
            let page = CardView(frame: CGRect(x: CGFloat(num) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
            array.append(page)
            scrollView.addSubview(page)
        }
    }

    /// Parses news to instagram style view.
    func getArticles(params: NewsManager.networkParams) {
        NewsManager.Shared.topic = topic
        NewsManager.Shared.getNews(params:params) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newsArticles):
                DispatchQueue.main.async { [self] in
                    self.newsArticles.append(contentsOf: newsArticles.articles)
                    self.newsArticles.shuffle()
                    // TODO: - move to func
                    for (index, views) in self.array.enumerated() {
                        views.set(article: self.newsArticles[index])
                        views.card.backgroundColor = .secondarySystemBackground
                    }
                }
            case.failure(let error): print(error.rawValue)
            }
        }
    }

    private func layoutUI() {
        view.addSubviews(pageControl, topicLabel, scrollView)
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),

            topicLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            topicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topicLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topicLabel.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: -10),

            scrollView.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

    @objc func pageControlChanged(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }

}

// MARK: - ScrollView - UIScrollViewDelegate

extension TrendingVC: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
    }

}
