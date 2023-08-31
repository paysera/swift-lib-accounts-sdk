import ObjectMapper

public final class PSQuestionnaireConfigurationItem: Mappable {
    public var isInitial: Bool
    
    required public init?(map: Map) {
        do {
            isInitial = try map.value("is_initial_tmp")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {}
}

public final class PSQuestionnaireConfiguration: Mappable {
    
    public var id: Int!
    public var configuration: PSQuestionnaireConfigurationItem
    
    required public init?(map: Map) {
        
        do {
            configuration = try map.value("configuration")
        } catch {
            print(error)
            return nil
        }
    }
    
    public func mapping(map: Map) {}
}
