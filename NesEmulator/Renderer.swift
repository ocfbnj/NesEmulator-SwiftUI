//
//  Renderer.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/22.
//

import Foundation
import MetalKit

class Renderer: NSObject, MTKViewDelegate {
    var parent: NesView

    var metalDevice: MTLDevice!
    var metalCommandQueue: MTLCommandQueue!

    let pipelineState: MTLRenderPipelineState
    let vertexBuffer: MTLBuffer
    let indexBuffer: MTLBuffer

    let texture: MTLTexture
    let region = MTLRegion(origin: MTLOrigin(x: 0, y: 0, z: 0), size: MTLSize(width: Frame.width, height: Frame.height, depth: 1))
    let bytesPerRow = 4 * Frame.width

    init(_ parent: NesView) {
        self.parent = parent

        if let metalDevice = MTLCreateSystemDefaultDevice() {
            self.metalDevice = metalDevice
        }

        metalCommandQueue = metalDevice.makeCommandQueue()

        let pipeDescriptor = MTLRenderPipelineDescriptor()
        let library = metalDevice.makeDefaultLibrary()
        pipeDescriptor.vertexFunction = library?.makeFunction(name: "vertexShader")
        pipeDescriptor.fragmentFunction = library?.makeFunction(name: "fragmentShader")
        pipeDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm

        do {
            try pipelineState = metalDevice.makeRenderPipelineState(descriptor: pipeDescriptor)
        } catch {
            fatalError("make render pipeline state failed")
        }

        let vertices = [
            Vertex(position: [-1, -1], texcoord: [0, 0]),
            Vertex(position: [1, -1], texcoord: [1, 0]),
            Vertex(position: [1, 1], texcoord: [1, 1]),
            Vertex(position: [-1, 1], texcoord: [0, 1]),
        ]

        let indices: [UInt16] = [
            0, 1, 2,
            2, 3, 0,
        ]

        vertexBuffer = metalDevice.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Vertex>.stride)!
        indexBuffer = metalDevice.makeBuffer(bytes: indices, length: indices.count * MemoryLayout<UInt16>.stride)!

        let textureDescriptor = MTLTextureDescriptor()
        textureDescriptor.pixelFormat = .rgba8Unorm
        textureDescriptor.width = Frame.width
        textureDescriptor.height = Frame.height
        texture = metalDevice.makeTexture(descriptor: textureDescriptor)!

        super.init()
    }

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // do nothing
    }

    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable else { return }

        let commandBuffer = metalCommandQueue.makeCommandBuffer()
        let renderPassDescirptor = view.currentRenderPassDescriptor
        renderPassDescirptor?.colorAttachments[0].clearColor = MTLClearColor(red: 0, green: 0.5, blue: 0.5, alpha: 1.0)
        renderPassDescirptor?.colorAttachments[0].loadAction = .clear
        renderPassDescirptor?.colorAttachments[0].storeAction = .store

        let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescirptor!)
        renderEncoder?.setRenderPipelineState(pipelineState)

        if parent.frameData.cframe.data != nil {
            renderEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)

            texture.replace(region: region, mipmapLevel: 0, withBytes: parent.frameData.cframe.data, bytesPerRow: bytesPerRow)

            renderEncoder?.setFragmentTexture(texture, index: 0)
            renderEncoder?.drawIndexedPrimitives(type: .triangle, indexCount: 6, indexType: .uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
        }

        renderEncoder?.endEncoding()

        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
