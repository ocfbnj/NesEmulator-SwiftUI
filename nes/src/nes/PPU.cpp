#include <algorithm>

#include <nes/Bus.h>
#include <nes/PPU.h>

std::array<PPU::Pixel, 64> PPU::defaultPalette = {
    Pixel{.r = 0x80, .g = 0x80, .b = 0x80, .a = 0xFF},
    Pixel{.r = 0x00, .g = 0x3D, .b = 0xA6, .a = 0xFF},
    Pixel{.r = 0x00, .g = 0x12, .b = 0xB0, .a = 0xFF},
    Pixel{.r = 0x44, .g = 0x00, .b = 0x96, .a = 0xFF},
    Pixel{.r = 0xA1, .g = 0x00, .b = 0x5E, .a = 0xFF},
    Pixel{.r = 0xC7, .g = 0x00, .b = 0x28, .a = 0xFF},
    Pixel{.r = 0xBA, .g = 0x06, .b = 0x00, .a = 0xFF},
    Pixel{.r = 0x8C, .g = 0x17, .b = 0x00, .a = 0xFF},
    Pixel{.r = 0x5C, .g = 0x2F, .b = 0x00, .a = 0xFF},
    Pixel{.r = 0x10, .g = 0x45, .b = 0x00, .a = 0xFF},
    Pixel{.r = 0x05, .g = 0x4A, .b = 0x00, .a = 0xFF},
    Pixel{.r = 0x00, .g = 0x47, .b = 0x2E, .a = 0xFF},
    Pixel{.r = 0x00, .g = 0x41, .b = 0x66, .a = 0xFF},
    Pixel{.r = 0x00, .g = 0x00, .b = 0x00, .a = 0xFF},
    Pixel{.r = 0x05, .g = 0x05, .b = 0x05, .a = 0xFF},
    Pixel{.r = 0x05, .g = 0x05, .b = 0x05, .a = 0xFF},
    Pixel{.r = 0xC7, .g = 0xC7, .b = 0xC7, .a = 0xFF},
    Pixel{.r = 0x00, .g = 0x77, .b = 0xFF, .a = 0xFF},
    Pixel{.r = 0x21, .g = 0x55, .b = 0xFF, .a = 0xFF},
    Pixel{.r = 0x82, .g = 0x37, .b = 0xFA, .a = 0xFF},
    Pixel{.r = 0xEB, .g = 0x2F, .b = 0xB5, .a = 0xFF},
    Pixel{.r = 0xFF, .g = 0x29, .b = 0x50, .a = 0xFF},
    Pixel{.r = 0xFF, .g = 0x22, .b = 0x00, .a = 0xFF},
    Pixel{.r = 0xD6, .g = 0x32, .b = 0x00, .a = 0xFF},
    Pixel{.r = 0xC4, .g = 0x62, .b = 0x00, .a = 0xFF},
    Pixel{.r = 0x35, .g = 0x80, .b = 0x00, .a = 0xFF},
    Pixel{.r = 0x05, .g = 0x8F, .b = 0x00, .a = 0xFF},
    Pixel{.r = 0x00, .g = 0x8A, .b = 0x55, .a = 0xFF},
    Pixel{.r = 0x00, .g = 0x99, .b = 0xCC, .a = 0xFF},
    Pixel{.r = 0x21, .g = 0x21, .b = 0x21, .a = 0xFF},
    Pixel{.r = 0x09, .g = 0x09, .b = 0x09, .a = 0xFF},
    Pixel{.r = 0x09, .g = 0x09, .b = 0x09, .a = 0xFF},
    Pixel{.r = 0xFF, .g = 0xFF, .b = 0xFF, .a = 0xFF},
    Pixel{.r = 0x0F, .g = 0xD7, .b = 0xFF, .a = 0xFF},
    Pixel{.r = 0x69, .g = 0xA2, .b = 0xFF, .a = 0xFF},
    Pixel{.r = 0xD4, .g = 0x80, .b = 0xFF, .a = 0xFF},
    Pixel{.r = 0xFF, .g = 0x45, .b = 0xF3, .a = 0xFF},
    Pixel{.r = 0xFF, .g = 0x61, .b = 0x8B, .a = 0xFF},
    Pixel{.r = 0xFF, .g = 0x88, .b = 0x33, .a = 0xFF},
    Pixel{.r = 0xFF, .g = 0x9C, .b = 0x12, .a = 0xFF},
    Pixel{.r = 0xFA, .g = 0xBC, .b = 0x20, .a = 0xFF},
    Pixel{.r = 0x9F, .g = 0xE3, .b = 0x0E, .a = 0xFF},
    Pixel{.r = 0x2B, .g = 0xF0, .b = 0x35, .a = 0xFF},
    Pixel{.r = 0x0C, .g = 0xF0, .b = 0xA4, .a = 0xFF},
    Pixel{.r = 0x05, .g = 0xFB, .b = 0xFF, .a = 0xFF},
    Pixel{.r = 0x5E, .g = 0x5E, .b = 0x5E, .a = 0xFF},
    Pixel{.r = 0x0D, .g = 0x0D, .b = 0x0D, .a = 0xFF},
    Pixel{.r = 0x0D, .g = 0x0D, .b = 0x0D, .a = 0xFF},
    Pixel{.r = 0xFF, .g = 0xFF, .b = 0xFF, .a = 0xFF},
    Pixel{.r = 0xA6, .g = 0xFC, .b = 0xFF, .a = 0xFF},
    Pixel{.r = 0xB3, .g = 0xEC, .b = 0xFF, .a = 0xFF},
    Pixel{.r = 0xDA, .g = 0xAB, .b = 0xEB, .a = 0xFF},
    Pixel{.r = 0xFF, .g = 0xA8, .b = 0xF9, .a = 0xFF},
    Pixel{.r = 0xFF, .g = 0xAB, .b = 0xB3, .a = 0xFF},
    Pixel{.r = 0xFF, .g = 0xD2, .b = 0xB0, .a = 0xFF},
    Pixel{.r = 0xFF, .g = 0xEF, .b = 0xA6, .a = 0xFF},
    Pixel{.r = 0xFF, .g = 0xF7, .b = 0x9C, .a = 0xFF},
    Pixel{.r = 0xD7, .g = 0xE8, .b = 0x95, .a = 0xFF},
    Pixel{.r = 0xA6, .g = 0xED, .b = 0xAF, .a = 0xFF},
    Pixel{.r = 0xA2, .g = 0xF2, .b = 0xDA, .a = 0xFF},
    Pixel{.r = 0x99, .g = 0xFF, .b = 0xFC, .a = 0xFF},
    Pixel{.r = 0xDD, .g = 0xDD, .b = 0xDD, .a = 0xFF},
    Pixel{.r = 0x11, .g = 0x11, .b = 0x11, .a = 0xFF},
    Pixel{.r = 0x11, .g = 0x11, .b = 0x11, .a = 0xFF},
};

void PPU::connect(Bus* bus) {
    this->bus = bus;
    assert(this->bus != nullptr);
}

void PPU::clock() {
    frameComplete = false;

    // The PPU renders 262 scanlines per frame.
    // Each scanline lasts for 341 PPU clock cycles (113.667 CPU clock cycles; 1 CPU cycle = 3 PPU cycles),
    // with each clock cycle producing one pixel.

    if (scanline >= -1 && scanline < 240) {
        visibleFrameAndPreRender();
    } else if (scanline == 240) {
        // post-render scanline
        // do nothing
    } else if (scanline >= 241 && scanline < 261) {
        verticalBlanking();
    } else {
        assert(0);
    }

    renderFrame();

    processMapper();

    incrementCycle();
}

void PPU::reset() {
    control.reg = 0;
    mask.reg = 0;
    status.reg = 0;
    oamAddr = 0;
    internalReadBuf = 0;

    scanline = -1;
    cycle = 0;

    vramAddr.reg = 0;
    tramAddr.reg = 0;
    fineX = 0;
    latch = 0;

    bgNtByte = 0;
    bgAtByte = 0;
    bgTileByteLo = 0;
    bgTileByteHi = 0;
    bgPatternShifterLo = 0;
    bgPatternShifterHi = 0;
    bgAttributeShifterLo = 0;
    bgAttributeShifterHi = 0;

    spriteCount = 0;
    sprite0HitPossible = false;
}

std::uint8_t PPU::readStatus() {
    std::uint8_t res = status.read();

    // Reading the status register will clear bit 7 and also the address latch used by PPUSCROLL and PPUADDR.
    status.resetVblank();
    latch = 0;

    return res;
}

std::uint8_t PPU::readOamData() const {
    assert(oamAddr >= 0 && oamAddr < primaryOamData.size());
    return primaryOamData[oamAddr];
}

std::uint8_t PPU::readData() {
    std::uint16_t addr = vramAddr.reg;
    incrementAddr();

    std::uint8_t res = internalReadBuf;

    // When reading while the VRAM address is in the range 0-$3EFF (i.e., before the palettes),
    // the read will return the contents of an internal readData buffer.
    if (addr >= 0x0000 && addr < 0x3F00) {
        internalReadBuf = read(addr);
    } else if (addr >= 0x3F00 && addr < 0x4000) {
        res = read(addr);
    } else {
        assert(0);
    }

    return res;
}

std::uint8_t PPU::readPalette(std::uint16_t addr) const {
    assert(addr >= 0x3F00 && addr < 0x3F20);
    return paletteTable[addr - 0x3F00] & (mask.isGreyscale() ? 0x30 : 0x3F);
}

void PPU::writeCtrl(std::uint8_t data) {
    bool prev = control.generateNMI();

    control.write(data);
    tramAddr.nametableX = data & 1;
    tramAddr.nametableY = (data >> 1) & 1;

    // If the PPU is currently in vertical blank,
    // and the PPUSTATUS ($2002) vblank flag is still set (1),
    // changing the NMI flag in bit 7 of $2000 from 0 to 1 will immediately generate an NMI.
    if (status.isInVblank() && !prev && control.generateNMI()) {
        assert(bus != nullptr);
        bus->getCPU().nmi();
    }
}

void PPU::writeMask(std::uint8_t data) {
    mask.write(data);
}

void PPU::writeOamAddr(std::uint8_t data) {
    oamAddr = data;
}

void PPU::writeOamData(std::uint8_t data) {
    // Writes will increment oamAddr after the writing
    primaryOamData[oamAddr++] = data;
}

void PPU::writeScroll(std::uint8_t data) {
    if (latch == 0) {
        tramAddr.coarseX = (data >> 3) & 0b1'1111;
        fineX = data & 0b111;
        latch = 1;
    } else {
        tramAddr.coarseY = (data >> 3) & 0b1'1111;
        tramAddr.fineY = data & 0b111;
        latch = 0;
    }
}

void PPU::writeAddr(std::uint8_t data) {
    if (latch == 0) {
        tramAddr.reg = ((std::uint16_t)(data & 0b0011'1111)) << 8;
        tramAddr.reg &= ~(0b100'0000);
        latch = 1;
    } else {
        tramAddr.reg |= data;
        vramAddr = tramAddr;
        latch = 0;
    }
}

void PPU::writeData(std::uint8_t data) {
    std::uint16_t addr = vramAddr.reg;
    incrementAddr();

    assert(addr >= 0x0000 && addr < 0x4000);
    write(addr, data);
}

void PPU::writeOamDMA(std::span<std::uint8_t, 256> buffer) {
    for (std::uint8_t data : buffer) {
        primaryOamData[oamAddr++] = data;
    }
}

void PPU::writePalette(std::uint16_t addr, std::uint8_t data) {
    assert(addr >= 0x3F00 && addr < 0x3F20);
    paletteTable[addr - 0x3F00] = data;
}

void PPU::serialize(std::ostream& os) const {
    auto begin = reinterpret_cast<const char*>(this) + offsetof(PPU, control);
    auto end = reinterpret_cast<const char*>(this) + offsetof(PPU, bus);
    os.write(begin, end - begin);
}

void PPU::deserialize(std::istream& is) {
    auto begin = reinterpret_cast<char*>(this) + offsetof(PPU, control);
    auto end = reinterpret_cast<char*>(this) + offsetof(PPU, bus);
    is.read(begin, end - begin);
}

const PPU::Frame& PPU::getFrame() const {
    return frame;
}

bool PPU::isFrameComplete() const {
    return frameComplete;
}

PPU::Pixel PPU::getColor(std::uint8_t palette, std::uint8_t pixel) {
    std::uint8_t index = read(0x3F00 + ((palette << 2) | pixel));
    assert(index >= 0 && index < 64);

    return defaultPalette[index];
}

std::uint8_t PPU::read(std::uint16_t addr) {
    assert(bus != nullptr);
    return bus->ppuRead(addr);
}

void PPU::write(std::uint16_t addr, std::uint8_t data) {
    assert(bus != nullptr);
    return bus->ppuWrite(addr, data);
}

void PPU::incrementAddr() {
    vramAddr.reg += control.addrIncrement();
}

void PPU::incrementHorizontal() {
    // See https://wiki.nesdev.org/w/index.php?title=PPU_scrolling#Coarse_X_increment
    if (mask.renderingEnabled()) {
        if (vramAddr.coarseX == 31) {
            vramAddr.coarseX = 0;
            vramAddr.nametableX = ~vramAddr.nametableX;
        } else {
            vramAddr.coarseX++;
        }
    }
}

void PPU::incrementVertical() {
    // See https://wiki.nesdev.org/w/index.php?title=PPU_scrolling#Y_increment
    if (mask.renderingEnabled()) {
        if (vramAddr.fineY < 7) {
            vramAddr.fineY++;
        } else {
            vramAddr.fineY = 0;

            if (vramAddr.coarseY == 29) {
                vramAddr.coarseY = 0;
                vramAddr.nametableY = ~vramAddr.nametableY;
            } else if (vramAddr.coarseY == 31) {
                vramAddr.coarseY = 0;
            } else {
                vramAddr.coarseY++;
            }
        }
    }
}

void PPU::transferHorizontalBits() {
    if (mask.renderingEnabled()) {
        vramAddr.coarseX = tramAddr.coarseX;
        vramAddr.nametableX = tramAddr.nametableX;
    }
}

void PPU::transferVerticalBits() {
    if (mask.renderingEnabled()) {
        vramAddr.coarseY = tramAddr.coarseY;
        vramAddr.nametableY = tramAddr.nametableY;
        vramAddr.fineY = tramAddr.fineY;
    }
}

void PPU::loadShifters() {
    bgPatternShifterLo = (bgPatternShifterLo & 0xFF00) | bgTileByteLo;
    bgPatternShifterHi = (bgPatternShifterHi & 0xFF00) | bgTileByteHi;

    // for convenient
    bgAttributeShifterLo = (bgAttributeShifterLo & 0xFF00) | ((bgAtByte & 0b01) ? 0xFF : 0x00);
    bgAttributeShifterHi = (bgAttributeShifterHi & 0xFF00) | ((bgAtByte & 0b10) ? 0xFF : 0x00);
}

void PPU::updateShifters() {
    assert(cycle >= 1 && cycle < 257 || cycle >= 321 && cycle < 337);

    if (mask.showBackground()) {
        bgPatternShifterLo <<= 1;
        bgPatternShifterHi <<= 1;

        bgAttributeShifterLo <<= 1;
        bgAttributeShifterHi <<= 1;
    }

    if (mask.showSprites() && cycle >= 2 && cycle < 257) {
        for (int i = 0; i != spriteCount; i++) {
            std::uint8_t* sprite = secondaryOamData.data() + i * 4;

            if (sprite[3] > 0) {
                sprite[3]--;
            } else {
                spritePatternShifterLo[i] <<= 1;
                spritePatternShifterHi[i] <<= 1;
            }
        }
    }
}

void PPU::visibleFrameAndPreRender() {
    assert(scanline >= -1 && scanline < 240);

    if (scanline == -1) {
        // pre-render scanline
        if (cycle == 1) {
            status.resetSprite0Hit();
            status.resetSpriteOverflow();
            status.resetVblank();
        } else if (cycle >= 280 && cycle < 305) {
            // If rendering is enabled, at the end of vblank,
            // shortly after the horizontal bits are copied from t to v at dot 257,
            // the PPU will repeatedly copy the vertical bits from t to v from dots 280 to 304,
            // completing the full initialization of v from t:
            // v: GHIA.BC DEF..... <- t: GHIA.BC DEF.....
            transferVerticalBits();
        }
    }

    if ((cycle >= 1 && cycle < 257) || (cycle >= 321 && cycle < 337)) {
        updateShifters();

        switch ((cycle - 1) % 8) {
        case 0:
            loadShifters();
                bgNtByte = read(0x2000 | (vramAddr.reg & 0x0FFF));
            break;
        case 2:
            bgAtByte = read(0x23C0 | (vramAddr.reg & 0x0C00) | ((vramAddr.reg >> 4) & 0x38) | ((vramAddr.reg >> 2) & 0x07));

            if (vramAddr.coarseY & 0x02) {
                bgAtByte >>= 4;
            }
            if (vramAddr.coarseX & 0x02) {
                bgAtByte >>= 2;
            }

            bgAtByte &= 0x03;
            break;
        case 4:
            bgTileByteLo = read(control.backgroundPatternAddr() + (bgNtByte << 4) + vramAddr.fineY + 0);
            break;
        case 6:
            bgTileByteHi = read(control.backgroundPatternAddr() + (bgNtByte << 4) + vramAddr.fineY + 8);
            break;
        case 7:
            incrementHorizontal();
            break;
        default:
            break;
        }
    }

    if (cycle == 256) {
        // If rendering is enabled, the PPU increments the vertical position in v.
        incrementVertical();
    } else if (cycle == 257) {
        // If rendering is enabled, the PPU copies all bits related to horizontal position from t to v:
        // v: ....A.. ...BCDEF <- t: ....A.. ...BCDEF
        transferHorizontalBits();
    } else if (cycle == 338 || cycle == 340) {
        // unused NT fetches
        bgNtByte = read(0x2000 | (vramAddr.reg & 0x0FFF));
    }

    if (scanline != -1) {
        // Secondary OAM clear and sprite evaluation do not occur on the pre-render line.
        secondaryOamClearAndSpriteEvaluation();
        calculateSpritesPatternAddr();
    }
}

void PPU::verticalBlanking() {
    assert(scanline >= 241 && scanline < 261);

    if (scanline == 241 && cycle == 1) {
        status.setVblank();

        if (control.generateNMI()) {
            assert(bus != nullptr);
            bus->getCPU().nmi();
        }
    }
}

void PPU::renderFrame() {
    int finalX = cycle - 1;
    int finalY = scanline;

    if (!(mask.renderingEnabled() && finalX >= 0 && finalX < 256 && finalY >= 0 && finalY < 240)) {
        return;
    }

    std::uint8_t bgPixel = 0x00;
    std::uint8_t bgPalette = 0x00;

    if (mask.showBackground() && (finalX >= 8 || mask.showBackgroundLeft())) {
        std::uint16_t bit = 0x8000 >> fineX;

        std::uint8_t bgPixelHi = (bgPatternShifterHi & bit) > 0;
        std::uint8_t bgPixelLo = (bgPatternShifterLo & bit) > 0;
        bgPixel = (bgPixelHi << 1) | bgPixelLo;

        std::uint8_t bgPaletteHi = (bgAttributeShifterHi & bit) > 0;
        std::uint8_t bgPaletteLo = (bgAttributeShifterLo & bit) > 0;
        bgPalette = (bgPaletteHi << 1) | bgPaletteLo;
    }

    std::uint8_t fgPixel = 0x00;
    std::uint8_t fgPalette = 0x00;
    bool fgBehindBg = false;
    bool sprite0BeingRendered = false;

    if (mask.showSprites() && (finalX >= 8 || mask.showSpritesLeft())) {
        for (int i = 0; i != spriteCount; i++) {
            std::uint8_t* sprite = secondaryOamData.data() + i * 4;
            std::uint8_t spriteX = sprite[3];

            if (spriteX == 0) {
                std::uint8_t fgPixelLo = (spritePatternShifterLo[i] & 0x80) > 0;
                std::uint8_t fgPixelHi = (spritePatternShifterHi[i] & 0x80) > 0;
                fgPixel = (fgPixelHi << 1) | fgPixelLo;

                fgPalette = (sprite[2] & 0b11) | (1 << 2);
                fgBehindBg = (sprite[2] >> 5) & 1;

                if (fgPixel) {
                    if (i == 0) {
                        sprite0BeingRendered = true;
                    }

                    break;
                }
            }
        }
    }

    std::uint8_t finalPalette = 0x00;
    std::uint8_t finalPixel = 0x00;

    if (bgPixel) {
        if (fgPixel) {
            if (fgBehindBg) {
                finalPalette = bgPalette;
                finalPixel = bgPixel;
            } else {
                finalPalette = fgPalette;
                finalPixel = fgPixel;
            }

            if (sprite0HitPossible && sprite0BeingRendered) {
                if (mask.showBackgroundLeft() || mask.showSpritesLeft()) {
                    status.setSprite0Hit();
                } else {
                    if (finalX >= 8) {
                        status.setSprite0Hit();
                    }
                }
            }
        } else {
            finalPalette = bgPalette;
            finalPixel = bgPixel;
        }
    } else {
        if (fgPixel) {
            finalPalette = fgPalette;
            finalPixel = fgPixel;
        }
    }

    frame.setPixel(finalX, finalY, getColor(finalPalette, finalPixel));
}

void PPU::incrementCycle() {
    if (++cycle == 341) {
        cycle = 0;

        if (++scanline == 261) {
            scanline = -1;
            frameComplete = true;
        }
    }
}

void PPU::secondaryOamClearAndSpriteEvaluation() {
    assert(scanline >= 0 && scanline < 240);

    if (cycle == 257) {
        std::fill(secondaryOamData.begin(), secondaryOamData.end(), 0);
        std::fill(spritePatternShifterLo.begin(), spritePatternShifterLo.end(), 0);
        std::fill(spritePatternShifterHi.begin(), spritePatternShifterHi.end(), 0);

        spriteCount = 0;
        sprite0HitPossible = false;

        for (int i = 0; i != 64 && spriteCount <= MaximumSpriteCount; i++) {
            std::uint8_t* sprite = primaryOamData.data() + i * 4;

            std::uint8_t spriteY = sprite[0];
            std::size_t diff = static_cast<std::size_t>(scanline) - static_cast<std::size_t>(spriteY);

            if (diff >= 0 && diff < control.spriteHeight()) {
                if (spriteCount < MaximumSpriteCount) {
                    if (i == 0) {
                        sprite0HitPossible = true;
                    }

                    std::copy(sprite, sprite + 4, std::next(secondaryOamData.begin(), 4 * spriteCount));
                }

                spriteCount++;
            }
        }

        if (spriteCount > MaximumSpriteCount) {
            spriteCount = MaximumSpriteCount;
            status.setSpriteOverflow();
        }
    }
}

void PPU::calculateSpritesPatternAddr() {
    assert(scanline >= 0 && scanline < 240);

    if (cycle == 340) {
        for (int i = 0; i != spriteCount; i++) {
            std::uint8_t* sprite = secondaryOamData.data() + i * 4;

            std::uint8_t spriteY = sprite[0];
            bool flipVertical = (sprite[2] >> 7) & 1;
            bool flipHorizontal = (sprite[2] >> 6) & 1;

            std::uint16_t patternAddrLo;

            if (control.spriteHeight() == 8) {
                // For 8x8 sprites,
                // this is the tile number of this sprite within the pattern table selected in bit 3 of PPUCTRL ($2000).
                std::uint16_t patternAddr = control.spritePatternAddr();
                std::uint8_t tileNumber = sprite[1];
                std::uint8_t row = flipVertical ? (7 - (scanline - spriteY)) : (scanline - spriteY);

                patternAddrLo = patternAddr | (tileNumber << 4) | (row);
            } else {
                // For 8x16 sprites,
                // the PPU ignores the pattern table selection and selects a pattern table from bit 0 of this number.
                std::uint16_t patternAddr = (sprite[1] & 0x01) ? 0x1000 : 0x0000;
                std::uint8_t tileNumber = sprite[1] & 0xFE;
                std::uint8_t row = (scanline - spriteY) & 0x07;

                if (scanline - spriteY < 8) {
                    if (flipVertical) {
                        tileNumber += 1;
                        row = 7 - row;
                    }
                } else {
                    if (!flipVertical) {
                        tileNumber += 1;
                    } else {
                        row = 7 - row;
                    }
                }

                patternAddrLo = patternAddr | (tileNumber << 4) | (row);
            }

            spritePatternShifterLo[i] = read(patternAddrLo);
            spritePatternShifterHi[i] = read(patternAddrLo + 8);

            if (flipHorizontal) {
                auto flipByte = [](std::uint8_t b) {
                    b = (b & 0xF0) >> 4 | (b & 0x0F) << 4;
                    b = (b & 0xCC) >> 2 | (b & 0x33) << 2;
                    b = (b & 0xAA) >> 1 | (b & 0x55) << 1;
                    return b;
                };

                spritePatternShifterLo[i] = flipByte(spritePatternShifterLo[i]);
                spritePatternShifterHi[i] = flipByte(spritePatternShifterHi[i]);
            }
        }
    }
}

void PPU::processMapper() {
    if (cycle == 260 && scanline < 240 && mask.renderingEnabled()) {
        assert(bus != nullptr);
        bus->getMapper().scanline();
    }
}
