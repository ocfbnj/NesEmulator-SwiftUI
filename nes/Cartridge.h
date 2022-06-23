//
//  Cartridge.hpp
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/21.
//

#ifndef NesFile_hpp
#define NesFile_hpp

#ifdef __cplusplus
extern "C"
{
#endif

	struct CCartridge
	{
		void *ptr; // Cartridge*
	};

	struct CCartridge load_cartridge(const char *p, int len);
	void free_cartridge(struct CCartridge ccartridge);

#ifdef __cplusplus
}
#endif

#endif /* NesFile_hpp */
