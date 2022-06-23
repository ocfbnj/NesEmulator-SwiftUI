//
//  Shaders.metal
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/22.
//

#include <metal_stdlib>

#include "Vertex.h"

using namespace metal;

struct Fragment {
	float4 position [[position]];
	float2 texcoord;
};

vertex Fragment vertexShader(device const Vertex* vertexArray [[buffer(0)]], unsigned int vid [[vertex_id]]) {
	Vertex input = vertexArray[vid];

	Fragment output;
	output.position = float4(input.position.x, input.position.y, 0, 1);
	output.texcoord = input.texcoord;

	return output;
}

fragment half4 fragmentShader(Fragment input [[stage_in]], texture2d<half> colorTexture [[texture(0)]]) {
	constexpr sampler textureSampler (mag_filter::nearest, min_filter::nearest);
	const half4 colorSample = colorTexture.sample(textureSampler, input.texcoord);
	return colorSample;
}
