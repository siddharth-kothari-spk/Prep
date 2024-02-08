//
//  ViewController.swift
//  ShowAPIData_Storyboard
//
//  Created by Siddharth Kothari on 08/02/24.
//

import UIKit

class ViewController: UIViewController {
    let paginationTableView = UITableView()
    var paginationData: PaginationData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(paginationTableView)
        paginationTableView.dataSource = self
        paginationTableView.delegate = self
        paginationTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupConstraints()
        fetchData()
    }


    private func setupConstraints() {
        paginationTableView.translatesAutoresizingMaskIntoConstraints = false
        paginationTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        paginationTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        paginationTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        paginationTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    private func fetchData() {
        NetworkManager().fetchAPIData { result in
            switch result {
            case .success(let paginationData):
                print("success, data: \(paginationData)")
                self.paginationData = paginationData
                DispatchQueue.main.async {
                    self.paginationTableView.reloadData()
                }
            case .failure(let error):
                print("error : \(error.localizedDescription)")
            }
        }
    }
}


extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
