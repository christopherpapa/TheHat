//
//  EditListView.swift
//  TheHat
//
//  Created by Christopher Papa on 11/14/20.
//

import SwiftUI

struct EditListView: View {
    @EnvironmentObject var cache: Cache
    @State private var isAddingNew = false
    @State private var newName = ""
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(cache.items) { item in
                    HStack {
                        itemRow(for: item)
                        Spacer()
                        if !item.isEligible {
                            Button(action: { cache.update(item, isEligible: true) }) {
                                Image(systemName: "arrow.clockwise.circle.fill")
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.orange)
                            }
                        } else {
                            EmptyView()
                                .frame(width: 30, height: 30)
                        }
                        Button(action: { cache.remove(item) }) {
                            Image(systemName: "minus.circle.fill")
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding([.leading, .trailing])
                
                if isAddingNew {
                    HStack {
                        TextField("New", text: $newName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: addNewItemPressed) {
                            Image(systemName: "plus.circle.fill")
                                .frame(width: 30, height: 30)
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                }
                
                Button(isAddingNew ? "Cancel" : "Add New Item",
                       action: { shouldShowEdit(!isAddingNew) })
                
                Spacer()
            }
        }
        .navigationTitle("Edit")
    }
    
    private func shouldShowEdit(_ shouldShow: Bool) {
        isAddingNew = shouldShow
    }
    
    private func addNewItemPressed() {
        cache.addItem(named: newName)
        newName = ""
    }
    private func itemRow(for item: Item) -> Text {
        if item.isEligible {
            return Text(item.name)
        } else {
            return Text(item.name).strikethrough()
        }
    }
}

struct EditListView_Previews: PreviewProvider {
    static var previews: some View {
        EditListView()
    }
}
