import ObjectMapper

extension Mappable {
    func mapEnumeratedJSON<T: Mappable>(json: [String : Any]?, enumeratedElementKey: String) -> [T]? {
        return json?.enumerated().compactMap ({ (currentEnumr: (offset: Int, element: (key: String, value: Any))) -> T? in

            guard var dictionary = currentEnumr.element.value as? [String: Any] else {
                return nil
            }
            dictionary[enumeratedElementKey] = currentEnumr.element.key
            return Mapper<T>().map(JSONObject: dictionary)
        })
    }
}
