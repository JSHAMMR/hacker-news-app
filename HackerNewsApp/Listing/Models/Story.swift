//
//  Story.swift
//  HackerNewsApp
//
//  Created by Gamil Ali Qaid Shamar on 08/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import Foundation

// MARK: - Story
public class Story: Codable {
    var by: String?
    var descendants, id: Int?
    var kids: [Int]?
    var score: Int?
    var time: Int?
    var text,title, type: String?
    var url: String?

    init(by: String?, descendants: Int?, id: Int?, kids: [Int]?, score: Int?, text: String?, time: Int?, title: String?, type: String?, url: String?) {
        self.by = by
        self.descendants = descendants
        self.id = id
        self.kids = kids
        self.score = score
        self.text = text
        self.time = time
        self.title = title
        self.type = type
        self.url = url
    }
}

// MARK: Story convenience initializers and mutators

extension Story {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Story.self, from: data)
        self.init(by: me.by, descendants: me.descendants, id: me.id, kids: me.kids, score: me.score,text: me.text, time: me.time, title: me.title, type: me.type, url: me.url)
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
        descendants: Int?? = nil,
        id: Int?? = nil,
        kids: [Int]?? = nil,
        score: Int?? = nil,
        text: String?? = nil,
        time: Int?? = nil,
        title: String?? = nil,
        type: String?? = nil,
        url: String?? = nil
    ) -> Story {
        return Story(
            by: by ?? self.by,
            descendants: descendants ?? self.descendants,
            id: id ?? self.id,
            kids: kids ?? self.kids,
            score: score ?? self.score,
            text: text ?? self.text,
            time: time ?? self.time,
            title: title ?? self.title,
            type: type ?? self.type,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


