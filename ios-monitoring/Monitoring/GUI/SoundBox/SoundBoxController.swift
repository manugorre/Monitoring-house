//
//  SoundBoxController.swift
//  Monitoring
//
//  Created by Emmanuel Gorre on 01/05/2017.
//  Copyright © 2017 Emmanuel Gorre. All rights reserved.
//

import UIKit
import JustPeek

class SoundBoxController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, PeekingDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noSpeakerSelectedLabel: UILabel!
    @IBOutlet weak var noSpeakerAvailableLabel: UILabel!
    
    var sonosList = [Sonos]()
    var soundList = [[Sound]()]
    var authorList = [Author]()
    
    var peekController: PeekController?
    
   
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disableTableView(disable: true)
        collectionView.allowsMultipleSelection = true
        
        peekController = PeekController()
        peekController?.register(viewController: self, forPeekingWithDelegate: self, sourceView: tableView)
        
        checkTraitCollection()
        getSonosWS()
        getSoundBoxWS()
    }
    
    func getSpeakersSelected() -> String {
        var speakersSelected = ""
        
        for sonos in sonosList {
            if sonos.isSelected {
                speakersSelected += "\(sonos.id),"
            }
        }
        
        if speakersSelected != "" {
            speakersSelected.remove(at: speakersSelected.index(before: speakersSelected.endIndex))
        }
        
        return speakersSelected
    }
    
    func noSpeakerAvailable(noSpeaker: Bool) {
        self.noSpeakerAvailableLabel.isHidden = !noSpeaker
    }
    
    func disableTableView(disable: Bool) {
        self.tableView.isUserInteractionEnabled = !disable
        
        UIView.animate(withDuration: 0.2) {
            self.noSpeakerSelectedLabel.alpha = disable ? 1 : 0
            self.tableView.alpha = disable ? 0.3 : 1
        }
    }
    
    
    
    // MARK: WebServices
    
    func getSonosWS() {
        SonosWS.getSonos(successClosure: { (sonos: [Sonos]) in
            self.sonosList = sonos
            
            self.collectionView.reloadData()
            
            if self.sonosList.count < 1 {
                self.noSpeakerAvailable(noSpeaker: true)
            } else {
                self.noSpeakerAvailable(noSpeaker: false)
            }
            
        }) { (error: NSError?) in
            print(error!)
        }
    }
    
    func getSoundBoxWS() {
        SoundBoxWS.getSoundBox(successClosure: { (soundList: [[Sound]], authorList: [Author]) in
            self.soundList = soundList
            self.authorList = authorList
            self.tableView.reloadData()
        }) { (error: NSError?) in
            
        }
    }
    
    func listenSoundWS(authorIndex: Int, soundIndex: Int) {
        let speakersId = getSpeakersSelected()
        let soundId = soundList[authorIndex][soundIndex].id

        if soundId != 0 && speakersId != "" {
            SoundBoxWS.listenSound(speakerId: speakersId, soundId: soundId, successClosure: { (Void) in
                
            }) { (error: NSError?) in
                print(error)
            }
        }
    }
    
    
    
    // MARK: Update Layout For iPhone and iPad
    
    func checkTraitCollection() {
        let horizontalClass = self.traitCollection.horizontalSizeClass
        
        switch (horizontalClass) {
        case .compact :
            setCollectionViewScrollDirection(scrollDiretion: .horizontal)
            break;
        case .regular :
            setCollectionViewScrollDirection(scrollDiretion: .vertical)
            break;
        default :
            setCollectionViewScrollDirection(scrollDiretion: .vertical)
            break;
        }
    }
    
    func setCollectionViewScrollDirection(scrollDiretion: UICollectionViewScrollDirection) {
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = scrollDiretion
        }
        
        if scrollDiretion == .vertical {
            collectionView.alwaysBounceHorizontal = false
        }
    }
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {

        if newCollection.horizontalSizeClass == .compact {
            setCollectionViewScrollDirection(scrollDiretion: .horizontal)
        } else if newCollection.horizontalSizeClass == .regular {
            setCollectionViewScrollDirection(scrollDiretion: .vertical)
        }
    }
    
    

    // MARK: PeekingDelegate
    
    func peekContext(_ context: PeekContext, viewControllerForPeekingAt location: CGPoint) -> UIViewController? {
        let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: SoundDetailsPeekViewController.self)) as! SoundDetailsPeekViewController
        if let indexPath = tableView.indexPathForRow(at: location) {
            initPeekedViewController(soundDetailsPeekedViewController: viewController, withItemAtIndexPath: indexPath)
            print(context.sourceRect)
            if let cell = tableView.cellForRow(at: indexPath) {
                context.sourceRect = cell.frame
            }
            return viewController
        }
        return nil
    }
    
    func peekContext(_ context: PeekContext, commit viewController: UIViewController) {
        show(viewController, sender: self)
    }
    
    func initPeekedViewController(soundDetailsPeekedViewController: SoundDetailsPeekViewController, withItemAtIndexPath: IndexPath) {

        let author = authorList[withItemAtIndexPath.first!]
        soundDetailsPeekedViewController.author = author
        
        let sound = soundList[withItemAtIndexPath.first!][withItemAtIndexPath.last!]
        soundDetailsPeekedViewController.sound = sound
    }
    
    
    
    // MARK: CollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sonosList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SonosCollectionViewCell.self), for: indexPath) as! SonosCollectionViewCell

        cell.sonos = sonosList[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sonosList[indexPath.row].isSelected = true
        
        let selectedItems = self.collectionView.indexPathsForSelectedItems

        if (selectedItems?.count)! < 1 {
            self.disableTableView(disable: true)
        } else {
            self.disableTableView(disable: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        sonosList[indexPath.row].isSelected = false
        
        let selectedItems = self.collectionView.indexPathsForSelectedItems
        
        if (selectedItems?.count)! < 1 {
            self.disableTableView(disable: true)
        } else {
            self.disableTableView(disable: false)
        }
    }
    
    
    
    // MARK: TableViewDelegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return authorList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return authorList[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SoundTableViewCell.self), for: indexPath) as! SoundTableViewCell
        
        cell.sound = soundList[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        listenSoundWS(authorIndex: indexPath.section, soundIndex: indexPath.row)
    }
}
