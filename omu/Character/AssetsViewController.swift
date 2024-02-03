import UIKit

class AssetsViewController: UIViewController, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    var assets: [Asset] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAssets()
    }

    func fetchAssets() {
        NetworkingManager().fetchClothingAssets(appId: "65be6caee6b71dc15bedbfd4") { [weak self] fetchedAssets in
            DispatchQueue.main.async {
                self?.assets = fetchedAssets ?? []
                self?.collectionView.reloadData()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssetCollectionViewCell", for: indexPath) as? AssetCollectionViewCell else {
            return UICollectionViewCell()
        }
        let asset = assets[indexPath.row]
        cell.configure(with: asset)
        return cell
    }
    
    
}
