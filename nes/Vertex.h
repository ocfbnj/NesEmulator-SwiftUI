//
//  Vertex.h
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/22.
//

#ifndef Vertex_h
#define Vertex_h

#include <simd/simd.h>

struct Vertex {
    vector_float2 position;
    vector_float2 texcoord;
};

#endif /* Vertex_h */
