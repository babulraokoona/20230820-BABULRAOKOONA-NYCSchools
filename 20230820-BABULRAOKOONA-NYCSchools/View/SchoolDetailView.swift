//
//  SchoolDetailView.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 21/08/23.
//

import SwiftUI

struct SchoolDetailView: View {
    
    @StateObject private var schoolVm = SchoolDetailViewModel(client: URLSessionClient())
    
    let school: SchoolDataViewModel
    
    var body: some View {
        VStack {
            if schoolVm.schoolSat == nil {
                ContentUnavailable()
            } else {
                DetailView()
            }
        }
        .alert(isPresented: $schoolVm.hasError, content: {
            return Alert(
                title: Text("Error"),
                message: Text(schoolVm.errorReason),
                primaryButton: Alert.Button.default(Text("RETRY"), action: {
                    schoolVm.fetchSchoolStats(by: school.id)
                }),
                secondaryButton: .cancel())
        })
        .navigationBarTitle(Text("SAT Scores"), displayMode: .inline)
        .onAppear {
            schoolVm.fetchSchoolStats(by: school.id)
        }
    }
    
    // MARK: - Private
    
    @ViewBuilder
    private func DetailView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("School name :")
                Spacer()
                Text(schoolVm.schoolSat?.schoolName ?? "")
            }
            
            HStack {
                Text("SAT test takers :")
                Spacer()
                Text(schoolVm.schoolSat?.satTestTakersCount ?? "")
            }
            
            HStack {
                Text("Critical reading avg Score :")
                Spacer()
                Text(schoolVm.schoolSat?.satCriticalReadingAvgScore ?? "")
            }
            
            HStack {
                Text("Math avg Score :")
                Spacer()
                Text(schoolVm.schoolSat?.satMathAvgScore ?? "")
            }
            
            HStack {
                Text("Writing avg Score :")
                Spacer()
                Text(schoolVm.schoolSat?.satWritingAvgScore ?? "")
            }
        }
        .shadow(color: Color.black.opacity(0.3), radius: 30, x: 0, y: 20)
        .padding()
        .vSpacing(.top)
    }
}

struct SchoolDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolDetailView(school: SchoolModel.schoolModelStub)
    }
}
