//
//  BakeryItemMenuController.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import UIKit

class BakeryItemMenuController: UIViewController {

    weak var bakeryItemMenuChildCoordinator : BakeryItemMenuChildCoordinator?
    
    var viewmodel: ItemMenuViewModel!
    
    var itemlist = [Item]()
    
    let disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        $0.center = view.center
        $0.color = .gray
        return $0
    }(UIActivityIndicatorView(style: .large))
    
    override func viewDidLoad() {
        viewmodel = ItemMenuViewModel(networkService: NetworkManager.shared)
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Bakery Store"
        setupView()
        setupBinding()
        viewmodel.getItems()
    }
    
}

extension BakeryItemMenuController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func setupBinding() {
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
        datasourceBinding()
        errorBinding()
    }
    
    private func datasourceBinding() {
        
        viewmodel.datasource.subscribe { [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.itemlist = result
                self?.collectionView.reloadData()
            }
        }.disposed(by: disposeBag)
    }
    
    private func errorBinding() {
        
        viewmodel.error.subscribe { [weak self] message in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.bakeryItemMenuChildCoordinator?.presentAlert(message: message)
            }
        }.disposed(by: disposeBag)
    }
    
    private func setupView() {
        view.addSubview(activityIndicator)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                             constant: 16),
                                     collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                     collectionView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     collectionView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemlist.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier,
                                                            for: indexPath) as? ItemCell else {
            fatalError("failed to dequeue")
        }
        cell.delegate = self
        let cellInfo = ItemCellViewModel(item: itemlist[indexPath.item], indexPath: indexPath)
        cell.setup(data: cellInfo.itemCellDetail)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 32
        let height = width / 2
        return CGSize(width: width, height: height)
    }
}


extension BakeryItemMenuController: ItemCellDelegate {
    
    func showDetails(indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            return
        }
        bakeryItemMenuChildCoordinator?.presentItemDetailVC(item: itemlist[indexPath.item])
    }
}
