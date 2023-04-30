//
//  DetailView.swift
//  SummerPlanning
//
//  Created by Riya Kodali on 4/26/23.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var summerToDosVM: SummerToDosViewModel
    @State var summerToDo: SummerToDo
    var newSummerToDo = false    
    
    var body: some View {
        List {
            TextField("Enter Summer Plan Here", text: $summerToDo.item)
                .font(.title)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                .listRowSeparator(.hidden)
                .foregroundColor(.accentColor)
            
            HStack {
                Text("Month:")
                    .bold()
                    .foregroundColor(.accentColor)
                Spacer()
                Picker("", selection: $summerToDo.month) {
                    ForEach(Month.allCases, id: \.self) { month in
                        Text(month.rawValue.capitalized)
                            .tag(month.rawValue)
                    }
                }
            }
            .listRowSeparator(.hidden)

            
            HStack {
                Text("Plan Type:")
                    .bold()
                    .foregroundColor(.accentColor)
                Spacer()
                Picker("", selection: $summerToDo.planType) {
                    ForEach(PlanType.allCases, id: \.self) { planType in
                        Text(planType.rawValue.capitalized)
                            .tag(planType.rawValue)
                    }
                }
            }


            
            DatePicker("Date", selection: $summerToDo.dueDate)
                .listRowSeparator(.hidden)
                .padding(.bottom)
                .bold()
                .foregroundColor(.accentColor)

            
            Text("Notes:")
                .padding(.top)
                .bold()
                .foregroundColor(.accentColor)

            
            TextField("Notes", text: $summerToDo.notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .listRowSeparator(.hidden)
            
            Toggle("Completed:", isOn: $summerToDo.isCompleted)
                .padding(.top)
                .listRowSeparator(.hidden)
                .bold()
                .foregroundColor(.accentColor)
            
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if newSummerToDo && summerToDo.month == "May" {
                        summerToDosVM.saveSummerToDoMay(mayToDo: summerToDo)
                        dismiss()
                    } else if newSummerToDo && summerToDo.month == "June" {
                        summerToDosVM.saveSummerToDoJune(juneToDo: summerToDo)
                        dismiss()
                    } else if newSummerToDo && summerToDo.month == "July" {
                        summerToDosVM.saveSummerToDoJuly(julyToDo: summerToDo)
                        dismiss()
                    } else if newSummerToDo && summerToDo.month == "August" {
                        summerToDosVM.saveSummerToDoAugust(augustToDo: summerToDo)
                        dismiss()
                    } else if let index = summerToDosVM.mayToDos.firstIndex(where: {$0.id == summerToDo.id}) {
                        summerToDosVM.mayToDos[index] = summerToDo
                        dismiss()
                    } else if let index = summerToDosVM.juneToDos.firstIndex(where: {$0.id == summerToDo.id}) {
                        summerToDosVM.juneToDos[index] = summerToDo
                        dismiss()
                    } else if let index = summerToDosVM.julyToDos.firstIndex(where: {$0.id == summerToDo.id}) {
                        summerToDosVM.julyToDos[index] = summerToDo
                        dismiss()
                    } else if let index = summerToDosVM.augustToDos.firstIndex(where: {$0.id == summerToDo.id}) {
                        summerToDosVM.augustToDos[index] = summerToDo
                        dismiss()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            DetailView(summerToDo: SummerToDo())
                .environmentObject(SummerToDosViewModel())
        }
    }
}


