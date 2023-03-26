//
//  ViewController.swift
//  ELTextFieldDemo
//
//  Created by viktor.volkov on 25.03.2023.
//

import ELTextField
import SnapKit
import UIKit

class ViewController: UIViewController {
    enum Sections {
        case textFields
    }
    enum Items: Hashable {
        case topPlaceholder(model: ELDefaultTextFieldBehavior)
        case search(model: PNSearchTextFieldBehavior)
    }
    
    private let items: [Items] = [
        .topPlaceholder(model: .init(placeholder: "Hello")),
        .search(model: PNSearchTextFieldBehavior(floatingPlaceholder: "Имя", anyValueGender: .female)),
        .search(model: PNSearchTextFieldBehavior(floatingPlaceholder: "Фамилия", anyValueGender: .female)),
        .search(model: PNSearchTextFieldBehavior(floatingPlaceholder: "Почта", anyValueGender: .female)),
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(cellType: AbstractTableViewCell<PNSearchTextFieldContainer>.self)
        tableView.register(cellType: AbstractTableViewCell<PNFloatingPlaceholderTextFieldContainer>.self)
        return tableView
    }()
    private var dataSource: UITableViewDiffableDataSource<Sections, Items>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.backgroundColor = .white
        configureDataSource()
        addItems()
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Sections, Items>(tableView: tableView) {
            tableView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
            case let .topPlaceholder(model):
                let cell = tableView.dequeueCell(of: AbstractTableViewCell<PNFloatingPlaceholderTextFieldContainer>.self,
                                                 for: indexPath)
                cell.set(model: model)
                return cell
            case let .search(model):
                let cell = tableView.dequeueCell(of: AbstractTableViewCell<PNSearchTextFieldContainer>.self, for: indexPath)
                cell.set(model: model)
                return cell
            }
        }
    }
    
    private func addItems() {
        var snapshot = dataSource?.snapshot() ?? NSDiffableDataSourceSnapshot<Sections, Items>()
        snapshot.appendSections([.textFields])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot)
    }
}
