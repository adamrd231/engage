//
//  ContentView.swift
//  EngageTimerApp
//
//  Created by Adam Reed on 3/6/24.
//

import SwiftUI
import SwiftData

struct TimeSelectionView: View {
    let title: String
    @Binding var minutes: Int
    @Binding var seconds: Int
    @State var isOpen: Bool = false
    
    var body: some View {
        if isOpen {
            VStack(alignment: .leading) {
                HStack {
                    Text("Time in Round")
                    Spacer()
                    Text("\(minutes): \(seconds)")
                }
                .onTapGesture(perform: {
                    withAnimation {
                        isOpen.toggle()
                    }
                })
      
                
                HStack {
                    Picker("", selection: $minutes) {
                        ForEach(0..<60, id: \.self) { minutes in
                            Text(minutes, format: .number)
                                .tag(minutes)
                        }
                    }
                    .pickerStyle(.wheel)
                    Text("min")
                    Picker("", selection: $seconds) {
                        ForEach(0..<60, id: \.self) { seconds in
                            HStack {
                                Text(seconds, format: .number)
                                    .tag(seconds)
                            }
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    Text("sec")
                }
            }
        } else {
            HStack {
                Text("Time in Round")
                Spacer()
                Button("\(minutes): \(seconds)") {
                    withAnimation {
                        isOpen.toggle()
                    }
                }
            }
            
        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var engageTimer: [EngageTimer]

    @State var roundMinutes: Int = 0
    @State var roundSeconds: Int = 0
    
    @State var restMinutes: Int = 0
    @State var restSeconds: Int = 0
    @State var rounds: Int = 5
    
    var body: some View {
        NavigationSplitView {
            List {
                Section {
                    HStack {
                        Text("# of rounds")
                        Spacer()
                        Picker("", selection: $rounds) {
                            ForEach(0..<25) { number in
                                Text(number, format: .number)
                            }
                        }
                    }
                    TimeSelectionView(title: "Time in Round", minutes: $roundMinutes, seconds: $roundSeconds)
                    HStack {
                        Text("Rest")
                        Spacer()
                        Text("Clap >")
                    }
                    HStack {
                        Text("Sound")
                        Spacer()
                        Text("Clap >")
                    }
                }
                
                HStack {
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundStyle(.red)
                                .opacity(0.3)
                            Text("Reset")
                                .foregroundStyle(.red)
                                .fontWeight(.bold)
                        }
                    }
                    .frame(width: 100, height: 100)
                    Spacer()
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundStyle(.green)
                                .opacity(0.3)
                            Text("Start")
                                .foregroundStyle(.green)
                                .fontWeight(.bold)
                        }
                    }
                    .frame(width: 100, height: 100)
                }
                .listRowBackground(Color.clear)
                
                Section(header: Text("Timers")) {
                    Text("Hello")
                    ForEach(engageTimer, id: \.id) { timer in
                        Text(timer.time, format: .number)
                    }
                }
                .listStyle(SidebarListStyle())
            }
            

#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add timer") {
                        let newTimer = EngageTimer(
                            rounds: 5,
                            time: 10,
                            restBetweenRounds: 3,
                            sound: "",
                            lowBoundaryInterval: 5,
                            highBoundaryInterval: 20
                        )
                        modelContext.insert(newTimer)
                    }
                }
#endif
            }
            .navigationTitle("Create Timer")
        } detail: {
            Text("Select an item")
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: EngageTimer.self, inMemory: true)
        .preferredColorScheme(.dark)
}
