
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchTextField : UITextField!
    @IBOutlet weak var tableView : UITableView!
        
    let viewModel = ITunesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        viewModel.delegate = self
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        viewModel.doSearchByTerm(term: searchTextField.text ?? "")
        
    }

    let cellIdentifier = "ItemCellIdentifier"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        
        let result = viewModel.searchResuls[indexPath.row]
        cell.artistNameLabel.text = result.artistName
        cell.collectionNameLabel.text = result.collectionName
        cell.trackPriceLabel.text = String(result.trackPrice ?? 0.0)
        ImageDownloader.downloadImage(result.artworkUrl100 ?? "") {
            image, urlString in
            if image != nil {
                DispatchQueue.main.async {
                    
                    cell.imageObject.image = image
                    cell.imageObject.roundedImage()
                    
                }
                
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResuls.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selected = viewModel.searchResuls[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController

        detailVC.artistName = selected.artistName ?? ""
        detailVC.collectionName = selected.collectionName ?? ""
        detailVC.trackPrice = selected.trackPrice ?? 0.0
        
        ImageDownloader.downloadImage(selected.artworkUrl100 ?? "") {
            image, urlString in
            if image != nil {
                DispatchQueue.main.async {
                    detailVC.imageObject.image = image
                    detailVC.imageObject.roundedImage()
                }
            }
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = (self.frame.size.width) / 2;
        self.clipsToBounds = true
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.white.cgColor
    }
}

extension ViewController : ITunesViewListModelDelegate {
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}
