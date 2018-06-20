
import ObjectMapper

/// The entity class describing payment card user/client
public class PSPaymentCardClient: Mappable {
    
    public var id: Int
    public var userId: Int
    public var createdAt: TimeInterval
    public var enabled: Bool
    public var displayName: String
    public var type: String
    
    required public init?(map: Map) {
        do {
            id = try map.value("id")
            userId = try map.value("user_id")
            createdAt = try map.value("created_at")
            enabled = try map.value("enabled")
            displayName = try map.value("display_name")
            type = try map.value("type")
            
        } catch {
            print(error)
            return nil
        }
    }
    
    
    public func mapping(map: Map) {
        id              <- map["id"]
        userId          <- map["user_id"]
        createdAt       <- map["created_at"]
        enabled         <- map["enabled"]
        displayName     <- map["display_name"]
        type            <- map["type"]
    }
}
