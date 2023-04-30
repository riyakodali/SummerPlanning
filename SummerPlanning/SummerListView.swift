//
//  SummerListView.swift
//  SummerPlanning
//
//  Created by Riya Kodali on 4/26/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift



struct SummerListView: View {
    @State private var sheetIsPresented = false
    @EnvironmentObject var summerToDosVM: SummerToDosViewModel
    @Environment(\.dismiss) private var dismiss
    @FirestoreQuery(collectionPath: "summerToDos") var summerToDos: [SummerToDo]
    
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(summerToDosVM.mayToDos) { summerToDo in
                        NavigationLink {
                            DetailView(summerToDo: summerToDo)
                        } label: {
                            Text(summerToDo.item)
                        }
                        .font(.title3)
                    }
                    .onDelete { indexSetM in
                        guard let index = indexSetM.first else {return}
                        Task {
                            await summerToDosVM.deleteData(summerToDo: summerToDos[index])
                        }
                    }
                    .onMove { fromOffsetsM, toOffsetM in
                        summerToDosVM.moveMayToDo(fromOffsetsM: fromOffsetsM, toOffsetM: toOffsetM)
                    }
                } header: {
                    Text("May")
                        .bold()
                        .foregroundColor(.accentColor)
                }
                Section {
                    ForEach(summerToDosVM.juneToDos) { summerToDo in
                        NavigationLink {
                            DetailView(summerToDo: summerToDo)
                        } label: {
                            Text(summerToDo.item)
                        }
                        .font(.title3)
                    }
                    .onDelete { indexSetJn in
                        guard let index = indexSetJn.first else {return}
                        Task {
                            await summerToDosVM.deleteData(summerToDo: summerToDos[index])
                        }                    }
                    .onMove { fromOffsetsJn, toOffsetJn in
                        summerToDosVM.moveJuneToDo(fromOffsetsJn: fromOffsetsJn, toOffsetJn: toOffsetJn)
                    }
                } header: {
                    Text("June")
                        .bold()
                        .foregroundColor(.accentColor)
                    
                }
                Section {
                    ForEach(summerToDosVM.julyToDos) { summerToDo in
                        NavigationLink {
                            DetailView(summerToDo: summerToDo)
                        } label: {
                            Text(summerToDo.item)
                        }
                        .font(.title3)
                    }
                    .onDelete { indexSetJy in
                        guard let index = indexSetJy.first else {return}
                        Task {
                            await summerToDosVM.deleteData(summerToDo: summerToDos[index])
                        }
                        
                    }
                    .onMove { fromOffsetsJy, toOffsetJy in
                        summerToDosVM.moveJulyToDo(fromOffsetsJy: fromOffsetsJy, toOffsetJy: toOffsetJy)
                    }
                } header: {
                    Text("July")
                        .bold()
                        .foregroundColor(.accentColor)
                    
                }
                Section {
                    ForEach(summerToDosVM.augustToDos) { summerToDo in
                        NavigationLink {
                            DetailView(summerToDo: summerToDo)
                        } label: {
                            Text(summerToDo.item)
                        }
                        .font(.title3)
                    }
                    .onDelete { indexSetA in
                        guard let index = indexSetA.first else {return}
                        Task {
                            await summerToDosVM.deleteData(summerToDo: summerToDos[index])
                        }
                        
                    }
                    .onMove { fromOffsetsA, toOffsetA in
                        summerToDosVM.moveAugustToDo(fromOffsetsA: fromOffsetsA, toOffsetA: toOffsetA)                    }
                } header: {
                    Text("August")
                        .bold()
                        .foregroundColor(.accentColor)
                    
                }
            }
            .navigationTitle("SUMMER")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.insetGrouped)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Sign Out") {
                        do {
                            try Auth.auth().signOut()
                            print("🪵➡️ Log out successful!")
                            dismiss()
                        } catch {
                            print("😡 ERROR: Could not sign out!")
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $sheetIsPresented) {
                NavigationStack{
                    DetailView(summerToDo: SummerToDo(), newSummerToDo: true)
                }
            }
            .navigationBarBackButtonHidden()
            
        }
    }
}

struct SummerListView_Previews: PreviewProvider {
    static var previews: some View {
        SummerListView()
            .environmentObject(SummerToDosViewModel())
    }
}

