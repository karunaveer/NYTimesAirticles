//
//  AirticleDetails.swift
//  NYTimesAirticles
//
//  Created by Karunanithi on 24/07/19.
//  Copyright © 2019 Karunanithi All rights reserved.
//

import UIKit

class AirticleDetails: UITableViewCell, CellConfigurable {
    
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var byLine: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageOut: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(viewModel: RowViewModel?) {
        guard let viewModel = viewModel else { return }
                
        if let firstMedia = viewModel.media.first, firstMedia.metaData.count > 0 {
            self.imageOut.imageFromUrl(firstMedia.metaData[1].url)
        }
        

        self.titleLabel.text = viewModel.title
        self.byLine.text = viewModel.byLine
        self.contentLabel.text = viewModel.abstract
        
        setNeedsLayout()
    }
}
