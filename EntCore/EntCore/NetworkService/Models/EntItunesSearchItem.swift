//
//  EntItunesSearchItem.swift
//  EntCore
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation

public struct EntItunesSearchItem: Codable {
    enum ModelDecoderError: Error {
        case invalidReleaseDate
    }
    
    public let artworkUrl100: String
    public let collectionPrice: Double?
    public let trackPrice: Double?
    public let price: Double?
    public let collectionName: String?
    public let trackName: String?
    public let currency: String
    public let releaseDate: Date
    
    enum CodingKeys: String, CodingKey {
        case artworkUrl100, collectionPrice, trackPrice, price, currency, collectionName, trackName, releaseDate
    }
    
    public func getFormattedPrice() -> String {
        let locale = NSLocale(localeIdentifier: currency)
        let currencySign = locale.displayName(forKey: NSLocale.Key.currencySymbol, value: currency)
        if collectionPrice == 0.0 || trackPrice == 0.0 || price == 0.0 {
            return "Free"
        } else {
            return "\(collectionPrice ?? trackPrice ?? price ?? 0) \(currencySign ?? "")"
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.artworkUrl100 = try container.decode(String.self, forKey: .artworkUrl100)
        self.collectionName = try? container.decode(String.self, forKey: .collectionName)
        self.trackName = try? container.decode(String.self, forKey: .trackName)
        self.collectionPrice = try? container.decode(Double.self, forKey: .collectionPrice)
        self.trackPrice = try? container.decode(Double.self, forKey: .trackPrice)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.price = try? container.decode(Double.self, forKey: .price)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let releaseDate = formatter.date(from: try container.decode(String.self, forKey: .releaseDate))
        guard let releaseDate = releaseDate else {
            throw ModelDecoderError.invalidReleaseDate
        }
        self.releaseDate = releaseDate
    }
    
}
