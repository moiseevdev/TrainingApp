//
//  ObtainMoya.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 09.01.2022.
//

import Foundation
import Moya

public enum ObtainMoya {
    case category
    case event
}

extension ObtainMoya: TargetType {
    public var baseURL: URL {
        URL(string: "https://moiseev.dev/api/trainingapp")!
    }

    public var path: String {
        switch self {
        case .category:
            return "/categories.json"
        case .event:
            return "/events.json"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .category:
            return .get
        case .event:
            return .get
        }
    }

    public var task: Task {
        .requestPlain
    }

    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
