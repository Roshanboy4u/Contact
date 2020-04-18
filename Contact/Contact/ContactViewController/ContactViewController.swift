//
//  ViewController.swift
//  Contact
//
//  Created by Roshan sah on 01/04/20.
//  Copyright © 2020 Roshan sah. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    enum Section: Int {
        case a = 0, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
        func description() -> String {
            switch self {
            case .a:
                return "A"
            case .b:
                return "B"
            case .c:
                return "C"
            case .d:
                return "D"
            case .e:
                return "E"
            case .f:
                return "F"
            case .g:
                return "G"
            case .h:
                return "H"
            case .i:
                return "I"
            case .j:
                return "J"
            case .k:
                return "K"
            case .l:
                return "L"
            case .m:
                return "M"
            case .n:
                return "N"
            case .o:
                return "O"
            case .p:
                return "P"
            case .q:
                return "Q"
            case .r:
                return "R"
            case .s:
                return "S"
            case .t:
                return "T"
            case .u:
                return "U"
            case .v:
                return "V"
            case .w:
                return "W"
            case .x:
                return "X"
            case .y:
                return "Y"
            case .z:
                return "Z"
            }
        }
        
        func secondaryDescription() -> String {
            
            switch self {
            case .a:
                return "A"
            case .b:
                return "B"
            case .c:
                return "C"
            case .d:
                return "D"
            case .e:
                return "E"
            case .f:
                return "F"
            case .g:
                return "G"
            case .h:
                return "H"
            case .i:
                return "I"
            case .j:
                return "J"
            case .k:
                return "K"
            case .l:
                return "L"
            case .m:
                return "M"
            case .n:
                return "N"
            case .o:
                return "O"
            case .p:
                return "P"
            case .q:
                return "Q"
            case .r:
                return "R"
            case .s:
                return "S"
            case .t:
                return "T"
            case .u:
                return "U"
            case .v:
                return "V"
            case .w:
                return "W"
            case .x:
                return "X"
            case .y:
                return "Y"
            case .z:
                return "Z"
            }
        }
    }
    
    typealias SectionType = Section
    typealias ItemType = Mountain
    
    // Subclassing our data source to supply various UITableViewDataSource methods
    
    class DataSource: UITableViewDiffableDataSource<SectionType, ItemType> {
        
        // MARK: header/footer titles support
        
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.description()
        }
        override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.secondaryDescription()
        }
        
        // MARK: reordering support
        
        override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            guard let sourceIdentifier = itemIdentifier(for: sourceIndexPath) else { return }
            guard sourceIndexPath != destinationIndexPath else { return }
            let destinationIdentifier = itemIdentifier(for: destinationIndexPath)
            
            var snapshot = self.snapshot()

            if let destinationIdentifier = destinationIdentifier {
                if let sourceIndex = snapshot.indexOfItem(sourceIdentifier),
                   let destinationIndex = snapshot.indexOfItem(destinationIdentifier) {
                    let isAfter = destinationIndex > sourceIndex &&
                        snapshot.sectionIdentifier(containingItem: sourceIdentifier) ==
                        snapshot.sectionIdentifier(containingItem: destinationIdentifier)
                    snapshot.deleteItems([sourceIdentifier])
                    if isAfter {
                        snapshot.insertItems([sourceIdentifier], afterItem: destinationIdentifier)
                    } else {
                        snapshot.insertItems([sourceIdentifier], beforeItem: destinationIdentifier)
                    }
                }
            } else {
                let destinationSectionIdentifier = snapshot.sectionIdentifiers[destinationIndexPath.section]
                snapshot.deleteItems([sourceIdentifier])
                snapshot.appendItems([sourceIdentifier], toSection: destinationSectionIdentifier)
            }
            apply(snapshot, animatingDifferences: false)
        }
        
        // MARK: editing support

        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }

        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                if let identifierToDelete = itemIdentifier(for: indexPath) {
                    var snapshot = self.snapshot()
                    snapshot.deleteItems([identifierToDelete])
                    apply(snapshot)
                }
            }
        }
    }
    
    var dataSource: DataSource!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
        configureNavigationItem()
    }
}

extension ContactViewController {
    func configureHierarchy() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureDataSource() {
        let formatter = NumberFormatter()
        formatter.groupingSize = 3
        formatter.usesGroupingSeparator = true
        let reuseIdentifier = "reuse-id"
        
        // data source
        
        dataSource = DataSource(tableView: tableView) { (tableView, indexPath, mountain) -> UITableViewCell? in
            var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
            }
            if let cell = cell {
                cell.textLabel?.text = mountain.name
                if let formattedHeight = formatter.string(from: NSNumber(value: mountain.height)) {
                    cell.detailTextLabel?.text = "\(formattedHeight)M"
                }
                return cell
            } else {
                fatalError("failed to create a new cell")
            }
        }
        
        // initial data
        
        let snapshot = initialSnapshot()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func initialSnapshot() -> NSDiffableDataSourceSnapshot<SectionType, ItemType> {
        let mountainsController = MountainsController()
        let limit = 8
        let mountains = mountainsController.filteredMountains(limit: limit)
        let bucketList = Array(mountains[0..<limit / 2])
        let visited = Array(mountains[limit / 2..<limit])

        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        snapshot.appendSections([.a])
        snapshot.appendItems(visited)
        snapshot.appendSections([.b])
        snapshot.appendItems(bucketList)
        return snapshot
    }
    
    func configureNavigationItem() {
        navigationItem.title = "Contacts"
        let editingItem = UIBarButtonItem(title: tableView.isEditing ? "Done" : "Edit", style: .plain, target: self, action: #selector(toggleEditing))
        navigationItem.rightBarButtonItems = [editingItem]
    }
    
    @objc
    func toggleEditing() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        configureNavigationItem()
    }
}
