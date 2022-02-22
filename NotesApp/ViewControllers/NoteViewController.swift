//
//  ViewController.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 15.01.2022.
//

import UIKit

class NoteViewController: UIViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    
    var FireAPI = APIManager.shared
    var documents: [Document] = [] 
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.delegate = self
        notesTableView.dataSource = self
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: view.center.x, y: view.center.y, width: 10.0, height: 10.0))
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("LoadingNotes"), object: nil, queue: nil) { notif in
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("NotesLoaded"), object: nil, queue: nil) { notif in
            self.documents = self.FireAPI.getAllDocs()
            self.notesTableView.reloadData()
            activityIndicator.stopAnimating()
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        if selectedIndex < documents.count-1{
            detailVC.document = documents[selectedIndex]
        }
        if selectedIndex == 0{
            NotificationCenter.default.addObserver(forName: NSNotification.Name("NotesLoaded"), object: nil, queue: nil) { notif in
                detailVC.document = self.documents[0]
            }
        }
    }
    
    @IBAction func addNoteButtonAction(_ sender: Any) {
        FireAPI.createNewDocument()
        performSegue(withIdentifier: "detailVCSegue", sender: nil)
    }
}


//MARK: - UITableView DataSource

extension NoteViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        cell.headLabel.text = documents[indexPath.row].text
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
            FireAPI.deleteDocument(id: documents[indexPath.row].id)
            documents = FireAPI.getAllDocs()
            notesTableView.reloadData()
        }
    }
 
}
