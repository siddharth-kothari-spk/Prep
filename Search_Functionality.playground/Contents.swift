/*
 you've been asked to help our users search their recent transactions. Your product manager tells you that she wants to see the store names autocomplete as the user types so that the user does not need to type the entire store name.
  
 You have an api /search?term=$term which returns a list of transactions that match the input term. Allow the user to select a match, if displayed.
  
 For example: /search?term=kr might return
 [
   {
     "id": "1",
     "merchant": "Kroger",
     "amount": "$10.00"
   },
   {
     "id": "1",
     "merchant": "Kraft",
     "amount": "$2.99"
   },
   {
     "id": "1",
     "merchant": "K-Mart",
     "amount": "$169.33"
   }
 ]
  */

import Foundation
import SwiftUI

// Networking
func fetchSuggestions(searchTerm: String, completion: @escaping ([String]) -> Void) {
  guard let url = URL(string: "https://your-api.com/search?term=\(searchTerm)") else { return }
  var urlRequest = URLRequest(url: url)
  urlRequest.httpMethod = "GET"
  
  let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
    guard let data = data, error == nil else {
      completion([])
      return
    }
    
    do {
      let json = try JSONSerialization.jsonObject(with: data, options: [])
      guard let jsonArray = json as? [[String: Any]] else {
        completion([])
        return
      }
      let suggestions = jsonArray.compactMap { $0["merchant"] as? String }
      completion(suggestions)
    } catch {
      completion([])
    }
  }
  task.resume()
}


// View Model

class SearchViewModel: ObservableObject {
  @Published var searchTerm: String = ""
  @Published var suggestions: [String] = []
  
  func updateSuggestions() {
    fetchSuggestions(searchTerm: searchTerm) { suggestions in
      self.suggestions = suggestions
    }
  }
}


// Search View

struct SearchView: View {
  @ObservedObject var viewModel: SearchViewModel
  
  var body: some View {
    VStack {
      TextField("Search Stores", text: $viewModel.searchTerm)
            .onChange(of: viewModel.searchTerm, { oldValue, newValue in
                viewModel.updateSuggestions()
            })
      List {
        ForEach(viewModel.suggestions, id: \.self) { suggestion in
          Text(suggestion)
            .onTapGesture {
              // Handle user selection of a suggestion (e.g., pre-fill search term)
            }
        }
      }
    }
  }
}

