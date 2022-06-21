//
//  ViewController.swift
//  Qiita
//
//  Created by oryo on 2022/06/20.
//

import UIKit

enum LoadStatus {
    case ready
    case getting
}

class ViewController: UIViewController {
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "記事 を検索"
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.rgb(red: 244, green: 244, blue: 244)
        tableView.separatorColor = UIColor.rgb(red: 244, green: 244, blue: 244)
        tableView.register(ArticlesTableViewCell.self, forCellReuseIdentifier: "articles")
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = UIColor.rgb(red: 195, green: 202, blue: 212)
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return tableView
    }()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        activityIndicatorView.color = .gray
        return activityIndicatorView
    }()
    
    var articles: [Article]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicatorView.stopAnimating()
                self.loadStatus = .ready
            }
        }
    }
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    var loadStatus: LoadStatus = .ready
    var searchText = ""
    var articlesPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Qiita"
        
        view.backgroundColor = UIColor.rgb(red: 244, green: 244, blue: 244)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.rgb(red: 116, green: 193, blue: 58)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.anchor(top: searchBar.bottomAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.anchor(centerY: view.centerYAnchor, centerX: view.centerXAnchor)
        
        scrollView.delegate = self
    }
    
    @objc func handleRefreshControl() {
        if searchText != "" {
            articlesPage = 1
            getData(query: searchText, append: false)
        }
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func getData(query: String, append: Bool) {
        loadStatus = .getting
        let url = URL(string: "https://qiita.com/api/v2/items?page=\(articlesPage)&per_page=20&query=\(query)")!
        var request = URLRequest(url: url)
        request.addValue("Authorization", forHTTPHeaderField: "Bearer e1059b8d8b83b6b63cc1c5cf3ffe5d7378e21cca")
        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            if let error = error {
                print("error: \(error)")
                self.loadStatus = .ready
                return
            }
            
            guard let data = data else { return }
            
            do {
                let articles = try JSONDecoder().decode([Article].self, from: data)
                if append {
                    self.articles?.append(contentsOf: articles)
                } else {
                    self.articles = articles
                }
            } catch let error2 {
                print("error2: \(error2)")
                self.loadStatus = .ready
            }
        }.resume()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            activityIndicatorView.startAnimating()
            articlesPage = 1
            getData(query: searchText, append: false)
            self.searchText = searchText
        } else {
            articles = []
            articlesPage = 1
            self.searchText = ""
            activityIndicatorView.stopAnimating()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articles", for: indexPath) as! ArticlesTableViewCell
        cell.contentView.isUserInteractionEnabled = false
        cell.delegate = self
        if let articles = articles {
            cell.article = articles[indexPath.row]
        }
        return cell
    }
}

extension ViewController: ToUserProtocol {
    func toUserProtocol(user: User) {
        let userViewController = UserViewController()
        userViewController.user = user
        navigationController?.pushViewController(userViewController, animated: true)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if loadStatus == .ready {
                activityIndicatorView.startAnimating()
                articlesPage += 1
                getData(query: searchText, append: true)
            }
        }
    }
}
