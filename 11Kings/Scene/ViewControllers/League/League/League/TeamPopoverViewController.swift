//
//  TeamPopoverViewController.swift
//  Club11
//
//  Created by Developer on 09/06/19.
//

import UIKit

class TeamPopoverViewController: UIViewController {

    @IBOutlet private var aTableView: UITableView!
    @IBOutlet var aPopupView: UIView!
    
    var teamSelectionClousure: ((Int, Int) -> Void) = { _, _ in }
    var myTeamsData = [MyTeamResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
    }
    
    private func registerCell() {
        aTableView.register(UINib(nibName: TeamPopoverTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: TeamPopoverTableViewCell.identifier())
    }
    private func setupUI() {
        aPopupView.layer.cornerRadius = 10
        aPopupView.layer.masksToBounds = true
        aPopupView.setBorder(color: .darkGray, size: 2)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.removeFromSuperview()
    }
}

// MARK: Table View Delegate Method
extension TeamPopoverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTeamsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamPopoverTableViewCell.identifier(), for: indexPath) as! TeamPopoverTableViewCell
        cell.configureCell(team: myTeamsData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let team = myTeamsData[indexPath.row]
        if let teamID = team.teamid, let teamNum = team.teamnumber {
            teamSelectionClousure(teamID, teamNum)
        }
    }
}
