//
//  CameraView.swift
//  Jumpeak
//
//  Created by Денис Большачков on 15/06/23.
//

import SwiftUI
import AVKit
import AVFoundation
import FirebaseStorage

struct CameraView: View {
    @State private var completionAmount = 0.0
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var secondsCount: Double = 10
    
    @StateObject var cameraViewModel = CameraModel()
    @State var tickedTime: Double = 1
    @State var shouldShowDetailView = false
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .bottom){
                NavigationLink(isActive: $shouldShowDetailView) {
                    if let url = cameraViewModel.preivewURL {
                        FinalPreview(url: url)
                            .environmentObject(cameraViewModel)
                            .navigationBarBackButtonHidden(true)
                    }
                } label: {
                    EmptyView()
                }

                
                GeometryReader { proxy in
                    let size = proxy.size
                    CameraModelPreview(size: size)
                        .environmentObject(cameraViewModel)
                }
                .onAppear {
                    cameraViewModel.checkPermissions()
                    timer.upstream.connect().cancel()
                }
                .onReceive(timer) { newValue in
                    tickedTime += 1
                    
                    guard tickedTime == secondsCount + 1 else {
                        return
                    }
                    
                    timer.upstream.connect().cancel()
                    cameraViewModel.stopRecording()
                    shouldShowDetailView = true
                }
                
                buttonVideoView
                    .padding(.bottom, 64)
                
            }
            .ignoresSafeArea()
            .background(.black)
           
        }
    }
    
    var buttonVideoView: some View {
        ZStack {
            ZStack {
                Circle()
                    .trim(from: 0, to: completionAmount)
                    .stroke(Asset.Colors.accentColor.swiftUIColor, lineWidth: 7)
                    .frame(width: 72, height: 68)
                    .rotationEffect(.degrees(-90))
                    .onReceive(timer) { _ in
                        withAnimation {
                            completionAmount += 1 / secondsCount
                        }
                    }
                
                Circle()
                    .stroke(Asset.Colors.accentColor.swiftUIColor.opacity(0.5), lineWidth: 7)
                    .frame(width: 72, height: 68)
            }
            
            Circle()
                .fill(Asset.Colors.accentColor.swiftUIColor)
                .frame(width: 56, height: 56)
                .onTapGesture {
                    guard tickedTime == 1 else {
                        return
                    }

                    timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    cameraViewModel.startRecording()
                    
                }
        }
        
    }
    

}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}

struct FinalPreview: View {
    @EnvironmentObject var viewModel: CameraModel
    var url: URL
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            VideoPlayer(player: AVPlayer(url: url))
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading){
                BackBarButton()
            }
        }
        .navigationTitle("Видео-резюме")
        .overlay {
            Button {
                viewModel.uploadTOFireBaseVideo(url: url) { success in
                    print("dfjskf")
                } failure: { error in
                    
                }

            } label: {
                Text("upload data")
            }

        }
    }
}


class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate, AVCaptureFileOutputRecordingDelegate {
    @Published var session = AVCaptureSession()
    @Published var showAlert = false
    @Published var output = AVCaptureMovieFileOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    //MARK: Video Recorder Properties
    @Published var isRecording = false
    @Published var recorderUrls: [URL] = []
    @Published var preivewURL: URL?
    

    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { res in
                if res {
                    self.setUp()
                }
            }
        case .denied:
            self.showAlert.toggle()
            return
        default: return
        }
    }
    
    func setUp() {
        do {
            self.session.beginConfiguration()
            
            let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            let videoInput = try AVCaptureDeviceInput(device: cameraDevice!)
            let audioDevice = AVCaptureDevice.default(for: .audio)
            let audioInput = try AVCaptureDeviceInput(device: audioDevice!)
            
            if self.session.canAddInput(videoInput) && self.session.canAddInput(audioInput) {
                self.session.addInput(videoInput)
                self.session.addInput(audioInput)
            }
            
            if self.session.canAddOutput(self.output) {
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func startRecording() {
        let tempUrl = NSTemporaryDirectory() + "\(Date()).mov"
        output.startRecording(to: URL(fileURLWithPath: tempUrl), recordingDelegate: self)
        isRecording = true
    }
    
    func stopRecording() {
        output.stopRecording()
        isRecording = false
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        print(outputFileURL)
        self.preivewURL = outputFileURL
    }
    
    func uploadTOFireBaseVideo(url: URL,
                                      success : @escaping (String) -> Void,
                                      failure : @escaping (Error) -> Void) {

        let name = "\(Int(Date().timeIntervalSince1970)).mp4"
        let path = NSTemporaryDirectory() + name

        let dispatchgroup = DispatchGroup()

        dispatchgroup.enter()

        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let outputurl = documentsURL.appendingPathComponent(name)
        var ur = outputurl
        self.convertVideo(toMPEG4FormatForVideo: url as URL, outputURL: outputurl) { (session) in

            ur = session.outputURL!
            dispatchgroup.leave()

        }
        dispatchgroup.wait()

        let data = NSData(contentsOf: ur as URL)

        do {

            try data?.write(to: URL(fileURLWithPath: path), options: .atomic)

        } catch {

            print(error)
        }

        let storageRef = Storage.storage().reference().child("Videos").child(name)
        if let uploadData = data as Data? {
            storageRef.putData(uploadData, metadata: nil
                , completion: { (metadata, error) in
                    if let error = error {
                        failure(error)
                    }else{
                        success("success")
                    }
            })
        }
    }
    
    func convertVideo(toMPEG4FormatForVideo inputURL: URL, outputURL: URL, handler: @escaping (AVAssetExportSession) -> Void) {
        try? FileManager.default.removeItem(at: outputURL as URL)
        let asset = AVURLAsset(url: inputURL as URL, options: nil)

        let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)!
        exportSession.outputURL = outputURL
        exportSession.outputFileType = .mp4
        exportSession.exportAsynchronously(completionHandler: {
            handler(exportSession)
        })
    }
}

struct CameraModelPreview: UIViewRepresentable {
    @EnvironmentObject var cameraModel: CameraModel
    var size: CGSize
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        cameraModel.preview = AVCaptureVideoPreviewLayer(session: cameraModel.session)
        cameraModel.preview.frame.size = size
        
        cameraModel.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(cameraModel.preview)
        
        cameraModel.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
