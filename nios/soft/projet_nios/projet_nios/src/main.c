#include "sys/alt_stdio.h"
#include "system.h"
#include "io.h"
#include <unistd.h>
#include "altera_avalon_pio_regs.h"

#include "sys/alt_irq.h"

#include <stdio.h>
#include <stdint.h>

void button_isr_handler(void *context)
{
    alt_printf("Button pressed!\n");
    /* Write to the edge capture register to reset it. */
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(BUTTONS_BASE, 0);
    /* reset interrupt capability for the Button PIO. */
    IOWR_ALTERA_AVALON_PIO_IRQ_MASK(BUTTONS_BASE, 1);
}
void button_setup_interrupt(void)
{
    IOWR_ALTERA_AVALON_PIO_IRQ_MASK(BUTTONS_BASE, 0x1);
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(BUTTONS_BASE, 0x0);
    alt_ic_isr_register(BUTTONS_IRQ_INTERRUPT_CONTROLLER_ID, BUTTONS_IRQ, button_isr_handler, NULL, NULL);
}
void read_avalon_slave()
{
    uint32_t reg, reg_byte_enable, read_count_at_2, read_count_at_3;
    reg = IORD_32DIRECT(U_AVALON_SLAVE_EXAMPLE_BASE, 0);
    reg_byte_enable = IORD_32DIRECT(U_AVALON_SLAVE_EXAMPLE_BASE, 4);
    read_count_at_2 = IORD_32DIRECT(U_AVALON_SLAVE_EXAMPLE_BASE, 8);
    read_count_at_3 = IORD_32DIRECT(U_AVALON_SLAVE_EXAMPLE_BASE, 12);
    printf("reg = %08lX\n", reg);
    printf("reg_byte_enable = %08lX\n", reg_byte_enable);
    printf("read_count(2) = %08lX\n", read_count_at_2);
    printf("read_count(3) = %08lX\n", read_count_at_3);
}
int main()
{
    int loop_count = 0;
    alt_putstr("Hello from Nios II!\n");
    button_setup_interrupt();
    while (1)
    {
        for (int i = 0; i < 8; i++)
        {
            IOWR_32DIRECT(LEDS_BASE, 0, 1 << i);
            usleep(100000);
        }
        for (int i = 0; i < 8; i++)
        {
            IOWR_32DIRECT(LEDS_BASE, 0, 0x80 >> i);
            usleep(100000);
        }
        printf("Loop Count = %d\n", loop_count);
        IOWR_32DIRECT(U_AVALON_SLAVE_EXAMPLE_BASE, 0, 0xCAFE0123);
        IOWR_32DIRECT(U_AVALON_SLAVE_EXAMPLE_BASE, 4, 0xCAFE0123);
        read_avalon_slave();
        printf("---------\n");
        IOWR_16DIRECT(U_AVALON_SLAVE_EXAMPLE_BASE, 0, 0xAAAA);
        IOWR_16DIRECT(U_AVALON_SLAVE_EXAMPLE_BASE, 4, 0xAAAA);
        read_avalon_slave();
        printf("---------\n");
        IOWR_8DIRECT(U_AVALON_SLAVE_EXAMPLE_BASE, 2, 0x55);
        IOWR_8DIRECT(U_AVALON_SLAVE_EXAMPLE_BASE, 6, 0x55);
        read_avalon_slave();
        printf("----------------------------------------\n");
    }
    return 0;
}
