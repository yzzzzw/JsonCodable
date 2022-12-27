# JsonCodable
Swift基于Codable，模型和字典，字典数组和模型数组之间的转换。

Usage
---

```
struct Teacher : Codable{
    
    var name: String
    var className: String
    var courceCycle : Int
    var personInfo: PersonInfo
    
    enum CodingKeys : String, CodingKey {
        case name
        case className = "class_name"
        case courceCycle
        case personInfo
    }
    
    struct PersonInfo: Codable {
        var age: Int
        var height: Double
    }
}

let jsonString = """
[{
    "name": "Koly",
    "class_name": "Swift",
    "courceCycle": 10,
    "personInfo": {
        "age": 18,
        "height": 1.85
     }
}]
"""

let models = try YZWJsonExtension.decode(type: [Teacher].self, object: jsonString.data(using: .utf8))
print(models as Any)

let dic = YZWJsonExtension.encodeJsonObject(model: models) as? [Dictionary<String, Any>]
print(dic as Any)
```
