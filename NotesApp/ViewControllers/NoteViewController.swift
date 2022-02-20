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
    let detailVC = DetailViewController()

    
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
        let dictVC = segue.destination as! DetailViewController
        dictVC.document = documents[selectedIndex]
    }
    
    @IBAction func addNoteButtonAction(_ sender: Any) {
        FireAPI.createNewDocument()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


//MARK: - UITableView DataSource

extension NoteViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        cell.headLabel.text = documents[indexPath.row].noteHead
        cell.bodyLabel.text = documents[indexPath.row].noteBody
        return cell
    }
    
    //MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedIndex = indexPath.row
        return indexPath
    }
    
 
}
