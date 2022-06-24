//
//  Bus.c
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/21.
//

#include <unordered_map>
#include <string>
#include <sstream>

#include <nes/Bus.h>

#include "Bus.h"
#include "Cartridge.h"

constexpr auto Width = 256;
constexpr auto Height = 240;

static CColor data[Width * Height];
static std::string dumpedData;

CBus alloc_bus()
{
	Bus *ptr = new Bus();
	return CBus{.ptr = ptr};
}

void free_bus(CBus cbus)
{
	Bus *bus = static_cast<Bus *>(cbus.ptr);
	delete bus;

	cbus.ptr = nullptr;
}

void insert_cartridge(CBus cbus, CCartridge ccartridge)
{
	Bus *bus = static_cast<Bus *>(cbus.ptr);
	Cartridge *cartridge = static_cast<Cartridge *>(ccartridge.ptr);

	bus->insert(*cartridge);
}

void set_sample_rate(struct CBus cbus, int rate)
{
	Bus *bus = static_cast<Bus *>(cbus.ptr);
	bus->getAPU().setSampleRate(rate);
}

void set_sample_cb(CBus cbus, sample_cb cb)
{
	Bus *bus = static_cast<Bus *>(cbus.ptr);
	bus->getAPU().setSampleCallback(cb);
}

void power_up(CBus cbus)
{
	Bus *bus = static_cast<Bus *>(cbus.ptr);
	bus->powerUp();
}

struct CFrame perform_once(CBus cbus)
{
	Bus *bus = static_cast<Bus *>(cbus.ptr);

	do
	{
		bus->clock();
	} while (!bus->getPPU().isFrameComplete());

	auto rawFrame = bus->getPPU().getFrame().getRawPixels();
	memcpy(&data[0], rawFrame.data(), rawFrame.size());

	return CFrame{.data = &data[0]};
}

static std::unordered_map<CJoypadButton, Joypad::Button> buttonMap{
	{CJoypadButton::Right, Joypad::Button::Right},
	{CJoypadButton::Left, Joypad::Button::Left},
	{CJoypadButton::Down, Joypad::Button::Down},
	{CJoypadButton::Up, Joypad::Button::Up},
	{CJoypadButton::Start, Joypad::Button::Start},
	{CJoypadButton::Select, Joypad::Button::Select},
	{CJoypadButton::B, Joypad::Button::B},
	{CJoypadButton::A, Joypad::Button::A},
};

void press_button(CBus cbus, CJoypadButton btn)
{
	Bus *bus = static_cast<Bus *>(cbus.ptr);
	bus->getJoypad1().press(buttonMap[btn]);
}

void release_button(CBus cbus, CJoypadButton btn)
{
	Bus *bus = static_cast<Bus *>(cbus.ptr);
	bus->getJoypad1().release(buttonMap[btn]);
}

void quick_reset(CBus cbus)
{
	Bus *bus = static_cast<Bus *>(cbus.ptr);
	bus->reset();
}

void quick_save(CBus cbus)
{
	Bus *bus = static_cast<Bus *>(cbus.ptr);

	std::ostringstream oss;
	bus->serialize(oss);

	dumpedData = oss.str();
}

void quick_restore(CBus cbus)
{
	Bus *bus = static_cast<Bus *>(cbus.ptr);
	if (dumpedData.empty()) {
		return;
	}

	std::istringstream iss{dumpedData};
	bus->deserialize(iss);
}

void clear_shared_data()
{
	dumpedData.clear();
}
