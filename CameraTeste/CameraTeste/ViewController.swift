//
//  ViewController.swift
//  CameraTeste
//
//  Created by Matheus Amancio Seixeiro on 9/14/15.
//  Copyright (c) 2015 Matheus Amancio Seixeiro. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary

class ViewController: UIViewController {
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var captureDevice : AVCaptureDevice?
    var cameratype: Bool = true
    var effectiveScale : CGFloat = 1.0
    var beginGestureScale = CGFloat()
    var viewFlash = UIView()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height = self.view.layer.frame.size.height
        let width = self.view.layer.frame.size.width
        
        // MARK: Camera Session
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetHigh
        let devices = AVCaptureDevice.devices()
        for device in devices {
            if (device.hasMediaType(AVMediaTypeVideo)) {
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil {

                        
                        var error: NSError?
                        var input = AVCaptureDeviceInput(device: captureDevice, error: &error)
                        
                        if error == nil && captureSession!.canAddInput(input) {
                            captureSession!.addInput(input)
                            
                            stillImageOutput = AVCaptureStillImageOutput()
                            stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
                            if captureSession!.canAddOutput(stillImageOutput) {
                                captureSession!.addOutput(stillImageOutput)
                                
                                self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                                self.previewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
                                self.previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
                                
                                
                                
                                self.previewLayer!.frame = CGRectMake(0,0, width , height)
                                self.view.layer.addSublayer(previewLayer)
                                self.previewLayer!.frame = view.bounds
                                captureSession!.startRunning()
                            }
                        }
                    }
                }
            }
        }


    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touchCount = touches.count
        let touch = touches.first as! UITouch
//        foco(touch)
        var screenSize = view.bounds.size

            
        if let device = captureDevice {
            if(device.lockForConfiguration(nil)) {
                device.focusPointOfInterest = touch.locationInView(self.view)
                device.focusMode = AVCaptureFocusMode.AutoFocus
                device.exposurePointOfInterest = touch.locationInView(self.view)
                device.exposureMode = AVCaptureExposureMode.AutoExpose
                device.unlockForConfiguration()
            }
        }
    }

    
    func foco(tap: UITouch){

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

