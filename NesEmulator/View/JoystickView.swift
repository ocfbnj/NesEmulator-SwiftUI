//
//  JoystickView.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/24.
//

import SwiftUI

struct JoystickView: View {
    var bus = CBus(ptr: nil)

    @State var position: CGPoint?

    private let r1 = 80.0
    private let r2 = 30.0

    var body: some View {
        GeometryReader { geometry in
            let rect = geometry.frame(in: .local)
            let center = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2)

            Group {
                Circle()
                    .frame(width: r1 * 2, height: r1 * 2)
                    .position(center)
                    .foregroundColor(.primary)
                    .opacity(0.1)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                moveTo(value.location, center)
                            })
                            .onEnded({ _ in
                                position = center
                                releaseAllKey()
                            })
                    )

                Circle()
                    .frame(width: r2 * 2, height: r2 * 2)
                    .position(position ?? center)
                    .foregroundColor(.gray)
                    .opacity(0.5)
            }
        }
        .frame(width: r1 * 2, height: r1 * 2)
    }

    private func moveTo(_ newPosition: CGPoint, _ center: CGPoint) {
        var newPosition = newPosition

        let distance = newPosition.distanceTo(center)
        let theta = getAngle(newPosition, center, distance)
        let angle = theta / Double.pi * 180

        if distance > r1 {
            newPosition.x = center.x + r1 * cos(theta)
            newPosition.y = center.y + r1 * sin(theta)
        }

        position = newPosition
        setKey(withAngle: angle + 180.0)
    }

    private func getAngle(_ newPosition: CGPoint, _ center: CGPoint, _ distance: Double) -> Double {
        let oa = (1.0, 0.0)
        let ob = (newPosition.x - center.x, newPosition.y - center.y)
        var theta = acos((oa.0 * ob.0 + oa.1 * ob.1) / distance)

        if oa.0 * ob.1 - oa.1 * ob.0 < 0 {
            theta = -theta
        }

        return theta
    }

    private func setKey(withAngle angle: Double) {
        var mask: UInt8 = 0

        if angle >= 22.5 && angle < 67.5 {
//            print("Left Up")
            mask |= 1 << 6
            mask |= 1 << 4
        } else if angle >= 67.5 && angle < 112.5 {
//            print("Up")
            mask |= 1 << 4
        } else if angle >= 112.5 && angle < 157.5 {
//            print("Righ Up")
            mask |= 1 << 4
            mask |= 1 << 7
        } else if angle >= 157.5 && angle < 202.5 {
//            print("Right")
            mask |= 1 << 7
        } else if angle >= 202.5 && angle < 247.5 {
//            print("Right Down")
            mask |= 1 << 7
            mask |= 1 << 5
        } else if angle >= 247.5 && angle < 292.5 {
//            print("Down")
            mask |= 1 << 5
        } else if angle >= 292.5 && angle < 337.5 {
//            print("Left Down")
            mask |= 1 << 6
            mask |= 1 << 5
        } else {
//            print("Left")
            mask |= 1 << 6
        }

        setKey(withMask: mask)
    }

    private func setKey(withMask mask: UInt8) {
        for i in 4 ..< 8 {
            let b = (mask >> i) & 1

            if b == 1 {
                press_button(bus, ButtonKey(rawValue: 1 << i)!.joypadKey)
            } else {
                release_button(bus, ButtonKey(rawValue: 1 << i)!.joypadKey)
            }
        }
    }

    private func releaseAllKey() {
        setKey(withMask: 0)
    }
}

struct JoystickView_Previews: PreviewProvider {
    static var previews: some View {
        JoystickView()
    }
}
