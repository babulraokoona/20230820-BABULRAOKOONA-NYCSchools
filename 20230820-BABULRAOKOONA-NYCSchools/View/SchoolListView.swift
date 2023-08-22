//
//  SchoolListView.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 21/08/23.
//

import SwiftUI

struct SchoolListView: View {
    
    @StateObject private var schoolVm = SchoolDataModel(client: URLSessionClient())
    
    var body: some View {
        NavigationView {
            switch schoolVm.state {
            case .loading:
                ZStack {
                    ProgressView()
                }
                .allSpacing(.center)
                .background(Color.yellow)
                .edgesIgnoringSafeArea(.all)
            case let .success(schools):
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(schools, id: \.id) { school in
                            routeToDestination(for: school)
                            Divider()
                        }
                    }
                }
                .padding(10)
                .foregroundColor(.primary)
                .navigationBarTitle(Text("Schools List"), displayMode: .large)
            default:
                ProgressView()
            }
        }
        .alert(isPresented: $schoolVm.hasError, content: {
            return Alert(
                title: Text("Error"),
                message: Text(schoolVm.state.failureReason),
                primaryButton: Alert.Button.default(Text("RETRY"), action: {
                    schoolVm.fetchSchoolData()
                }),
                secondaryButton: .cancel())
        })
        .onAppear {
            schoolVm.fetchSchoolData()
        }
    }
    
    @ViewBuilder
    private func routeToDestination(for item: SchoolDataViewModel) -> some View {
        NavigationLink(destination: SchoolDetailView(school: item)) {
            SchoolRow(schoolData: item)
                .shadow(color: Color.white, radius: 10, x: 0, y: 0)
        }
    }
}

struct SchoolListView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListView()
    }
}
