//
//  DownloadBtnTVCell.swift
//  HolidaysCenter
//
//  Created by FCI on 05/08/23.
//

import UIKit

protocol DownloadBtnTVCellDelegate {
    func didTapOnDownloadPDFBtnAction(cell:DownloadBtnTVCell)
}

class DownloadBtnTVCell: TableViewCell {

    @IBOutlet weak var holderView: UIView!
    
    var delegate:DownloadBtnTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.backgroundColor = .AppBGcolor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func didTapOnDownloadPDFBtnAction(_ sender: Any) {
        delegate?.didTapOnDownloadPDFBtnAction(cell: self)
    }
    
}
