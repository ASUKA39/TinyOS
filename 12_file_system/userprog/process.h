#ifndef __USERPROG_PROCESS_H 
#define __USERPROG_PROCESS_H 
#include "thread.h"
#define default_prio 31
#define USER_STACK3_VADDR  (0xc0000000 - 0x1000)
#define USER_VADDR_START 0x8048000
void create_user_vaddr_bitmap(struct task_struct* user_prog);
uint32_t* create_page_dir(void);
void start_process(void* filename_);
void intr_init(void* func);
void page_dir_activate(struct task_struct* p_thread);
void process_execute(void* filename, char* name);
void process_activate(struct task_struct* p_thread);
#endif