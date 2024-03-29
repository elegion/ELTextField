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
        case sk(model: ELDefaultTextFieldBehavior)
        case skMultiline(model: ELDefaultTextFieldBehavior)
        case search(model: PNFloatPlaceholderTextFieldBehavior)
        case tl(model: TLTextFieldBehavior)
//        case tlMultiline(model: TLTextFieldBehavior)
    }
    
    private let items: [Items] = [
        .topPlaceholder(model: MailBehavior()),
        .topPlaceholder(model: PasswordBehavior()),
        .sk(model: .init(text: "allo",
                         placeholder: "Привет",
                         rightItem: .action(image: UIImage(systemName: "pencil"),
                                            mode: .always,
                                            behavior: .delete))),
        .skMultiline(model: .init(textMapper: {
            $0?.attribute.with(foregroundColor: .black).with(font: .systemFont(ofSize: 24)).build()
        }, placeholder: "allo", placeholderMapper: {
            $0?.attribute.with(foregroundColor: .gray).build()
        })),
//        .sk(model: ),
        .search(model: PNFloatPlaceholderTextFieldBehavior(placeholder: "Имя", anyValueGender: .female)),
        .search(model: PNFloatPlaceholderTextFieldBehavior(placeholder: "Фамилия", anyValueGender: .female)),
        .search(model: PNFloatPlaceholderTextFieldBehavior(placeholder: "Почта", anyValueGender: .female)),
        .search(model: PNFloatPlaceholderTextFieldBehavior(placeholder: "Номер телефона",
                                                           anyValueGender: .female,
                                                           mask: ELPhoneTextMask(phoneCode: "+7",
                                                                                 inputMask: "$ (###) ### ## ##",
                                                                                 outputMask: "$##########"))),
        .tl(model: MailBehavior()),
        .tl(model: .init(placeholder: "Телефончик",
                         rightItem: .action(image: UIImage(systemName: "xmark.circle"),
                                            mode: .whileEditing,
                                            behavior: .delete),
                         mask: ELPhoneTextMask(phoneCode: "+7",
                                               inputMask: "$ (###) ### ## ##",
                                               outputMask: "$##########"))),
//        .tlMultiline(model: MailBehavior()),
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(cellType: AbstractTableViewCell<PNFloatPlaceholderTextFieldContainer>.self)
        tableView.register(cellType: AbstractTableViewCell<SKTextFieldContainer>.self)
        tableView.register(cellType: AbstractTableViewCell<PNTopPlaceholderTextFieldContainer>.self)
        tableView.register(cellType: AbstractTableViewCell<TLTextFieldContainer>.self)
        tableView.register(cellType: MultilineTextFieldTableViewCell.self)
        tableView.separatorStyle = .none
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
            case let .sk(model):
                let cell = tableView.dequeueCell(of: AbstractTableViewCell<SKTextFieldContainer>.self, for: indexPath)
                cell.set(model: model)
                return cell
            case let .skMultiline(model):
                let cell = tableView.dequeueCell(of: MultilineTextFieldTableViewCell.self, for: indexPath)
                cell.set(model: model)
                return cell
            case let .search(model):
                let cell = tableView.dequeueCell(of: AbstractTableViewCell<PNFloatPlaceholderTextFieldContainer>.self, for: indexPath)
                cell.set(model: model)
                return cell
            case let .tl(model):
                let cell = tableView.dequeueCell(of: AbstractTableViewCell<TLTextFieldContainer>.self, for: indexPath)
                cell.set(model: model)
                return cell
//            case let .tlMultiline(model):
//                let cell = tableView.dequeueCell(of: MultilineTextFieldTableViewCell.self, for: indexPath)
//                cell.set(model: model)
//                return cell
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
