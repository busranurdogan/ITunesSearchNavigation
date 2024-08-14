
import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var artistNameLabel : UILabel!
    @IBOutlet weak var collectionNameLabel : UILabel!
    @IBOutlet weak var trackPriceLabel : UILabel!
    @IBOutlet weak var imageObject : UIImageView!
    
    var artistName : String = ""
    var collectionName : String = ""
    var trackPrice : Double = 0.0
    var image : Any = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        artistNameLabel.text = artistName
        collectionNameLabel.text = collectionName
        trackPriceLabel.text = "\(trackPrice)"
        imageObject.image = image as? UIImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
