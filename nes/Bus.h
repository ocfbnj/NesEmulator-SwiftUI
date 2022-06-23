//
//  Bus.h
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/21.
//

#ifndef Bus_h
#define Bus_h

#ifdef __cplusplus
extern "C"
{
#endif

    struct CCartridge;

    struct CBus
    {
        void *ptr; // Bus*
    };

    struct CColor
    {
        unsigned char r;
        unsigned char g;
        unsigned char b;
        unsigned char a;
    };

    struct CFrame
    {
        struct CColor *data;
    };

    enum CJoypadButton
    {
        Right = 0b10000000,
        Left = 0b01000000,
        Down = 0b00100000,
        Up = 0b00010000,
        Start = 0b00001000,
        Select = 0b00000100,
        B = 0b00000010,
        A = 0b00000001,
    };

    typedef void (*sample_cb)(double);

    struct CBus alloc_bus();
    void free_bus(struct CBus cbus);

    void insert_cartridge(struct CBus cbus, struct CCartridge ccartridge);
    void set_sample_cb(struct CBus cbus, sample_cb cb);
    void power_up(struct CBus cbus);

    struct CFrame perform_once(struct CBus cbus);

    // Controller
    void press_button(struct CBus cbus, enum CJoypadButton btn);
    void release_button(struct CBus cbus, enum CJoypadButton btn);

#ifdef __cplusplus
}
#endif

#endif /* Bus_h */
