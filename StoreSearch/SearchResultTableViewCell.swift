//
//  SearchResultTableViewCell.swift
//  StoreSearch
//
//  Created by Aleksandr Ataev on 15.06.2021.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    var downloadTask: URLSessionDownloadTask?
    
    @IBOutlet var artworkImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView(frame: .zero)
        selectedView.backgroundColor = UIColor(named: "SearchBar")?.withAlphaComponent(0.5)
        selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    //MARK: - Helper Methods
    func configure(for result: SearchResults) {
        nameLabel.text = result.name
        if result.artist.isEmpty {
            artistNameLabel.text = "Unknown"
        } else {
            artistNameLabel.text = String(format: "%@ (%@)", result.artist, result.type)
        }
        artworkImageView.image = UIImage(systemName: "square")
        if let smallURL = URL(string: result.imageSmall) {
            downloadTask = artworkImageView.loadImage(url: smallURL)
        }
    }
}
