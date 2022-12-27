//
//  YZWJsonExtension.swift
//
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 bh. All rights reserved.
//

import Foundation

struct YZWJsonExtension {
    //MARK: - decode
    /// 解码入口。type传入AnyClass.self 。
    public static func decode<T>(type: T.Type, object: Any?) throws -> T? where T : Decodable {
        if let object = object, let data = YZWJsonExtension.decode(object: object) {
            return YZWJsonExtension.decode(type: type, data: data)
        }
        return nil
    }
    
    /// 将object转成data
    public static func decode(object: Any) -> Data? {
        if let data = object as? Data {
            return data
        } else if let string = object as? String {
            return string.data(using: .utf8)
        }
        return try? JSONSerialization.data(withJSONObject: object)
    }
    
    /// codable
    private static func decode<T>(type: T.Type, data: Data) -> T? where T : Decodable {
        do {
            let object = try JSONDecoder().decode(type, from: data)
            return object
        } catch {
            
            if let jsonStr = String(data: data, encoding: .utf8) {
                print(jsonStr)
            }
            
            switch error {
            case let DecodingError.typeMismatch(_, context):
                print("数据类型错误：", context.codingPath, context.debugDescription, separator: "\n\n", terminator: "\n")
            case let DecodingError.valueNotFound(_, context):
                print("找不到value：", context, separator: "\n", terminator: "\n\n")
            case let DecodingError.keyNotFound(_, context):
                print("找不到Key：", context, separator: "\n", terminator: "\n\n")
            case let DecodingError.dataCorrupted(context):
                print("Json格式错误:", context, separator: "\n", terminator: "\n\n")
            default:
                print("Decode出现未知异常")
            }
        }
        return nil
    }
    
    //MARK: - encode 编码
    /// model, models -> type类型
    public static func encodeJsonObject<T>(model: T) -> Any? where T : Encodable {
        if let data = try? JSONEncoder().encode(model) {
            return try? JSONSerialization.jsonObject(with: data)
        }
        return nil
    }
    
    /// model, models转成json data
    public static func encodeData<T>(model: T) -> Data? where T: Encodable {
        return try? JSONEncoder().encode(model)
    }
}
