//
//  ViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import UIKit

class NoteViewController: UIViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    
    //    MARK: - Property
    
    var FireAPI = APIManager.shared
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.delegate = self
        notesTableView.dataSource = self
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: view.center.x, y: view.center.y, width: 10.0, height: 10.0))
        
//        MARK: Creating notes
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("LoadingNotes"), object: nil, queue: nil) { _ in
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("NotesLoaded"), object: nil, queue: nil) { _ in
            self.notesTableView.reloadData()
            activityIndicator.stopAnimating()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("SignOut"), object: nil, queue: nil) { _ in
            self.notesTableView.reloadData()
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        if selectedIndex != -1{
            detailVC.document = FireAPI.getAllNotes()[selectedIndex]
        }
    }
    
    @IBAction func addNoteButtonAction(_ sender: Any) {
        selectedIndex = -1
        performSegue(withIdentifier: "detailVCSegue", sender: nil)
    }
}


//MARK: - UITableView DataSource

extension NoteViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FireAPI.getAllNotes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        
        cell.headLabel.text = FireAPI.getAllNotes()[indexPath.row].text
        
        var bodyText = ""
        var newline = false
        var ind = 0
        
        for text in FireAPI.getAllNotes()[indexPath.row].text{
            if newline == true{
                bodyText.append(text)
            }
            if text.isNewline{
                newline = true
                ind += 1
            }
            if ind == 15{
                break
            }
        }
        cell.bodyLabel.text = bodyText
        return cell
    }
    
    //MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedIndex = indexPath.row
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            FireAPI.deleteDocument(id: FireAPI.getAllNotes()[indexPath.row].id)
            notesTableView.reloadData()
        }
    }
 
}
