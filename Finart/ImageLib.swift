//
//  ImageLib.swift
//  Finart
//
//  Created by Suren Kazaryan on 16.04.2022.
//

import Foundation
import UIKit

enum IconLib: String, CaseIterable {
    case creditCard = "creditcard"
    case banknote = "banknote"
    case briefcase = "briefcase"
    case bag = "bag"
    case cart = "cart"
    
    //Transport
    case car = "car"
    case boltCar = "bolt.car"
    case bus = "bus"
    case tram = "tram"
    case tramTunel = "tram.tunnel.fill"
    case airplane = "airplane"
    case ferry = "ferry"
    case cablecar = "cablecar"
    case bicycle = "bicycle"
    case scooter = "scooter"
    case fuelpump = "fuelpump"
    
    //Device
    case iphone = "iphone"
    case ipad = "ipad"
    case ipod = "ipod"
    case display = "display"
    case tv = "tv"
    case laptopcomputer = "laptopcomputer"
    case gamecontroller = "gamecontroller"
    case camera = "camera"
    case phone = "phone"
    case video = "video"
    case applewatch = "applewatch"
    
    
    case appletv = "appletv"
    case keyboard = "keyboard"
    case printer = "printer"
    case faxmachine = "faxmachine"
    
    //Shopping
    case tshirt = "tshirt"
    
    //Pet
    case pawprint = "pawprint"
    case hare = "hare"
    case tortoise = "tortoise"
    case ant = "ant"
    case ladybug = "ladybug"
    case leaf = "leaf"
    
    //Food
    case cupAdnSaucer = "cup.and.saucer"
    case takebag = "takeoutbag.and.cup.and.straw"
    case forkKnife = "fork.knife"

    //Else
    case house = "house"
    case buildingColumns = "building.columns"
    case building = "building"
    case buildingTwo = "building.2"
    case lock = "lock"
    case key = "key"
    case wifi = "wifi"
    case pin = "pin"
    case map = "map"
    
    case book = "book"
    case boolClosed = "book.closed"
    case magazine = "magazine"
    case newspaper = "newspaper"
    case graduationcap = "graduationcap"
    case ticket = "ticket"
    case paperclip = "paperclip"
    case person = "person"
    case person3 = "person.3"
    case personTextRectangle = "person.text.rectangle"
    case globe = "globe"
    case sunMax = "sun.max"
    case moon = "moon"
    case cloud = "cloud"
    case snowflake = "snowflake"
    case umbrella = "umbrella"
    case flame = "flame"
    case musicNote = "music.note"
    case mic = "mic"
    case heard = "heart"
    case star = "star"
    case flag = "flag"
    case location = "location"
    case bell = "bell"
    case bolt = "bolt"
    case tag = "tag"
    case eye = "eye"
    case eyebrow = "eyebrow"
    case mustache = "mustache"
    case mouth = "mouth"
    case eyeglasses = "eyeglasses"
    case brain = "brain"
    case message = "message"
    case envelope = "envelope"
    case gearshape = "gearshape"
    case scissors = "scissors"
    case paintbrush = "paintbrush"
    case paintbrushPointede = "paintbrush.pointed"
    case bandage = "bandage"
    case ruler = "ruler"
    case hammer = "hammer"
    case wrench = "wrench"
    case crewdriver = "crewdriver"
    case scroll = "scroll"
    case theatermasks = "theatermasks"
    case film = "film"
    case crown = "crown"
    case comb = "comb"
    case photo = "photo"
    case gift = "gift"
    case pills = "pills"
    case cross = "cross"
    case code = "chevron.left.forwardslash.chevron.right"
    case terminal = "terminal"

    
    case trash = "trash"
    
    //USE FOR SYSTEM
    case calendar = "calendar"
    case reportFirstDay = "1.circle"
    case cellColor = "square.grid.3x3.topleft.filled"
    case backgroundColor = "square.inset.filled"
    case chartPie = "chart.pie"
    case chartPieFill = "chart.pie.fill"
    case chartXyaxis = "chart.xyaxis.line"
    case chartBarXaxis = "chart.bar.xaxis"
    case chartBarDoc = "chart.bar.doc.horizontal"
    case chartBarDocFill = "chart.bar.doc.horizontal.fill"
    case squarGrid4x3 = "square.grid.4x3.fill"

    
    //System money icon
    case rub = "rublesign.square.fill"

    
    var image: UIImage {
        return UIImage(systemName: self.rawValue) ?? UIImage()
    }
    
}
