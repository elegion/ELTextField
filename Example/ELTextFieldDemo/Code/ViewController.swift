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
        case search(model: PNFloatPlaceholderTextFieldBehavior)
    }
    
    private let items: [Items] = [
//        .topPlaceholder(model: .init(placeholder: "Hello")),
        .topPlaceholder(model: PasswordBehavior()),
//        .search(model: PNFloatPlaceholderTextFieldBehavior(placeholder: "Имя", anyValueGender: .female)),
//        .search(model: PNFloatPlaceholderTextFieldBehavior(placeholder: "Фамилия", anyValueGender: .female)),
//        .search(model: PNFloatPlaceholderTextFieldBehavior(placeholder: "Почта", anyValueGender: .female)),
//        .search(model: PNFloatPlaceholderTextFieldBehavior(placeholder: "Номер телефона",
//                                                           anyValueGender: .female,
//                                                           mask: ELPhoneTextMask(phoneCode: "+7",
//                                                                                 inputMask: "$ (###) ### ## ##",
//                                                                                 outputMask: "$##########"))),
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(cellType: AbstractTableViewCell<PNFloatPlaceholderTextFieldContainer>.self)
        tableView.register(cellType: AbstractTableViewCell<PNTopPlaceholderTextFieldContainer>.self)
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
                let cell = tableView.dequeueCell(of: AbstractTableViewCell<PNTopPlaceholderTextFieldContainer>.self,
                                                 for: indexPath)
                cell.set(model: model)
                return cell
            case let .search(model):
                let cell = tableView.dequeueCell(of: AbstractTableViewCell<PNFloatPlaceholderTextFieldContainer>.self, for: indexPath)
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
