//
//  NesFile.cpp
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/21.
//

#include <nes/NesFile.h>

#include "Cartridge.h"

struct CCartridge load_cartridge(const char *p, int len)
{
	std::optional<Cartridge> res = loadNesFileFromData(p, len);
	if (!res)
	{
		return CCartridge{.ptr = nullptr};
	}

	Cartridge *cartridge = new Cartridge(res.value());
	return CCartridge{.ptr = cartridge};
}

void free_cartridge(struct CCartridge ccartridge)
{
	Cartridge *cartridge = static_cast<Cartridge *>(ccartridge.ptr);
	delete cartridge;
}
