//
//  ViewController.swift
//  PicSumViewer
//
//  Created by Siddharth Kothari on 31/01/24.
//

import UIKit

class ViewController: UIViewController {

    let imagesListTableView = UITableView()
    var imagesData: [ImageDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagesListTableView.backgroundColor = .red
        view.addSubview(imagesListTableView)
        imagesListTableView.dataSource = self
        imagesListTableView.delegate = self
        imagesListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "imageCell")
        self.navigationController?.title = "ImageList"
        setupConstraints()
        getData()
    }
    
    func setupConstraints() {
        imagesListTableView.translatesAutoresizingMaskIntoConstraints = false
        imagesListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imagesListTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        imagesListTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        imagesListTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func getData() {
        NetworkManager().fetchImageList { result in
                    switch result {
                    case .success(let data):
                        print("success data: \(data)")
                        self.imagesData = data
                        DispatchQueue.main.async {
                            self.imagesListTableView.reloadData()
                        }
                    case .failure(let error):
                        print("error : \(error.localizedDescription)")
                    }
                }
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imagesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
        cell.textLabel?.text = self.imagesData[indexPath.row].filename
          return cell
    }


}


extension ViewController: UITableViewDelegate {

}
