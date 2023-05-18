//
//  RickAndMortyVC.swift
//  RickAndMorty-WithoutSB
//
//  Created by Kadir Yılmaz on 18.05.2023.
//

import UIKit
import SnapKit

protocol RickAndMortyOutPut {
    func changeLoading(isLoad: Bool)
    func saveData(values: [Result])
}

final class RickAndMortyVC: UIViewController {
    
    private let labelTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()

    private var  results: [Result] = []
    
    var viewModel: IRickAndMortyViewModel = RickAndMortyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()

    }
    
    func configure() {
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(RickAndMortyTableViewCell.self, forCellReuseIdentifier: RickAndMortyTableViewCell.reuseID)
        tableView.rowHeight = self.view.frame.size.height * 0.2
        
        view.backgroundColor = .white
        labelTitle.text = "Characters"
        labelTitle.font = .boldSystemFont(ofSize: 26)
        labelTitle.textAlignment = .center
        indicator.startAnimating()
        
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalTo(labelTitle)
        }
        
        indicator.snp.makeConstraints { make in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle)
            make.top.equalTo(labelTitle)
        }
    }

}

extension RickAndMortyVC: RickAndMortyOutPut {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveData(values: [Result]) {
        results = values
        tableView.reloadData()
    }
    
}

extension RickAndMortyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: RickAndMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickAndMortyTableViewCell.reuseID) as? RickAndMortyTableViewCell else {
            return UITableViewCell()
        }
        
        cell.saveModel(model: results[indexPath.row])
        
        return cell
    }
}
