/*
 Used to add a single result.
 */
public struct NewResult: MutableCustomFields {

    // MARK: Properties

    public var assignedtoId: User.Id?
    public var comment: String?
    public var defects: String?
    public var elapsed: String?
    public var statusId: Status.Id?
    public var version: String?
    var customFieldsContainer = CustomFieldsContainer.empty()

    // MARK: Init

    public init(assignedtoId: User.Id? = nil, comment: String? = nil, defects: String? = nil, elapsed: String? = nil, statusId: Status.Id? = nil, version: String? = nil, customFields: JSONDictionary? = nil) {
        self.assignedtoId = assignedtoId
        self.comment = comment
        self.defects = defects
        self.elapsed = elapsed
        self.statusId = statusId
        self.version = version
        if let customFields = customFields {
            customFieldsContainer.customFields = customFields
        }
    }

}

// MARK: - Equatable

extension NewResult: Equatable {

    public static func==(lhs: NewResult, rhs: NewResult) -> Bool {
        return (lhs.assignedtoId == rhs.assignedtoId &&
            lhs.comment == rhs.comment &&
            lhs.defects == rhs.defects &&
            lhs.elapsed == rhs.elapsed &&
            lhs.statusId == rhs.statusId &&
            lhs.version == rhs.version &&
            lhs.customFieldsContainer == rhs.customFieldsContainer)
    }

}

// MARK: - Validatable

extension NewResult: Validatable {

    /*
     A result is valid if it's assigned and/or commented on and/or is given a
     status.
     */
    var isValid: Bool {
        return (assignedtoId != nil || comment != nil || statusId != nil)
    }

}

// MARK: - JSON Keys

extension NewResult {

    enum JSONKeys: JSONKey {
        case assignedtoId = "assignedto_id"
        case comment
        case defects
        case elapsed
        case statusId = "status_id"
        case version
    }

}

extension NewResult: AddRequestJSONKeys {

    var addRequestJSONKeys: [JSONKey] {
        var keys = [JSONKeys.assignedtoId.rawValue,
                    JSONKeys.comment.rawValue,
                    JSONKeys.defects.rawValue,
                    JSONKeys.elapsed.rawValue,
                    JSONKeys.statusId.rawValue,
                    JSONKeys.version.rawValue]
        customFields.forEach { item in keys.append(item.key) }
        return keys
    }

}

// MARK: - Serialization

extension NewResult: JSONSerializable {

    private var serializedProperties: JSONDictionary {
        return [JSONKeys.assignedtoId.rawValue: assignedtoId as Any,
                JSONKeys.comment.rawValue: comment as Any,
                JSONKeys.defects.rawValue: defects as Any,
                JSONKeys.elapsed.rawValue: elapsed as Any,
                JSONKeys.statusId.rawValue: statusId as Any,
                JSONKeys.version.rawValue: version as Any]
    }

    func serialized() -> JSONDictionary {
        var json = serializedProperties
        customFields.forEach { item in json[item.key] = item.value }
        return json
    }

}

extension NewResult: AddRequestJSON { }
