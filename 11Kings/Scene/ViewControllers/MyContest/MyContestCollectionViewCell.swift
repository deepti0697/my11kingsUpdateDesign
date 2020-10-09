

import UIKit

class MyContestCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nodataLabel2: UILabel!
    @IBOutlet weak var noDataImageView: UIImageView!
    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var aNoDataLabel: UILabel!
    var refreshControl = UIRefreshControl()
    var selectedContest: ((MyContestLiveLeagues, HomeType) -> Void) = { _, _ in }
    var contestData = [MyContestLiveLeagues]() {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    var didSelectClousure: ((Int) -> Void) = { _ in }
    var homeType: HomeType = .upcomming

    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        addPullToRefresh()
    }
    func addPullToRefresh() {
               refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
               refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
               aTableView.refreshControl = refreshControl
           }
           
           @objc func refreshData(sender:AnyObject) {
             
    //          getMyContest()
    //           setNoDataLabel()
               aTableView.reloadData()
               self.refreshControl.endRefreshing()
           }
    @objc private func refreshWeatherData(_ sender: Any) {
        aTableView.reloadDataInMainQueue()
    }
    
    fileprivate func registerCell() {
        aTableView.register(UINib(nibName: MyContestTVCell.identifier(), bundle: nil), forCellReuseIdentifier: MyContestTVCell.identifier())
    }
    
    func showNoDataLabel(show: Bool, text: String,image:UIImage) {
        aNoDataLabel.isHidden = !show
         nodataLabel2.isHidden = !show
        if nodataLabel2.isHidden {
             nodataLabel2.text = ""
        }
        else {
            nodataLabel2.text = "Join Contests for any of the upcoming matches"
        }
       
        aNoDataLabel.text = text
        noDataImageView.isHidden = !show
        noDataImageView.image = image
    }
   
}

extension MyContestCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contestData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  MyContestTVCell.identifier(), for: indexPath) as! MyContestTVCell
        cell.homeType = homeType
        if contestData.count > 0 {
        cell.configureMyContestCell(data: contestData[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedContest(contestData[indexPath.row], homeType)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kMyContestTVCellHeight
    }
}
