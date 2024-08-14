
import Foundation

protocol ITunesViewListModelDelegate: AnyObject {
    func updateUI()
}

class ITunesListViewModel {
    
    weak var delegate: ITunesViewListModelDelegate?
    var searchResuls: [Results] = []
    
    func doSearchByTerm(term: String) {
        let url = "https://itunes.apple.com/search?term=\(term)"
        
        Network.shared.request(url: url) { [weak self] (result: Result<ITunesSearchResponse, NetworkError>) in
            switch result {
            case .success(let success):
                if success.resultCount == 0 {
                    DispatchQueue.main.async {
                        print("Sonuç bulunamadı")
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.searchResuls = success.results
                        self?.delegate?.updateUI()
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
