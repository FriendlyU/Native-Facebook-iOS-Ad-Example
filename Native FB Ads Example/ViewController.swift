//
//  ViewController.swift
//  Native FB Ads Example
//
//  Created by Henry Saniuk on 2/5/17.
//  Copyright © 2017 Henry Saniuk. All rights reserved.
//

import UIKit
import FBAudienceNetwork

class ViewController: UITableViewController, FBNativeAdDelegate, FBNativeAdsManagerDelegate {
    
    let tableData = ["Sample 1","Sample 2","Sample 3", "Sample 4", "Sample 5","Sample 6","Sample 7", "Sample 8"]
    let adRowStep = 2
    var adsManager: FBNativeAdsManager!
    var adsCellProvider: FBNativeAdTableViewCellProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 250.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorColor = UIColor.clear
        self.view.backgroundColor = UIColor.lightGray
        adsManager = FBNativeAdsManager(placementID: "PUT_ID_HERE", forNumAdsRequested: 5)
        adsManager.delegate = self
        adsManager.loadAds()
        self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if adsCellProvider != nil {
            return Int(adsCellProvider.adjustCount(UInt(tableData.count), forStride: UInt(adRowStep)))
        } else {
            return tableData.count
        }
    }
    
    override func tableView(_ tableView: UITableView?, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if adsCellProvider != nil && adsCellProvider.isAdCell(at: indexPath, forStride: UInt(adRowStep)) {
            // Show an ad
            let ad = adsManager.nextNativeAd
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "ad", for: indexPath) as! AdTableCell
            cell.message.text = ad?.body
            cell.title.text = ad?.title
            cell.callToActionButton.setTitle(ad?.callToAction, for: .normal)
            if let pic = ad?.coverImage {
                cell.postImage.imageFromServerURL(urlString: pic.url.absoluteString)
            }
            ad?.registerView(forInteraction: cell, with: self)
            return cell
        } else {
            // Return a normal cell
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
            cell.textLabel?.text = self.tableData[indexPath.row - Int(indexPath.row / adRowStep)]
            return cell
        }
    }
    
    func nativeAdsLoaded() {
        adsCellProvider = FBNativeAdTableViewCellProvider(manager: adsManager, for: FBNativeAdViewType.genericHeight120)
        adsCellProvider.delegate = self
        
        if tableView != nil {
            tableView.reloadData()
        }
    }
    
    func nativeAdDidLoad(_ nativeAd: FBNativeAd) {
        print("Ad loaded")
    }
    
    func nativeAdDidClick(_ nativeAd: FBNativeAd) {
        print("Ad tapped: \(nativeAd.title)")
    }
    
    public func nativeAdsFailedToLoadWithError(_ error: Error) {
        print("Ad failed to load with error: \(error)")
    }
    
    func nativeAdWillLogImpression(_ nativeAd: FBNativeAd) {
        print("Native ad impression is being captured.")
    }
    
}
