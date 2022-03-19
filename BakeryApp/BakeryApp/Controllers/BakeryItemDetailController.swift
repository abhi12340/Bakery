//
//  BakeryItemDetailController.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import UIKit

class BakeryItemDetailController: UIViewController {

    weak var bakeryItemDetailChildCoordinator: BakeryItemDetailChildCoordinator?
    private var itemDataSource: Item?
    private var viewmodel: ItemDetailsViewModel!
    
    lazy var titleBar: UILabel = {
        $0.text = "Item Details"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = .black
        return $0
    }(UILabel())
    
    lazy var tableView: UITableView = {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "itemDetails")
        $0.dataSource = self
        $0.delegate = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    lazy var closeButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "close_button"), for: .normal)
        $0.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
        $0.layer.cornerRadius = 10
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel = ItemDetailsViewModel(item: itemDataSource)
        setupview()
    }
}

extension BakeryItemDetailController: UITableViewDataSource, UITableViewDelegate {
    
    func setupInital(data: Item?) {
        itemDataSource = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataSource = viewmodel.getDatasource()
        guard let rows = dataSource[section].rows else {
            return 0
        }
        return dataSource[section].isExpanded ? rows.count : 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemDetails", for: indexPath)
        let dataSource = viewmodel.getDatasource()
        let type = dataSource[indexPath.section].rows?[indexPath.row].type
        cell.textLabel?.text = "\(type ?? "")"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewmodel.getNumberOfSection()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dataSource = viewmodel.getDatasource()
        var headerlabel = UILabel(frame: CGRect(origin: .zero,
                                                size: CGSize(width: tableView.frame.width, height: 40))
                                    .inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 2)))
        headerlabel.font = UIFont.boldSystemFont(ofSize: 16)
        headerlabel.text = dataSource[section].title
        headerlabel.backgroundColor = .systemGray6
        if let rows = dataSource[section].rows, rows.count != 0  {
            addTapGesture(&headerlabel,section: section)
        }
        return headerlabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    private func addTapGesture(_ headerView: inout UILabel, section: Int) {
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderTapped(_:)))
        headerView.addGestureRecognizer(tapgesture)
        tapgesture.view?.tag = section
        headerView.isUserInteractionEnabled = true
    }
    
    @objc private func sectionHeaderTapped(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else {
            return
        }
        let datasource = viewmodel.getDatasource()
        viewmodel.updateExpandedState(at: section, with: !datasource[section].isExpanded)
        tableView.reloadSections([section], with: .middle)
    }
    
    @objc private func dismiss(_ sender: UIButton) {
        bakeryItemDetailChildCoordinator?.dismissItemDetails()
        sender.dropShadow()
    }
    
    private func setupview() {
        view.addSubview(closeButton)
        view.addSubview(tableView)
        view.addSubview(titleBar)
        view.backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                           constant: -8),
                                     closeButton.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                                     closeButton.heightAnchor.constraint(equalToConstant: 30),
                                     closeButton.widthAnchor.constraint(equalToConstant: 30)])
        
        NSLayoutConstraint.activate([titleBar.safeAreaLayoutGuide
                                     .topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     titleBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     titleBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                     titleBar.heightAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: titleBar.bottomAnchor, constant: 10),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)])
    }
}
