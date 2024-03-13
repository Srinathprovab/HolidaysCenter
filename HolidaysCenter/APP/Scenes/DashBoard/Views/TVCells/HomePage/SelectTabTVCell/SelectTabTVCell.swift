//
//  SelectTabTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

protocol SelectTabTVCellDelegate {
    func didTapOnDashboardTab(cell:SelectTabTVCell)
    func didTapOnMenuBtn(cell:SelectTabTVCell)
    func didTapOnLaungageBtn(cell:SelectTabTVCell)
}


class SelectTabTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var haiImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var tabscv: UICollectionView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var langImg: UIImageView!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var currencylbl: UILabel!
    
    var tabNames = ["Hotel","Flight","Cruise","Holidays"]
    var tabImages = ["htab2","htab1","htab3","htab4"]
    var delegate:SelectTabTVCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(selectedCurrency), name: NSNotification.Name("selectedCurrency"), object: nil)
        
    }
    
    @objc func selectedCurrency() {
        setuplabels(lbl: currencylbl, text: defaults.string(forKey: UserDefaultsKeys.selectedCurrencyType) ?? "KWD", textcolor: .BtnTitleColor, font: .OpenSansMedium(size: 14), align: .left)
        
        langImg.sd_setImage(with: URL(string: defaults.string(forKey: UserDefaultsKeys.selectedCurrencyImg) ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))

        
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .AppBackgroundColor
        langImg.image = UIImage(named: "lang")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        setuplabels(lbl: currencylbl, text: defaults.string(forKey: UserDefaultsKeys.selectedCurrencyType) ?? "KWD", textcolor: .BtnTitleColor, font: .OswaldSemiBold(size: 14), align: .left)
        langImg.sd_setImage(with: URL(string: defaults.string(forKey: UserDefaultsKeys.selectedCurrencyImg) ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
       
//        titlelbl.textColor = .WhiteColor
//        titlelbl.font = .LatoRegular(size: 24)
//        setuplabels(lbl: titlelbl, text: "Book Domestic and International Flights Tiockets", textcolor: .BtnTitleColor, font: .OpenSansBold(size: 20), align: .left)
        
        
        langBtn.setTitle("", for: .normal)
        menuBtn.setTitle("", for: .normal)
        setupCV()
    }
    
    
    
    func setupCV() {
        holderView.backgroundColor = .AppBackgroundColor
        let nib = UINib(nibName: "SelectTabCVCell", bundle: nil)
        tabscv.register(nib, forCellWithReuseIdentifier: "cell")
        tabscv.delegate = self
        tabscv.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 70)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tabscv.collectionViewLayout = layout
        tabscv.backgroundColor = .clear
        tabscv.layer.cornerRadius = 4
        tabscv.clipsToBounds = true
        tabscv.showsVerticalScrollIndicator = false
        tabscv.isScrollEnabled = false
        tabscv.bounces = false
    }
    
    
    
    @IBAction func didTapOnMenuBtn(_ sender: Any) {
        delegate?.didTapOnMenuBtn(cell: self)
    }
    
    
    @IBAction func didTapOnLaungageBtn(_ sender: Any) {
        delegate?.didTapOnLaungageBtn(cell: self)
    }
    
    
}


extension SelectTabTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SelectTabCVCell {
            cell.tabImg.image = UIImage(named: tabImages[indexPath.row])
            cell.tabtitle = tabNames[indexPath.row]
            cell.titlelbl.text = tabNames[indexPath.row]
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectTabCVCell {
            defaults.set(cell.tabtitle , forKey: UserDefaultsKeys.tabselect)
            delegate?.didTapOnDashboardTab(cell: self)
        }
    }

    
}

