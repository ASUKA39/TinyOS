#include "print.h"
#include "init.h"
#include "thread.h"
#include "interrupt.h"
#include "console.h"

#include "ioqueue.h"
#include "keyboard.h"

void k_thread_a(void*);
void k_thread_b(void*);
void u_prog_a(void);
void u_prog_b(void);
int test_var_a = 0, test_var_b = 0;

int main(void) {
   put_str("hello kernel!\n");
   init_all();
   thread_start("consumer_a", 31, k_thread_a, " A_");
   thread_start("consumer_b", 31, k_thread_b, " B_");
   process_execute(u_prog_a, "user_prog_a");
   process_execute(u_prog_b, "user_prog_b");
   intr_enable();
   while(1); 
   return 0;
}

void k_thread_a(void* arg) {     
   char* para = arg;
   // int i = 11451419;
   while(1) {
      // while(i--);
      console_put_str(" v_a:0x");
      console_put_int(test_var_a);
      // i = 11451419;
   }
}

void k_thread_b(void* arg) {     
   char* para = arg;
   // int i = 11451419;
   while(1) {
      // while(i--);
      console_put_str(" v_b:0x");
      console_put_int(test_var_b);
      // i = 11451419;
   }
}

void u_prog_a(void) {
   // int i = 11451419;
   while(1) {
      // while(i--);
      test_var_a++;
      // i = 11451419;
   }
}

void u_prog_b(void) {
   // int i = 11451419;
   while(1) {
      // while(i--);
      test_var_b++;
      // i = 11451419;
   }
}