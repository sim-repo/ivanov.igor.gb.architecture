import UIKit

func data(from file: String) -> Data {
    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
    let url = URL(fileURLWithPath: path1)
    let data = try! Data(contentsOf: url)
    return data
}

let data1 = data(from: "1")
let data2 = data(from: "2")
let data3 = data(from: "3")


enum SerializationError: Error {
    case err
}

struct Person {
    let name: String
    let age: Int
    let isDeveloper: Bool
}

protocol PersonParserProtocol: class {
    var next: PersonParserProtocol? { get set }
    func tryParse(data: Data) -> [Person]?
}

extension PersonParserProtocol {
    func parse(dict: Any?) throws -> [Person]? {
        var result: [Person]?
        do {
            guard let dictionary = dict as? [Dictionary<String, Any>]
            else { throw SerializationError.err }
            
            for element in dictionary {
                let age: Int = element["age"] as! Int
                let name: String = element["name"]  as! String
                let isDeveloper: Bool = element["isDeveloper"]  as! Bool
                let person = Person(name: name, age: age, isDeveloper: isDeveloper)
                if result == nil {
                    result = []
                }
                result?.append(person)
            }
        } catch {
            throw SerializationError.err
        }
        return result
    }
}


class PersonParserDict: PersonParserProtocol {
    var next: PersonParserProtocol?

    func tryParse(data: Data) -> [Person]? {
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        do {
            guard let dictionary = json as? [String: Any]
            else {
                throw SerializationError.err
            }
            for val in dictionary.values {
                let person = try parse(dict: val)
                return person
            }
        } catch let err {
            guard let next = next
            else {
                print(err)
                return nil
            }
            return next.tryParse(data: data)
        }
        return nil
    }
}


class PersonParserArr: PersonParserProtocol {
    var next: PersonParserProtocol?

    func tryParse(data: Data) -> [Person]? {
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        do {
            guard let array = json as? [Any]
            else {
                throw SerializationError.err
            }

            let person = try parse(dict: array)
            return person
            
        } catch let err {
            guard let next = next
            else {
                print(err)
                return nil
            }
            return next.tryParse(data: data)
        }
    }
}



let p1 = PersonParserDict()
let p2 = PersonParserArr()
p2.next = p1
if let persons = p2.tryParse(data: data3) {
    for p in persons {
        print(p.name)
    }
}
