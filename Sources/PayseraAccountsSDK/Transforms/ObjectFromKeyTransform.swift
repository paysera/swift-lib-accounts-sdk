import Foundation
import ObjectMapper

class ObjectFromKeyTransform<ObjectType: BaseMappable>: TransformType {

    private let rootKeyPath: ReferenceWritableKeyPath<ObjectType, String?>
    
    init(rootKeyPath: ReferenceWritableKeyPath<ObjectType, String?>) {
        self.rootKeyPath = rootKeyPath
    }

    func transformFromJSON(_ value: Any?) -> [ObjectType]? {
        guard let json = value as? [String: Any] else {
            return nil
        }
        
        return json
            .compactMapValues { $0 as? [String: Any] }
            .compactMap { (key, jsonObject) -> ObjectType? in
                let object = Mapper<ObjectType>().map(JSON: jsonObject)
                object?[keyPath: rootKeyPath] = key
                return object
            }
    }

    func transformToJSON(_ value: [ObjectType]?) -> [String: Any]? {
        guard let objects = value else {
            return nil
        }

        let keyObjectPairs = Dictionary(grouping: objects) { $0[keyPath: rootKeyPath] }
            .compactMapValues { objects -> [String: Any]? in
                guard
                    let object = objects.first,
                    let rootKey = object[keyPath: rootKeyPath]
                else {
                    return nil
                }
                
                let objectMirror = Mirror(reflecting: object)
                guard
                    let propertyName = objectMirror
                        .children
                        .first(where: { ($0.value as? String) == rootKey })?.label
                else {
                    return nil
                }
                
                var objectJSON = object.toJSON()
                objectJSON[propertyName] = nil
                return objectJSON
            }
            .compactMap { (key, value) -> (String, Any)? in
                guard let key = key else { return nil }
                return (key, value)
            }

        return Dictionary(uniqueKeysWithValues: keyObjectPairs)
    }
}
