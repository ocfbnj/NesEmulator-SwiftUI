#ifndef OCFBNJ_NES_NES_FILE_H
#define OCFBNJ_NES_NES_FILE_H

#include <cstdint>
#include <memory>
#include <optional>
#include <string_view>

#include <nes/Cartridge.h>

std::optional<Cartridge> loadNesFile(std::string_view path);
std::optional<Cartridge> loadNesFileFromData(const char* p, std::size_t len);

#endif // OCFBNJ_NES_NES_FILE_H
