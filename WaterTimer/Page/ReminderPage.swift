//
//  ReminderPage.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import SwiftUI
import SheetKit

struct ReminderPage: View {
    
    @EnvironmentObject var store: Store
    
    @State var item: String = ""
    
    var dataSource: [String] {
        store.state.reminder.list ?? store.state.reminder.defauolt
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                HStack{
                    Text("Reminder List").font(.system(size: 20)).fontWeight(.bold)
                    Spacer()
                    Button(action: new) {
                        Image("new")
                    }
                }
            }.padding(.horizontal, 20)
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    ForEach(dataSource, id: \.self) { item in
    //                    Button(action: {
    //                        delete(item)
    //                    }, label: {
    //
    //                    }).foregroundColor(Color.black)
                        HStack{
                            Text(item).padding(.all, 16)
                            Spacer()
                            Button {
                                delete(item)
                            } label: {
                                Image("close").padding(.trailing, 20)
                            }

                        }.background(Color.white.cornerRadius(8)).padding(.horizontal, 20)
                    }
                }.padding(.top, 20)
            }
            Spacer()
            if store.state.ad.position == .reminder {
                HStack{
                    NativeView(model: store.state.root.adModel)
                }.padding(.horizontal, 20).frame(height: 116)
            }
            Spacer()
        }.background(Image("bg").resizable().scaledToFill().ignoresSafeArea())
    }
}

extension ReminderPage {
    func new() {
        SheetKit().present(with: .bottomSheet) {
            VStack{
                HStack{
                    Button(action: dismiss) {
                        Image("cancel")
                    }
                    Spacer()
                    Button(action: add) {
                        Image("done")
                    }
                }.padding(.all, 16)
                ReminderAlertView(date: $item).frame(height: 56 * 5)
                Spacer()
            }
        }
    }
    
    func delete(_ item: String) {
        store.dispatch(.deleteReminder(item))
    }
    
    func dismiss() {
        SheetKit().dismiss()
    }
    
    func add() {
        SheetKit().dismiss()
        store.dispatch(.addReminder(item))
    }
}

struct ReminderPage_Previews: PreviewProvider {
    static var previews: some View {
        ReminderPage().environmentObject(Store())
    }
}
