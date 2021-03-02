import ObjectMapper

public class PSQuestionnaire: Mappable {
    public var id: Int
    public var status: String

    required public init?(map: Map) {
        do {
            id = try map.value("id")
            status  = try map.value("status")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {}
}
