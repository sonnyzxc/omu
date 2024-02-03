import Foundation

struct AssetResponse: Decodable {
    let data: [Asset]
    let pagination: Pagination
}

struct Pagination: Decodable {
    let totalDocs: Int
    let limit: Int
    let totalPages: Int
    let page: Int
    let pagingCounter: Int
    let hasPrevPage: Bool
    let hasNextPage: Bool
    let prevPage: Int?
    let nextPage: Int?
}


struct Asset: Decodable {
    let id: String
    let name: String
    let iconUrl: String

    enum CodingKeys: String, CodingKey {
        case id, name, iconUrl
    }
}

// Asset struct remains the same as previously defined

class NetworkingManager {
    func fetchClothingAssets(appId: String, completion: @escaping ([Asset]?) -> Void) {
        let urlString = "https://api.readyplayer.me/v1/assets?order=name&order=-updatedAt&limit=10&page=1"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.addValue(appId, forHTTPHeaderField: "65be6caee6b71dc15bedbfd4")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let assets = try JSONDecoder().decode([Asset].self, from: data)
                completion(assets)
            } catch {
                print(error)
                completion(nil)
            }
        }

        task.resume()
    }
}
