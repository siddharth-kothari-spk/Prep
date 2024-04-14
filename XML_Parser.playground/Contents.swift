import Foundation

class XMLParsing: NSObject {
    
    var productInfo: [String] = []
    var currentElement = ""
    var attributes: [String: String] = [:]
    
    func parseProductInformation(from file: String) async throws -> [String] {
      guard let url = Bundle.main.url(forResource: file, withExtension: "xml") else {
        throw NSError(domain: "XML file not found", code: 1, userInfo: nil)
      }
      guard let parser = XMLParser(contentsOf: url) else {
        throw NSError(domain: "Error creating XML parser", code: 2, userInfo: nil)
      }
      parser.delegate = self
      parser.parse()
      
      return productInfo
    }
}


extension XMLParsing: XMLParserDelegate {
    
  func parser(_ parser: XMLParser,
              didStartElement elementName: String,
              namespaceURI: String?,
              qualifiedName qName: String?,
              attributes attributeDict: [String : String]) {
      
//      print("elementName: \(elementName), namespaceURI: \(String(describing: namespaceURI)), qName: \(String(describing: qName)), attributeDict: \(attributeDict)")
    currentElement = elementName
    attributes = attributeDict
      
      guard let productName = attributeDict["name"], let productPrice = attributeDict["price"] else { return }
      
      currentElement = productName
      productInfo.append("Product: \(productName), Price: \(Locale.current.currency?.identifier ?? "USD") \(productPrice)")
      
  }
  
  func parser(_ parser: XMLParser, 
              foundCharacters string: String) {
   // if currentElement == "name" || currentElement == "price" {
      //productInfo.append("\(currentElement.capitalized): \(string)")
   // }
      
  }
    
}


let xmlParser = XMLParsing()

do {
    let result = try await xmlParser.parseProductInformation(from: "products")
    print(result)
}
catch (let error) {
    print("error: \(error.localizedDescription)")
}

