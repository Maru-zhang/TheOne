//
//  TEMovieController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ReactiveSwift
import ESPullToRefresh


class TEMovieController: UITableViewController {
    
    let viewModel = TEMovieViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        setupView()
        
        bindingView()
        
    }
    
    // MARK: - Private Method
    
    private func setupView() {
        setupCommentItem()
        tableView.separatorStyle = .none
        tableView.register(TEMovieCardCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(TEMovieCardCell.self))
        tableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 9)
        let _ = tableView.es_addInfiniteScrolling { [unowned self] in
//            self.viewModel.loadMoreObserver.send(value: <#T##Void#>)
        }

    }
    
    private func bindingView() {
        
        viewModel.active <~ isActive()
        
        viewModel.refreshSignal
            .observe(on: UIScheduler())
            .startWithValues { [unowned self] in
            
            self.viewModel.fetchRemoteRefreshDataWithCallBack(success: { (entitys) in
                self.tableView.reloadData()
                self.tableView.es_stopLoadingMore()
                }, failure: { (error) in
                    self.tableView.es_stopLoadingMore()
                    // TODO: 添加网络状态错误的相关HUD
                    TEToastService.showNetDisconnet()
            })
        }
        
        viewModel.loadMoreSignal
            .observe(on: UIScheduler())
            .observeValues { [unowned self]() in
            self.viewModel.fetchRemoteDataWithCallBack(success: { 
                self.tableView.reloadData()
                self.tableView.es_stopLoadingMore()
                }
                , failure: { (fail) in
                    if fail.code == 0 {
                        self.tableView.es_noticeNoMoreData()
                    }else {
                        // TODO: 添加网络状态错误的相关HUD
                        TEToastService.showNetDisconnet()
                    }
            })
        }
        

    }
    
    
}

extension TEMovieController {
    
    // MARK: - DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMoviesInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TEMovieCardCell.self), for: indexPath) as! TEMovieCardCell
        
        cell.configureWithViewModels(viewModel: viewModel, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    // MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForCellAtIndexPath(indexPath: indexPath as NSIndexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = TEMovieDetailViewModel.init(movie: viewModel.entityMappingIndexPath(indexPath: indexPath as NSIndexPath))
        
        navigationController?.pushViewController(TEMovieDetailController.init(model: model), animated: true)
    }
    
}

