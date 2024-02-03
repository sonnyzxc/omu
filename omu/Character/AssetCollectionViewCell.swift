import UIKit
import SwiftUI

class AssetCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! // Ensure this is linked to your storyboard or xib
    
    func configure(with asset: Asset) {
        loadImage(from: asset.iconUrl)
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        // Asynchronous image loading
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }.resume()
    }
}
