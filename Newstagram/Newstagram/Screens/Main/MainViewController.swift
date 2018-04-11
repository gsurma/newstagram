//
//  MainViewController.swift
//  Newstagram
//
//  Created by Grzegorz Surma on 29/03/2018.
//  Copyright © 2018 Grzegorz Surma. All rights reserved.
//

import UIKit
import StatusProvider
import MKDropdownMenu

final class MainViewController: SPParallaxTableViewController {

    private var articles = [Article]()
    private var category: String {
        get {
            return UserDefaults.standard.getDefaultCategory()
        }
        set {
            UserDefaults.standard.setDefaultCategory(category: newValue)
        }
    }
    
    private var locale: String {
        get {
            return UserDefaults.standard.getDefaultLocale()
        }
        set {
            UserDefaults.standard.setDefaultLocale(locale: newValue)
        }
    }
    private var navBarMenu: MKDropdownMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        setNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if articles.isEmpty || UserDefaults.standard.refreshAllowed() {
            loadData()
        }
    }

    func setNavBar() {
        navBarMenu = MKDropdownMenu(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        navBarMenu.dataSource = self
        navBarMenu.delegate = self
        
        navBarMenu.backgroundDimmingOpacity = 0.5
        navBarMenu.rowTextAlignment = NSTextAlignment.center
        
        navigationItem.titleView = navBarMenu
    }
    
    private func loadData() {
        
        self.articles = []
        self.tableView.reloadData()
        let loadingStatus = Status(isLoading: true,
                                   description: "Loading")
        show(status: loadingStatus)
        
        ApiManager.sharedInstance.getHeadlines(category: category, locale: locale) { articles in
            DispatchQueue.main.async(execute: {
                if articles.isEmpty {
                    let errorStatus = Status(title: "Something went wrong",
                                             description: "Check your internet connection",
                                             actionTitle: "Try again!",
                                             image: #imageLiteral(resourceName: "NoData")) {
                        self.loadData()
                    }
                    self.show(status: errorStatus)
                    
                } else {
                    UserDefaults.standard.setLastRefreshTimestamp()
                    self.hideStatus()
                    self.articles = articles
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
        viewController.article = article
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell
        let article = articles[indexPath.row]
        cell.setArticle(article)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width * imageAspectRatio
    }
}
    
extension MainViewController: MKDropdownMenuDelegate {
    
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, titleForComponent component: Int) -> String? {
        return component == 0 ? category : locale
    }
    
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            category = categories[row]
        } else {
            locale = locales[row]
        }
        
        navBarMenu.closeAllComponents(animated: true)
        navBarMenu.reloadAllComponents()
        loadData()
    }
    
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? categories[row] : locales[row]
    }
}
    
extension MainViewController: MKDropdownMenuDataSource {
    
    func numberOfComponents(in dropdownMenu: MKDropdownMenu) -> Int {
        return 2
    }
    
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? categories.count : locales.count
    }
}

extension MainViewController: StatusController {
    
    var statusView: StatusView? {
        return DefaultStatusView()
    }
}
