//
//  DetailsViewController.swift
//  Marvel-Challenge-2023-Rui.Sousa
//
//  Created by Rui Sousa on 13/01/2023.
//

import UIKit

enum SectionType {
    case title, overview, comics, events, stories, series
}

class DetailsViewController: UITableViewController {
    
    var characterDetails: Character!
    var sections: [SectionType] = [.title, .overview, .comics, .events, .stories, .series]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTable()
    }
    
    // MARK: - Table view data source
    func registerTable() {
        tableView.register(UINib(nibName: "CharacterTitleCell", bundle: nil), forCellReuseIdentifier: "CharacterTitleCell")
        tableView.register(UINib(nibName: "CharacterOverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterOverviewTableViewCell")
        tableView.register(UINib(nibName: "SeriesTableViewCell", bundle: nil), forCellReuseIdentifier: "SeriesTableViewCell")
        tableView.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")
        tableView.register(UINib(nibName: "ComicsTableViewCell", bundle: nil), forCellReuseIdentifier: "ComicsTableViewCell")
        tableView.register(UINib(nibName: "StoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "StoriesTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section] {
        case .overview:
            return "Overview"
        case .comics:
            return characterDetails?.comics?.available == 0 ? " " : "Comics"
        case .events:
            return characterDetails?.events?.available == 0 ? " " : "Events"
        case .stories:
            return characterDetails?.stories?.available == 0 ? " " : "Stories"
        case .series:
            return characterDetails?.series?.available == 0 ? " " : "Series"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        header.textLabel?.textColor = .black
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .title:
            return 1
        case .overview:
            return 1
        case .comics:
            return min(characterDetails?.comics?.available ?? 0, 1)
        case .events:
            return min(characterDetails?.events?.available ?? 0, 5)
        case .stories:
            return min(characterDetails?.stories?.available ?? 0, 5)
        case .series:
            return min(characterDetails?.series?.available ?? 0, 5)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch sections[indexPath.section] {
        case .title:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTitleCell",for: indexPath) as? CharacterTitleCell else { return UITableViewCell() }
            cell.characterTitle.text = characterDetails?.name
            if let thumbnailPath = characterDetails.thumbnail?.url {
                cell.characterTImg.sd_setImage(with: thumbnailPath)
            }
            return cell
        case .overview:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterOverviewTableViewCell",for: indexPath) as? CharacterOverviewTableViewCell else { return UITableViewCell() }
            // configure cell with characterDetails
            return cell
        case .comics:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsTableViewCell",for: indexPath) as? ComicsTableViewCell else { return UITableViewCell() }
            cell.characterDetails = characterDetails
            cell.comicList = characterDetails?.comics
            return cell
        case .events:
               guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell",for: indexPath) as? EventsTableViewCell else { return UITableViewCell() }
            if let events = characterDetails.events?.items?[indexPath.row] {
                cell.titleLabel.text = events.name
                if let thumbnailPath = characterDetails.thumbnail?.url {
                    cell.img.sd_setImage(with: thumbnailPath)
                }
            }
            return cell
        case .stories:
               guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoriesTableViewCell",for: indexPath) as? StoriesTableViewCell else { return UITableViewCell() }
            if let stories = characterDetails.stories?.items?[indexPath.row] {
                cell.titleLabel.text = stories.name
                if let thumbnailPath = characterDetails.thumbnail?.url {
                    cell.img.sd_setImage(with: thumbnailPath)
                }
            }
            return cell
        case .series:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SeriesTableViewCell",for: indexPath) as? SeriesTableViewCell else { return UITableViewCell() }
            if let series = characterDetails.series?.items?[indexPath.row] {
                cell.titleLabel.text = series.name
                if let thumbnailPath = characterDetails.thumbnail?.url {
                    cell.img.sd_setImage(with: thumbnailPath)
                }
            }
            return cell
        }
    }
}
