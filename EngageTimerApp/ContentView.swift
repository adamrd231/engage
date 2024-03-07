//
//  ContentView.swift
//  EngageTimerApp
//
//  Created by Adam Reed on 3/6/24.
//

import SwiftUI
import SwiftData

struct StopwatchFormatView: View {
    let minutes: Int
    let seconds: Int
    var body: some View {
        if minutes < 10 {
            if seconds < 10 {
                Text("0\(minutes): 0\(seconds)")
            } else {
                Text("0\(minutes): \(seconds)")
            }
           
        } else {
            if seconds < 10 {
                Text("\(minutes): 0\(seconds)")
            } else {
                Text("\(minutes): \(seconds)")
            }
            
        }
    }
}

struct TimeSelectionView: View {
    let title: String
    @Binding var minutes: Int
    @Binding var seconds: Int
    
    var body: some View {
        VStack(alignment: .leading) {
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
    @State var isUpdatingTime: Bool = false
    @State var isUpdatingRest: Bool = false
    
    var body: some View {
        NavigationSplitView {
            List {
                
                Section {
                    DisclosureGroup(isExpanded: $isUpdatingTime) {
                        TimeSelectionView(title: "Time in Round", minutes: $roundMinutes, seconds: $roundSeconds)
                    } label: {
                        HStack {
                            Image(systemName: "timer")
                            Text("Time in Round")
                            Spacer()
                            StopwatchFormatView(minutes: roundMinutes, seconds: roundSeconds)
                        }
                    }
                    DisclosureGroup(isExpanded: $isUpdatingRest) {
                        TimeSelectionView(title: "Time in Round", minutes: $restMinutes, seconds: $restSeconds)
                    } label: {
                        HStack {
                            Image(systemName: "clock.arrow.circlepath")
                            Text("Rest time")
                            Spacer()
                            StopwatchFormatView(minutes: restMinutes, seconds: restSeconds)
                        }
                    }
                    HStack {
                        Text("# of rounds")
                        Spacer()
                        Picker("", selection: $rounds) {
                            ForEach(0..<25) { number in
                                Text(number, format: .number)
                            }
                        }
                    }
                
                    HStack {
                        Text("Sound")
                        Spacer()
                        Text("Clap >")
                    }
                }
                
                HStack {
                    Button {
                        // TODO: Bring to another page, start timer
                    } label: {
                        ZStack {
                            Capsule()
                                .foregroundStyle(.green)
                                .opacity(0.3)
                            Text("Start")
                                .padding(.vertical)
                                .foregroundStyle(.green)
                                .fontWeight(.bold)
                        }
                    }
                }
                .listRowBackground(Color.clear)
                
                Section(header: Text("Timers")) {
                    ForEach(engageTimer, id: \.id) { timer in
                        VStack(alignment: .leading) {
                            Text("Name of timer")
                                .font(.caption)
                            HStack {
                                Text("Time in round")
                                Spacer()
                                Text(timer.time, format: .number)
                            }
                            HStack {
                                Text("Rest time")
                                Spacer()
                                Text(timer.restBetweenRounds, format: .number)
                            }
                        }
                    }
                }
            }

#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
            }
            .navigationTitle("Engage Timer")
        } detail: {
            Text("Select an item")
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: EngageTimer.self, inMemory: true)

}
