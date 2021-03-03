import ObjectMapper

public class PSCategorizedAccountNumbers: Mappable {
    public let category: String
    public let items: [String]
    
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
        if map.mappingType == .toJSON {
            var category = self.category
            var items = self.items
            category    <- map["category"]
            items       <- map["items"]
        }
    }
}
