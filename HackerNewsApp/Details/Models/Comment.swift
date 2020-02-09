//
//  Comment.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 09/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import Foundation

// MARK: - Comment
public class Comment: Codable {
    var by: String?
    var id: Int?
    var kids: [Int]?
    var parent: Int?
    var text: String?
    var time: Int?
    var type: String?

    init(by: String?, id: Int?, kids: [Int]?, parent: Int?, text: String?, time: Int?, type: String?) {
        self.by = by
        self.id = id
        self.kids = kids
        self.parent = parent
        self.text = text
        self.time = time
        self.type = type
    }
}

// MARK: Comment convenience initializers and mutators

extension Comment {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Comment.self, from: data)
        self.init(by: me.by, id: me.id, kids: me.kids, parent: me.parent, text: me.text, time: me.time, type: me.type)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        by: String?? = nil,
        id: Int?? = nil,
        kids: [Int]?? = nil,
        parent: Int?? = nil,
        text: String?? = nil,
        time: Int?? = nil,
        type: String?? = nil
    ) -> Comment {
        return Comment(
            by: by ?? self.by,
            id: id ?? self.id,
            kids: kids ?? self.kids,
            parent: parent ?? self.parent,
            text: text ?? self.text,
            time: time ?? self.time,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
