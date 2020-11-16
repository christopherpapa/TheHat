//
//  ContentView.swift
//  Shared
//
//  Created by Christopher Papa on 11/13/20.
//

import SwiftUI

struct HatPickerView: View {
    @ObservedObject private var cache = Cache()
    @State private var shouldShowAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Divider()
                    
                    headerView
                        .padding()
                    
                    Divider()
                    
                    ForEach(cache.items) { item in
                        HStack {
                            self.itemRow(for: item)
                                .padding(2)
                            Spacer()
                        }
                    }
                    .padding([.leading, .trailing])

                    
                    Divider()
                    
                    Spacer()
                    
                    Button(buttonTitle, action: pickNext)
                        .padding()
                        .foregroundColor(buttonColor)
                        .background(Color.black)
                        .cornerRadius(20.0)
                    Spacer()
                }
            }
            .navigationTitle("🎩 The Hat!")
            .navigationBarItems(trailing: NavigationLink("Edit",
                                                         destination: EditListView()
                                                            .environmentObject(cache)))
            
            .alert(isPresented: $shouldShowAlert) {
                self.alert
            }
        }
    }
    
    private var buttonColor: Color {
        cache.items.filter { $0.isEligible }.isEmpty ? .red : .white
    }
    
    private func itemRow(for item: Item) -> Text {
        if item.isEligible {
            return Text(item.name)
        } else {
            return Text(item.name).strikethrough()
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Next Up:")
            if let selectedItem = cache.selectedItem {
                Text(selectedItem.name)
                    .bold()
            } else {
                Text("Please Pick")
                    .bold()
                    .foregroundColor(.red)
            }
        }
    }
    
    // MARK: - Button
    
    private var buttonTitle: String {
        cache.items.filter { $0.isEligible }.isEmpty ? "Refill Hat" : "Pick Next!"
    }
    
    private func pickNext() {
        shouldShowAlert = cache.pickNext()
    }
    
    // MARK: - Alert
    
    private var alertTitle: String {
        cache.selectedItem?.name ?? "None Selected"
    }
    
    
    private var alert: Alert {
        Alert(title: Text("Next Up!"),
              message: Text(alertTitle),
              dismissButton: .default(Text("Got it!")))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HatPickerView()
    }
}
