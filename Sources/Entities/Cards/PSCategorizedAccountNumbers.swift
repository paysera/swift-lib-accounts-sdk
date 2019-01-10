import Foundation
import ObjectMapper

public class PSCategorizedAccountNumbers: Mappable {
    public var category: String
    public var items: [String]
    
    required public init?(map: Map) {
        do {
            category = try map.value("category")
            items = try map.value("items")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {
        category    <- map["category"]
        items       <- map["items"]
    }
}
