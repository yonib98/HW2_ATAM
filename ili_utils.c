#include <asm/desc.h>

void my_store_idt(struct desc_ptr *idtr) {
// <STUDENT FILL> - HINT: USE INLINE ASSEMBLY
asm("SIDT (%0);"
:
:"r"(idtr)
:
);
// </STUDENT FILL>
}

void my_load_idt(struct desc_ptr *idtr) {
// <STUDENT FILL> - HINT: USE INLINE ASSEMBLY
asm("LIDT (%0);"
:
:"r"(idtr)
:
);
// <STUDENT FILL>
}

void my_set_gate_offset(gate_desc *gate, unsigned long addr) {
// <STUDENT FILL> - HINT: NO NEED FOR INLINE ASSEMBLY
gate->offset_low= addr;
gate->offset_middle=addr>>16;
gate->offset_high=addr>>32;
// </STUDENT FILL>
}

unsigned long my_get_gate_offset(gate_desc *gate) {
// <STUDENT FILL> - HINT: NO NEED FOR INLINE ASSEMBLY
return (gate->offset_low)+((unsigned long)(gate->offset_middle)<<16) + ((unsigned long)(gate->offset_high)<<32);
// </STUDENT FILL>
}
