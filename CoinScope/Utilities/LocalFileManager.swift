//
//  LocalFileManager.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/5/1403 AP.
//

import SwiftUI

class LocalFileManager {
    static let shared = LocalFileManager()
    private init (){}
    
    func saveImage (image:UIImage , imageName:String , folderName : String){
        
        // create folder
        createFolderIfNeeded(folderName: folderName)
        
        //get path for image
        guard let data = image.pngData() , let url = getURLForImage(imageName: imageName, folderName: folderName) else {return}
        
        //save image
        do {
            try data.write(to: url,options: [.atomic ])
        } catch let error {
            print("error saving image. imageName:\(imageName).\(error)")
        }
    }
    
    func getImage (imageName:String , folderName :String)->UIImage?{
        
        guard let url = getURLForImage(imageName: imageName, folderName: folderName) else {return nil}
        
        return UIImage(contentsOfFile: url.path())
    }
    
    private func createFolderIfNeeded (folderName : String){
        guard let url = getURLForFolder(folderName: folderName) else {return}
        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("error creating directory. foldername:\(folderName). \(error)")
            }
        }
    }
    
    private func getURLForFolder (folderName:String) -> URL?{
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        
        return url.appending(path: folderName)
    }
    
    private func getURLForImage (imageName:String , folderName:String) -> URL?{
        guard let url = getURLForFolder(folderName:folderName ) else { return nil}
        
        return url.appending(path: imageName + ".png")
    }
}
