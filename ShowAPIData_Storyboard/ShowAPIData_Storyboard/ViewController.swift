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
        self.title = "Test"
        view.addSubview(paginationTableView)
        paginationTableView.dataSource = self
        paginationTableView.delegate = self
        paginationTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupConstraints()
        fetchData()
    }


    private func setupConstraints() {
        paginationTableView.translatesAutoresizingMaskIntoConstraints = false
        paginationTableView.topAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!).isActive = true
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
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
        let label = UILabel(frame: footerView.bounds)
        label.textAlignment = .center
        label.numberOfLines = 0
        let supportText = self.paginationData?.support.text ?? "support"
        label.text = supportText
        footerView.addSubview(label)
        return footerView
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paginationData?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = self.paginationData?.users[indexPath.row]
        let firstName = user?.firstName ?? "first"
        let lastName = user?.lastName ?? "last"
        cell.textLabel?.text = "\(firstName) \(lastName)"
        return cell
    }
    
    
}
