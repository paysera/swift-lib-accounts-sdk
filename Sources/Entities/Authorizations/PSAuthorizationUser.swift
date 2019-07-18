import ObjectMapper

public class PSAuthorizationUser: Mappable {
    
    public var userId: Int
    public var displayName: String
    
    required public init?(map: Map) {
        do {
            userId = try map.value("user_id")
            displayName = try map.value("display_name")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {
        userId          <- map["user_id"]
        displayName     <- map["display_name"]
    }
}
