
obj/mpos-kern:     file format elf32-i386

Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# MiniprocOS's kernel stack, then jumps to the 'start' routine in mpos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x200000, %esp
  10000c:	bc 00 00 20 00       	mov    $0x200000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 24 03 00 00       	call   10033d <start>
  100019:	90                   	nop    

0010001a <sys_int48_handler>:


# Interrupt handlers
.align 2

sys_int48_handler:
	pushl $0
  10001a:	6a 00                	push   $0x0
	pushl $48
  10001c:	6a 30                	push   $0x30
	jmp _generic_int_handler
  10001e:	eb 3a                	jmp    10005a <_generic_int_handler>

00100020 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $49
  100022:	6a 31                	push   $0x31
	jmp _generic_int_handler
  100024:	eb 34                	jmp    10005a <_generic_int_handler>

00100026 <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $50
  100028:	6a 32                	push   $0x32
	jmp _generic_int_handler
  10002a:	eb 2e                	jmp    10005a <_generic_int_handler>

0010002c <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $51
  10002e:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100030:	eb 28                	jmp    10005a <_generic_int_handler>

00100032 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $52
  100034:	6a 34                	push   $0x34
	jmp _generic_int_handler
  100036:	eb 22                	jmp    10005a <_generic_int_handler>

00100038 <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $53
  10003a:	6a 35                	push   $0x35
	jmp _generic_int_handler
  10003c:	eb 1c                	jmp    10005a <_generic_int_handler>

0010003e <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $54
  100040:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100042:	eb 16                	jmp    10005a <_generic_int_handler>

00100044 <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $55
  100046:	6a 37                	push   $0x37
	jmp _generic_int_handler
  100048:	eb 10                	jmp    10005a <_generic_int_handler>

0010004a <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $56
  10004c:	6a 38                	push   $0x38
	jmp _generic_int_handler
  10004e:	eb 0a                	jmp    10005a <_generic_int_handler>

00100050 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $57
  100052:	6a 39                	push   $0x39
	jmp _generic_int_handler
  100054:	eb 04                	jmp    10005a <_generic_int_handler>

00100056 <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	jmp _generic_int_handler
  100058:	eb 00                	jmp    10005a <_generic_int_handler>

0010005a <_generic_int_handler>:

_generic_int_handler:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the interrupt number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  10005a:	1e                   	push   %ds
	pushl %es
  10005b:	06                   	push   %es
	pushal
  10005c:	60                   	pusha  

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10005d:	54                   	push   %esp
	call interrupt
  10005e:	e8 e9 00 00 00       	call   10014c <interrupt>

00100063 <sys_int_handlers>:
  100063:	1a 00                	sbb    (%eax),%al
  100065:	10 00                	adc    %al,(%eax)
  100067:	20 00                	and    %al,(%eax)
  100069:	10 00                	adc    %al,(%eax)
  10006b:	26 00 10             	add    %dl,%es:(%eax)
  10006e:	00 2c 00             	add    %ch,(%eax,%eax,1)
  100071:	10 00                	adc    %al,(%eax)
  100073:	32 00                	xor    (%eax),%al
  100075:	10 00                	adc    %al,(%eax)
  100077:	38 00                	cmp    %al,(%eax)
  100079:	10 00                	adc    %al,(%eax)
  10007b:	3e 00 10             	add    %dl,%ds:(%eax)
  10007e:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  100082:	00 4a 00             	add    %cl,0x0(%edx)
  100085:	10 00                	adc    %al,(%eax)
  100087:	50                   	push   %eax
  100088:	00 10                	add    %dl,(%eax)
  10008a:	00 90 a1 80 97 10    	add    %dl,0x109780a1(%eax)

0010008c <schedule>:

void
schedule(void)
{
	pid_t pid = current->p_pid;
  10008c:	a1 80 97 10 00       	mov    0x109780,%eax
  100091:	57                   	push   %edi
  100092:	56                   	push   %esi
  100093:	53                   	push   %ebx
  100094:	8b 00                	mov    (%eax),%eax
	while (1) {
		pid = (pid + 1) % NPROCS;
  100096:	40                   	inc    %eax
  100097:	b9 10 00 00 00       	mov    $0x10,%ecx
  10009c:	99                   	cltd   
  10009d:	f7 f9                	idiv   %ecx
		if (proc_array[pid].p_state == P_RUNNABLE)
  10009f:	6b da 54             	imul   $0x54,%edx,%ebx
  1000a2:	89 d6                	mov    %edx,%esi
  1000a4:	89 d0                	mov    %edx,%eax
  1000a6:	8d bb cc 89 10 00    	lea    0x1089cc(%ebx),%edi
  1000ac:	8b 57 40             	mov    0x40(%edi),%edx
  1000af:	83 fa 01             	cmp    $0x1,%edx
  1000b2:	75 08                	jne    1000bc <schedule+0x30>
			run(&proc_array[pid]);
  1000b4:	83 ec 0c             	sub    $0xc,%esp
  1000b7:	e9 84 00 00 00       	jmp    100140 <schedule+0xb4>
        else if(proc_array[pid].p_state == P_BLOCKED)   //XIA: the process it is waiting have EXIT
  1000bc:	83 fa 02             	cmp    $0x2,%edx
  1000bf:	75 d5                	jne    100096 <schedule+0xa>
            if(proc_array[(proc_array[pid].wait_pid)].p_state == P_ZOMBIE)
  1000c1:	6b 93 c4 89 10 00 54 	imul   $0x54,0x1089c4(%ebx),%edx
  1000c8:	8d 8a cc 89 10 00    	lea    0x1089cc(%edx),%ecx
  1000ce:	83 79 40 03          	cmpl   $0x3,0x40(%ecx)
  1000d2:	75 c2                	jne    100096 <schedule+0xa>
            {
                proc_array[pid].p_registers.reg_eax = proc_array[proc_array[pid].wait_pid].p_exit_status;
  1000d4:	81 c2 c0 89 10 00    	add    $0x1089c0,%edx
		proc_array[proc_array[pid].wait_pid].p_state = P_EMPTY; //SK:set the zombie process's status as empty
		cursorpos = console_printf(cursorpos, 0x0700, "proc %d is now empty by schedule\n",proc_array[proc_array[pid].wait_pid]);
  1000da:	83 ec 54             	sub    $0x54,%esp
  1000dd:	8b 42 50             	mov    0x50(%edx),%eax
  1000e0:	c7 41 40 00 00 00 00 	movl   $0x0,0x40(%ecx)
  1000e7:	89 83 e4 89 10 00    	mov    %eax,0x1089e4(%ebx)
  1000ed:	89 e0                	mov    %esp,%eax
  1000ef:	6a 54                	push   $0x54
  1000f1:	52                   	push   %edx
  1000f2:	50                   	push   %eax
  1000f3:	e8 60 05 00 00       	call   100658 <memcpy>
  1000f8:	83 c4 0c             	add    $0xc,%esp
  1000fb:	68 9c 0b 10 00       	push   $0x100b9c
  100100:	68 00 07 00 00       	push   $0x700
  100105:	ff 35 00 00 06 00    	pushl  0x60000
  10010b:	e8 72 0a 00 00       	call   100b82 <console_printf>
		
		cursorpos = console_printf(cursorpos, 0x0700, "proc %d is now scheduled\n",pid);
  100110:	83 c4 60             	add    $0x60,%esp
  100113:	56                   	push   %esi
  100114:	68 be 0b 10 00       	push   $0x100bbe
  100119:	68 00 07 00 00       	push   $0x700
  10011e:	50                   	push   %eax
  10011f:	a3 00 00 06 00       	mov    %eax,0x60000
  100124:	e8 59 0a 00 00       	call   100b82 <console_printf>
		proc_array[pid].p_state = P_RUNNABLE;
  100129:	c7 47 40 01 00 00 00 	movl   $0x1,0x40(%edi)
		proc_array[pid].wait_pid = -1;
  100130:	c7 83 c4 89 10 00 ff 	movl   $0xffffffff,0x1089c4(%ebx)
  100137:	ff ff ff 
  10013a:	a3 00 00 06 00       	mov    %eax,0x60000
                run(&proc_array[pid]);
  10013f:	58                   	pop    %eax
  100140:	8d 83 c0 89 10 00    	lea    0x1089c0(%ebx),%eax
  100146:	50                   	push   %eax
  100147:	e8 87 03 00 00       	call   1004d3 <run>

0010014c <interrupt>:
  10014c:	55                   	push   %ebp
  10014d:	89 e5                	mov    %esp,%ebp
  10014f:	57                   	push   %edi
  100150:	56                   	push   %esi
  100151:	53                   	push   %ebx
  100152:	83 ec 10             	sub    $0x10,%esp
  100155:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100158:	8b 3d 80 97 10 00    	mov    0x109780,%edi
  10015e:	6a 44                	push   $0x44
  100160:	53                   	push   %ebx
  100161:	8d 47 08             	lea    0x8(%edi),%eax
  100164:	50                   	push   %eax
  100165:	e8 ee 04 00 00       	call   100658 <memcpy>
  10016a:	8b 43 28             	mov    0x28(%ebx),%eax
  10016d:	83 c4 10             	add    $0x10,%esp
  100170:	83 e8 30             	sub    $0x30,%eax
  100173:	83 f8 05             	cmp    $0x5,%eax
  100176:	0f 87 bf 01 00 00    	ja     10033b <interrupt+0x1ef>
  10017c:	ff 24 85 34 0c 10 00 	jmp    *0x100c34(,%eax,4)
  100183:	b8 01 00 00 00       	mov    $0x1,%eax
  100188:	eb 1e                	jmp    1001a8 <interrupt+0x5c>
  10018a:	8b 07                	mov    (%edi),%eax
  10018c:	83 ec 0c             	sub    $0xc,%esp
  10018f:	89 47 24             	mov    %eax,0x24(%edi)
  100192:	57                   	push   %edi
  100193:	e9 97 00 00 00       	jmp    10022f <interrupt+0xe3>
  100198:	6b d0 54             	imul   $0x54,%eax,%edx
  10019b:	83 ba 0c 8a 10 00 00 	cmpl   $0x0,0x108a0c(%edx)
  1001a2:	89 55 ec             	mov    %edx,0xffffffec(%ebp)
  1001a5:	74 0f                	je     1001b6 <interrupt+0x6a>
  1001a7:	40                   	inc    %eax
  1001a8:	83 f8 10             	cmp    $0x10,%eax
  1001ab:	75 eb                	jne    100198 <interrupt+0x4c>
  1001ad:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,0xfffffff0(%ebp)
  1001b4:	eb 6a                	jmp    100220 <interrupt+0xd4>
  1001b6:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
  1001b9:	40                   	inc    %eax
  1001ba:	74 64                	je     100220 <interrupt+0xd4>
  1001bc:	8b 75 ec             	mov    0xffffffec(%ebp),%esi
  1001bf:	8d 47 08             	lea    0x8(%edi),%eax
  1001c2:	51                   	push   %ecx
  1001c3:	6a 44                	push   $0x44
  1001c5:	50                   	push   %eax
  1001c6:	81 c6 c0 89 10 00    	add    $0x1089c0,%esi
  1001cc:	8d 56 08             	lea    0x8(%esi),%edx
  1001cf:	52                   	push   %edx
  1001d0:	e8 83 04 00 00       	call   100658 <memcpy>
  1001d5:	8b 4d ec             	mov    0xffffffec(%ebp),%ecx
  1001d8:	83 c4 0c             	add    $0xc,%esp
  1001db:	8b 07                	mov    (%edi),%eax
  1001dd:	8b 57 44             	mov    0x44(%edi),%edx
  1001e0:	8b 99 c0 89 10 00    	mov    0x1089c0(%ecx),%ebx
  1001e6:	c1 e0 12             	shl    $0x12,%eax
  1001e9:	05 00 00 28 00       	add    $0x280000,%eax
  1001ee:	29 d0                	sub    %edx,%eax
  1001f0:	c1 e3 12             	shl    $0x12,%ebx
  1001f3:	50                   	push   %eax
  1001f4:	81 c3 00 00 28 00    	add    $0x280000,%ebx
  1001fa:	29 c3                	sub    %eax,%ebx
  1001fc:	52                   	push   %edx
  1001fd:	53                   	push   %ebx
  1001fe:	e8 55 04 00 00       	call   100658 <memcpy>
  100203:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
  100206:	83 c4 10             	add    $0x10,%esp
  100209:	89 5e 44             	mov    %ebx,0x44(%esi)
  10020c:	c7 80 0c 8a 10 00 01 	movl   $0x1,0x108a0c(%eax)
  100213:	00 00 00 
  100216:	c7 80 e4 89 10 00 00 	movl   $0x0,0x1089e4(%eax)
  10021d:	00 00 00 
  100220:	8b 55 f0             	mov    0xfffffff0(%ebp),%edx
  100223:	83 ec 0c             	sub    $0xc,%esp
  100226:	89 57 24             	mov    %edx,0x24(%edi)
  100229:	ff 35 80 97 10 00    	pushl  0x109780
  10022f:	e8 9f 02 00 00       	call   1004d3 <run>
  100234:	e8 53 fe ff ff       	call   10008c <schedule>
  100239:	a1 80 97 10 00       	mov    0x109780,%eax
  10023e:	8b 50 24             	mov    0x24(%eax),%edx
  100241:	c7 40 4c 03 00 00 00 	movl   $0x3,0x4c(%eax)
  100248:	89 50 50             	mov    %edx,0x50(%eax)
  10024b:	e8 3c fe ff ff       	call   10008c <schedule>
  100250:	a1 80 97 10 00       	mov    0x109780,%eax
  100255:	8b 58 24             	mov    0x24(%eax),%ebx
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  100258:	cd 30                	int    $0x30
  10025a:	50                   	push   %eax
  10025b:	68 d8 0b 10 00       	push   $0x100bd8
  100260:	68 00 07 00 00       	push   $0x700
  100265:	ff 35 00 00 06 00    	pushl  0x60000
  10026b:	e8 12 09 00 00       	call   100b82 <console_printf>
  100270:	83 c4 10             	add    $0x10,%esp
  100273:	89 c7                	mov    %eax,%edi
  100275:	a3 00 00 06 00       	mov    %eax,0x60000
  10027a:	8d 43 ff             	lea    0xffffffff(%ebx),%eax
  10027d:	83 f8 0e             	cmp    $0xe,%eax
  100280:	77 1a                	ja     10029c <interrupt+0x150>
  100282:	8b 15 80 97 10 00    	mov    0x109780,%edx
  100288:	3b 1a                	cmp    (%edx),%ebx
  10028a:	74 10                	je     10029c <interrupt+0x150>
  10028c:	6b cb 54             	imul   $0x54,%ebx,%ecx
  10028f:	8d b1 cc 89 10 00    	lea    0x1089cc(%ecx),%esi
  100295:	8b 46 40             	mov    0x40(%esi),%eax
  100298:	85 c0                	test   %eax,%eax
  10029a:	75 0e                	jne    1002aa <interrupt+0x15e>
  10029c:	a1 80 97 10 00       	mov    0x109780,%eax
  1002a1:	c7 40 24 ff ff ff ff 	movl   $0xffffffff,0x24(%eax)
  1002a8:	eb 3a                	jmp    1002e4 <interrupt+0x198>
  1002aa:	83 f8 03             	cmp    $0x3,%eax
  1002ad:	75 2b                	jne    1002da <interrupt+0x18e>
  1002af:	8b 81 10 8a 10 00    	mov    0x108a10(%ecx),%eax
  1002b5:	c7 46 40 00 00 00 00 	movl   $0x0,0x40(%esi)
  1002bc:	89 42 24             	mov    %eax,0x24(%edx)
  1002bf:	53                   	push   %ebx
  1002c0:	68 eb 0b 10 00       	push   $0x100beb
  1002c5:	68 00 07 00 00       	push   $0x700
  1002ca:	57                   	push   %edi
  1002cb:	e8 b2 08 00 00       	call   100b82 <console_printf>
  1002d0:	83 c4 10             	add    $0x10,%esp
  1002d3:	a3 00 00 06 00       	mov    %eax,0x60000
  1002d8:	eb 0a                	jmp    1002e4 <interrupt+0x198>
  1002da:	c7 42 4c 02 00 00 00 	movl   $0x2,0x4c(%edx)
  1002e1:	89 5a 04             	mov    %ebx,0x4(%edx)
  1002e4:	e8 a3 fd ff ff       	call   10008c <schedule>
  1002e9:	8b 0d 80 97 10 00    	mov    0x109780,%ecx
  1002ef:	8b 51 24             	mov    0x24(%ecx),%edx
  1002f2:	8d 42 ff             	lea    0xffffffff(%edx),%eax
  1002f5:	83 f8 0e             	cmp    $0xe,%eax
  1002f8:	77 10                	ja     10030a <interrupt+0x1be>
  1002fa:	6b d2 54             	imul   $0x54,%edx,%edx
  1002fd:	8d 9a cc 89 10 00    	lea    0x1089cc(%edx),%ebx
  100303:	8b 43 40             	mov    0x40(%ebx),%eax
  100306:	85 c0                	test   %eax,%eax
  100308:	75 09                	jne    100313 <interrupt+0x1c7>
  10030a:	c7 41 24 ff ff ff ff 	movl   $0xffffffff,0x24(%ecx)
  100311:	eb 28                	jmp    10033b <interrupt+0x1ef>
  100313:	83 f8 03             	cmp    $0x3,%eax
  100316:	74 1c                	je     100334 <interrupt+0x1e8>
  100318:	8b 82 e4 89 10 00    	mov    0x1089e4(%edx),%eax
  10031e:	c7 43 40 03 00 00 00 	movl   $0x3,0x40(%ebx)
  100325:	c7 41 24 01 00 00 00 	movl   $0x1,0x24(%ecx)
  10032c:	89 82 10 8a 10 00    	mov    %eax,0x108a10(%edx)
  100332:	eb 07                	jmp    10033b <interrupt+0x1ef>
  100334:	c7 41 24 01 00 00 00 	movl   $0x1,0x24(%ecx)
  10033b:	eb fe                	jmp    10033b <interrupt+0x1ef>

0010033d <start>:
  10033d:	53                   	push   %ebx
  10033e:	83 ec 0c             	sub    $0xc,%esp
  100341:	68 40 05 00 00       	push   $0x540
  100346:	6a 00                	push   $0x0
  100348:	68 c0 89 10 00       	push   $0x1089c0
  10034d:	e8 6c 03 00 00       	call   1006be <memset>
  100352:	31 d2                	xor    %edx,%edx
  100354:	31 c0                	xor    %eax,%eax
  100356:	83 c4 10             	add    $0x10,%esp
  100359:	89 90 c0 89 10 00    	mov    %edx,0x1089c0(%eax)
  10035f:	42                   	inc    %edx
  100360:	c7 80 0c 8a 10 00 00 	movl   $0x0,0x108a0c(%eax)
  100367:	00 00 00 
  10036a:	c7 80 c4 89 10 00 ff 	movl   $0xffffffff,0x1089c4(%eax)
  100371:	ff ff ff 
  100374:	83 c0 54             	add    $0x54,%eax
  100377:	83 fa 10             	cmp    $0x10,%edx
  10037a:	75 dd                	jne    100359 <start+0x1c>
  10037c:	c7 05 80 97 10 00 14 	movl   $0x108a14,0x109780
  100383:	8a 10 00 
  100386:	e8 71 00 00 00       	call   1003fc <segments_init>
  10038b:	83 ec 0c             	sub    $0xc,%esp
  10038e:	ff 35 80 97 10 00    	pushl  0x109780
  100394:	e8 51 01 00 00       	call   1004ea <special_registers_init>
  100399:	e8 d4 01 00 00       	call   100572 <console_clear>
  10039e:	83 c4 0c             	add    $0xc,%esp
  1003a1:	68 01 0c 10 00       	push   $0x100c01
  1003a6:	68 00 07 00 00       	push   $0x700
  1003ab:	ff 35 00 00 06 00    	pushl  0x60000
  1003b1:	e8 cc 07 00 00       	call   100b82 <console_printf>
  1003b6:	83 c4 10             	add    $0x10,%esp
  1003b9:	a3 00 00 06 00       	mov    %eax,0x60000
  1003be:	e8 59 01 00 00       	call   10051c <console_read_digit>
  1003c3:	8d 58 ff             	lea    0xffffffff(%eax),%ebx
  1003c6:	83 fb 01             	cmp    $0x1,%ebx
  1003c9:	77 f3                	ja     1003be <start+0x81>
  1003cb:	e8 a2 01 00 00       	call   100572 <console_clear>
  1003d0:	50                   	push   %eax
  1003d1:	50                   	push   %eax
  1003d2:	a1 80 97 10 00       	mov    0x109780,%eax
  1003d7:	83 c0 38             	add    $0x38,%eax
  1003da:	50                   	push   %eax
  1003db:	53                   	push   %ebx
  1003dc:	e8 d7 01 00 00       	call   1005b8 <program_loader>
  1003e1:	a1 80 97 10 00       	mov    0x109780,%eax
  1003e6:	c7 40 44 00 00 2c 00 	movl   $0x2c0000,0x44(%eax)
  1003ed:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
  1003f4:	89 04 24             	mov    %eax,(%esp)
  1003f7:	e8 d7 00 00 00       	call   1004d3 <run>

001003fc <segments_init>:
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003fc:	b8 00 8f 10 00       	mov    $0x108f00,%eax
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100401:	31 d2                	xor    %edx,%edx
  100403:	66 a3 4a 10 10 00    	mov    %ax,0x10104a
  100409:	c1 e8 10             	shr    $0x10,%eax
  10040c:	a2 4c 10 10 00       	mov    %al,0x10104c
  100411:	c1 e8 08             	shr    $0x8,%eax
  100414:	66 c7 05 48 10 10 00 	movw   $0x68,0x101048
  10041b:	68 00 
  10041d:	c6 05 4e 10 10 00 40 	movb   $0x40,0x10104e
  100424:	a2 4f 10 10 00       	mov    %al,0x10104f
  100429:	c6 05 4d 10 10 00 89 	movb   $0x89,0x10104d
  100430:	c7 05 04 8f 10 00 00 	movl   $0x80000,0x108f04
  100437:	00 08 00 
  10043a:	66 c7 05 08 8f 10 00 	movw   $0x10,0x108f08
  100441:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100443:	b8 56 00 10 00       	mov    $0x100056,%eax
  100448:	66 89 04 d5 80 8f 10 	mov    %ax,0x108f80(,%edx,8)
  10044f:	00 
  100450:	c1 e8 10             	shr    $0x10,%eax
  100453:	66 c7 04 d5 82 8f 10 	movw   $0x8,0x108f82(,%edx,8)
  10045a:	00 08 00 
  10045d:	c6 04 d5 84 8f 10 00 	movb   $0x0,0x108f84(,%edx,8)
  100464:	00 
  100465:	c6 04 d5 85 8f 10 00 	movb   $0x8e,0x108f85(,%edx,8)
  10046c:	8e 
  10046d:	66 89 04 d5 86 8f 10 	mov    %ax,0x108f86(,%edx,8)
  100474:	00 
  100475:	42                   	inc    %edx
  100476:	81 fa 00 01 00 00    	cmp    $0x100,%edx
  10047c:	75 c5                	jne    100443 <segments_init+0x47>
  10047e:	66 ba 30 00          	mov    $0x30,%dx
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100482:	8b 04 95 a3 ff 0f 00 	mov    0xfffa3(,%edx,4),%eax
  100489:	66 c7 04 d5 82 8f 10 	movw   $0x8,0x108f82(,%edx,8)
  100490:	00 08 00 
  100493:	c6 04 d5 84 8f 10 00 	movb   $0x0,0x108f84(,%edx,8)
  10049a:	00 
  10049b:	c6 04 d5 85 8f 10 00 	movb   $0xee,0x108f85(,%edx,8)
  1004a2:	ee 
  1004a3:	66 89 04 d5 80 8f 10 	mov    %ax,0x108f80(,%edx,8)
  1004aa:	00 
  1004ab:	c1 e8 10             	shr    $0x10,%eax
  1004ae:	66 89 04 d5 86 8f 10 	mov    %ax,0x108f86(,%edx,8)
  1004b5:	00 
  1004b6:	42                   	inc    %edx
  1004b7:	83 fa 3a             	cmp    $0x3a,%edx
  1004ba:	75 c6                	jne    100482 <segments_init+0x86>
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_GETPID], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1004bc:	b8 28 00 00 00       	mov    $0x28,%eax
  1004c1:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  1004c8:	0f 00 d8             	ltr    %ax
  1004cb:	0f 01 1d 06 10 10 00 	lidtl  0x101006
		     "ltr %0\n\t"
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1004d2:	c3                   	ret    

001004d3 <run>:



/*****************************************************************************
 * special_registers_init
 *
 *   Set up the first process's registers to required values.  In particular,
 *   tell the first process to use the memory information set up by
 *   segments_init().
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
	memset(&proc->p_registers, 0, sizeof(registers_t));
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
}



/*****************************************************************************
 * console_clear
 *
 *   Clear the console by writing spaces to it, and move the cursor to the
 *   upper left (row 0, column 0).
 *
 *****************************************************************************/

void
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}



/*****************************************************************************
 * console_read_digit
 *
 *   Read a single digit from the keyboard and return it.
 *
 *****************************************************************************/

#define KBSTATP 0x64
#define KBS_DIB 0x01
#define KBDATAP 0x60

int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
		return data - 0x02 + 1;
	else if (data == 0x0B)
		return 0;
	else if (data >= 0x47 && data <= 0x49)
		return data - 0x47 + 7;
	else if (data >= 0x4B && data <= 0x4D)
		return data - 0x4B + 4;
	else if (data >= 0x4F && data <= 0x51)
		return data - 0x4F + 1;
	else if (data == 0x53)
		return 0;
	else
		return -1;
}


/*****************************************************************************
 * run
 *
 *   Run the process with the supplied process descriptor.
 *   This means reloading all the relevant registers from the descriptor's
 *   p_registers member, using the 'popal', 'popl', and 'iret'
 *   instructions.
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1004d3:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1004d7:	a3 80 97 10 00       	mov    %eax,0x109780

	asm volatile("movl %0,%%esp\n\t"
  1004dc:	83 c0 08             	add    $0x8,%eax
  1004df:	89 c4                	mov    %eax,%esp
  1004e1:	61                   	popa   
  1004e2:	07                   	pop    %es
  1004e3:	1f                   	pop    %ds
  1004e4:	83 c4 08             	add    $0x8,%esp
  1004e7:	cf                   	iret   
  1004e8:	eb fe                	jmp    1004e8 <run+0x15>

001004ea <special_registers_init>:
  1004ea:	53                   	push   %ebx
  1004eb:	83 ec 0c             	sub    $0xc,%esp
  1004ee:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  1004f2:	6a 44                	push   $0x44
  1004f4:	6a 00                	push   $0x0
  1004f6:	8d 43 08             	lea    0x8(%ebx),%eax
  1004f9:	50                   	push   %eax
  1004fa:	e8 bf 01 00 00       	call   1006be <memset>
  1004ff:	66 c7 43 3c 1b 00    	movw   $0x1b,0x3c(%ebx)
  100505:	66 c7 43 2c 23 00    	movw   $0x23,0x2c(%ebx)
  10050b:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
  100511:	66 c7 43 48 23 00    	movw   $0x23,0x48(%ebx)
  100517:	83 c4 18             	add    $0x18,%esp
  10051a:	5b                   	pop    %ebx
  10051b:	c3                   	ret    

0010051c <console_read_digit>:
static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10051c:	ba 64 00 00 00       	mov    $0x64,%edx
  100521:	ec                   	in     (%dx),%al
  100522:	a8 01                	test   $0x1,%al
  100524:	74 45                	je     10056b <console_read_digit+0x4f>
static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100526:	b2 60                	mov    $0x60,%dl
  100528:	ec                   	in     (%dx),%al
  100529:	88 c2                	mov    %al,%dl
  10052b:	8d 42 fe             	lea    0xfffffffe(%edx),%eax
  10052e:	3c 08                	cmp    $0x8,%al
  100530:	77 05                	ja     100537 <console_read_digit+0x1b>
  100532:	0f b6 c2             	movzbl %dl,%eax
  100535:	48                   	dec    %eax
  100536:	c3                   	ret    
  100537:	80 fa 0b             	cmp    $0xb,%dl
  10053a:	74 33                	je     10056f <console_read_digit+0x53>
  10053c:	8d 42 b9             	lea    0xffffffb9(%edx),%eax
  10053f:	3c 02                	cmp    $0x2,%al
  100541:	77 07                	ja     10054a <console_read_digit+0x2e>
  100543:	0f b6 c2             	movzbl %dl,%eax
  100546:	83 e8 40             	sub    $0x40,%eax
  100549:	c3                   	ret    
  10054a:	8d 42 b5             	lea    0xffffffb5(%edx),%eax
  10054d:	3c 02                	cmp    $0x2,%al
  10054f:	77 07                	ja     100558 <console_read_digit+0x3c>
  100551:	0f b6 c2             	movzbl %dl,%eax
  100554:	83 e8 47             	sub    $0x47,%eax
  100557:	c3                   	ret    
  100558:	8d 42 b1             	lea    0xffffffb1(%edx),%eax
  10055b:	3c 02                	cmp    $0x2,%al
  10055d:	77 07                	ja     100566 <console_read_digit+0x4a>
  10055f:	0f b6 c2             	movzbl %dl,%eax
  100562:	83 e8 4e             	sub    $0x4e,%eax
  100565:	c3                   	ret    
  100566:	80 fa 53             	cmp    $0x53,%dl
  100569:	74 04                	je     10056f <console_read_digit+0x53>
  10056b:	83 c8 ff             	or     $0xffffffff,%eax
  10056e:	c3                   	ret    
  10056f:	31 c0                	xor    %eax,%eax
  100571:	c3                   	ret    

00100572 <console_clear>:
  100572:	56                   	push   %esi
  100573:	31 c0                	xor    %eax,%eax
  100575:	53                   	push   %ebx
  100576:	c7 05 00 00 06 00 00 	movl   $0xb8000,0x60000
  10057d:	80 0b 00 
  100580:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
  100587:	00 20 07 
  10058a:	40                   	inc    %eax
  10058b:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  100590:	75 ee                	jne    100580 <console_clear+0xe>

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100592:	bb d4 03 00 00       	mov    $0x3d4,%ebx
  100597:	b0 0e                	mov    $0xe,%al
  100599:	89 da                	mov    %ebx,%edx
  10059b:	ee                   	out    %al,(%dx)
  10059c:	31 c9                	xor    %ecx,%ecx
  10059e:	be d5 03 00 00       	mov    $0x3d5,%esi
  1005a3:	88 c8                	mov    %cl,%al
  1005a5:	89 f2                	mov    %esi,%edx
  1005a7:	ee                   	out    %al,(%dx)
  1005a8:	b0 0f                	mov    $0xf,%al
  1005aa:	89 da                	mov    %ebx,%edx
  1005ac:	ee                   	out    %al,(%dx)
  1005ad:	88 c8                	mov    %cl,%al
  1005af:	89 f2                	mov    %esi,%edx
  1005b1:	ee                   	out    %al,(%dx)
  1005b2:	5b                   	pop    %ebx
  1005b3:	5e                   	pop    %esi
  1005b4:	c3                   	ret    
  1005b5:	90                   	nop    
  1005b6:	90                   	nop    
  1005b7:	90                   	nop    

001005b8 <program_loader>:
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1005b8:	55                   	push   %ebp
  1005b9:	57                   	push   %edi
  1005ba:	56                   	push   %esi
  1005bb:	53                   	push   %ebx
  1005bc:	83 ec 0c             	sub    $0xc,%esp
  1005bf:	8b 44 24 20          	mov    0x20(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1005c3:	85 c0                	test   %eax,%eax
  1005c5:	78 05                	js     1005cc <program_loader+0x14>
  1005c7:	83 f8 01             	cmp    $0x1,%eax
  1005ca:	7e 0b                	jle    1005d7 <program_loader+0x1f>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
		if (ph->p_type == ELF_PROG_LOAD)
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
}

// Copy 'filesz' bytes starting at address 'data' into virtual address 'dst',
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
}

static void
loader_panic(void)
{
	*((uint16_t *) 0xB8000) = '!' | 0x700;
  1005cc:	66 c7 05 00 80 0b 00 	movw   $0x721,0xb8000
  1005d3:	21 07 
  1005d5:	eb fe                	jmp    1005d5 <program_loader+0x1d>
  1005d7:	8b 3c c5 50 10 10 00 	mov    0x101050(,%eax,8),%edi
  1005de:	81 3f 7f 45 4c 46    	cmpl   $0x464c457f,(%edi)
  1005e4:	74 0b                	je     1005f1 <program_loader+0x39>
  1005e6:	66 c7 05 00 80 0b 00 	movw   $0x721,0xb8000
  1005ed:	21 07 
  1005ef:	eb fe                	jmp    1005ef <program_loader+0x37>
  1005f1:	0f b7 47 2c          	movzwl 0x2c(%edi),%eax
  1005f5:	89 fb                	mov    %edi,%ebx
  1005f7:	03 5f 1c             	add    0x1c(%edi),%ebx
  1005fa:	c1 e0 05             	shl    $0x5,%eax
  1005fd:	8d 04 03             	lea    (%ebx,%eax,1),%eax
  100600:	89 44 24 08          	mov    %eax,0x8(%esp)
  100604:	eb 39                	jmp    10063f <program_loader+0x87>
  100606:	83 3b 01             	cmpl   $0x1,(%ebx)
  100609:	75 31                	jne    10063c <program_loader+0x84>
  10060b:	8b 43 08             	mov    0x8(%ebx),%eax
  10060e:	89 c6                	mov    %eax,%esi
  100610:	89 c5                	mov    %eax,%ebp
  100612:	03 73 10             	add    0x10(%ebx),%esi
  100615:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  10061a:	03 6b 14             	add    0x14(%ebx),%ebp
  10061d:	52                   	push   %edx
  10061e:	89 f2                	mov    %esi,%edx
  100620:	29 c2                	sub    %eax,%edx
  100622:	52                   	push   %edx
  100623:	89 fa                	mov    %edi,%edx
  100625:	03 53 04             	add    0x4(%ebx),%edx
  100628:	52                   	push   %edx
  100629:	50                   	push   %eax
  10062a:	e8 29 00 00 00       	call   100658 <memcpy>
  10062f:	83 c4 10             	add    $0x10,%esp
  100632:	eb 04                	jmp    100638 <program_loader+0x80>
  100634:	c6 06 00             	movb   $0x0,(%esi)
  100637:	46                   	inc    %esi
  100638:	39 ee                	cmp    %ebp,%esi
  10063a:	72 f8                	jb     100634 <program_loader+0x7c>
  10063c:	83 c3 20             	add    $0x20,%ebx
  10063f:	3b 5c 24 08          	cmp    0x8(%esp),%ebx
  100643:	72 c1                	jb     100606 <program_loader+0x4e>
  100645:	8b 57 18             	mov    0x18(%edi),%edx
  100648:	8b 44 24 24          	mov    0x24(%esp),%eax
  10064c:	89 10                	mov    %edx,(%eax)
  10064e:	83 c4 0c             	add    $0xc,%esp
  100651:	5b                   	pop    %ebx
  100652:	5e                   	pop    %esi
  100653:	5f                   	pop    %edi
  100654:	5d                   	pop    %ebp
  100655:	c3                   	ret    
  100656:	90                   	nop    
  100657:	90                   	nop    

00100658 <memcpy>:
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100658:	53                   	push   %ebx
  100659:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  10065d:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  100661:	8b 54 24 08          	mov    0x8(%esp),%edx
  100665:	eb 06                	jmp    10066d <memcpy+0x15>
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
		*d++ = *s++;
  100667:	8a 41 ff             	mov    0xffffffff(%ecx),%al
  10066a:	88 42 ff             	mov    %al,0xffffffff(%edx)
  10066d:	4b                   	dec    %ebx
  10066e:	41                   	inc    %ecx
  10066f:	42                   	inc    %edx
  100670:	83 fb ff             	cmp    $0xffffffff,%ebx
  100673:	75 f2                	jne    100667 <memcpy+0xf>
	return dst;
}
  100675:	8b 44 24 08          	mov    0x8(%esp),%eax
  100679:	5b                   	pop    %ebx
  10067a:	c3                   	ret    

0010067b <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  10067b:	56                   	push   %esi
  10067c:	53                   	push   %ebx
  10067d:	8b 74 24 0c          	mov    0xc(%esp),%esi
  100681:	8b 44 24 10          	mov    0x10(%esp),%eax
  100685:	8b 54 24 14          	mov    0x14(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100689:	39 f0                	cmp    %esi,%eax
  10068b:	73 0a                	jae    100697 <memmove+0x1c>
  10068d:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
  100690:	39 f3                	cmp    %esi,%ebx
		s += n, d += n;
  100692:	8d 0c 16             	lea    (%esi,%edx,1),%ecx
  100695:	77 0c                	ja     1006a3 <memmove+0x28>
  100697:	89 c3                	mov    %eax,%ebx
  100699:	89 f1                	mov    %esi,%ecx
  10069b:	eb 14                	jmp    1006b1 <memmove+0x36>
		while (n-- > 0)
			*--d = *--s;
  10069d:	4b                   	dec    %ebx
  10069e:	49                   	dec    %ecx
  10069f:	8a 03                	mov    (%ebx),%al
  1006a1:	88 01                	mov    %al,(%ecx)
  1006a3:	4a                   	dec    %edx
  1006a4:	83 fa ff             	cmp    $0xffffffff,%edx
  1006a7:	75 f4                	jne    10069d <memmove+0x22>
  1006a9:	eb 0e                	jmp    1006b9 <memmove+0x3e>
	} else
		while (n-- > 0)
			*d++ = *s++;
  1006ab:	8a 43 ff             	mov    0xffffffff(%ebx),%al
  1006ae:	88 41 ff             	mov    %al,0xffffffff(%ecx)
  1006b1:	4a                   	dec    %edx
  1006b2:	43                   	inc    %ebx
  1006b3:	41                   	inc    %ecx
  1006b4:	83 fa ff             	cmp    $0xffffffff,%edx
  1006b7:	75 f2                	jne    1006ab <memmove+0x30>
	return dst;
}
  1006b9:	89 f0                	mov    %esi,%eax
  1006bb:	5b                   	pop    %ebx
  1006bc:	5e                   	pop    %esi
  1006bd:	c3                   	ret    

001006be <memset>:

void *
memset(void *v, int c, size_t n)
{
  1006be:	53                   	push   %ebx
  1006bf:	8b 44 24 08          	mov    0x8(%esp),%eax
  1006c3:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1006c7:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  1006cb:	89 c2                	mov    %eax,%edx
  1006cd:	eb 03                	jmp    1006d2 <memset+0x14>
	char *p = (char *) v;
	while (n-- > 0)
		*p++ = c;
  1006cf:	88 5a ff             	mov    %bl,0xffffffff(%edx)
  1006d2:	49                   	dec    %ecx
  1006d3:	42                   	inc    %edx
  1006d4:	83 f9 ff             	cmp    $0xffffffff,%ecx
  1006d7:	75 f6                	jne    1006cf <memset+0x11>
	return v;
}
  1006d9:	5b                   	pop    %ebx
  1006da:	c3                   	ret    

001006db <strlen>:

size_t
strlen(const char *s)
{
  1006db:	8b 54 24 04          	mov    0x4(%esp),%edx
  1006df:	31 c0                	xor    %eax,%eax
  1006e1:	eb 01                	jmp    1006e4 <strlen+0x9>
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1006e3:	40                   	inc    %eax
  1006e4:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1006e8:	75 f9                	jne    1006e3 <strlen+0x8>
	return n;
}
  1006ea:	c3                   	ret    

001006eb <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1006eb:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1006ef:	31 c0                	xor    %eax,%eax
  1006f1:	8b 54 24 08          	mov    0x8(%esp),%edx
  1006f5:	eb 01                	jmp    1006f8 <strnlen+0xd>
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1006f7:	40                   	inc    %eax
  1006f8:	39 d0                	cmp    %edx,%eax
  1006fa:	74 06                	je     100702 <strnlen+0x17>
  1006fc:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100700:	75 f5                	jne    1006f7 <strnlen+0xc>
	return n;
}
  100702:	c3                   	ret    

00100703 <console_putc>:


/*****************************************************************************
 * console_vprintf
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100703:	57                   	push   %edi
  100704:	89 cf                	mov    %ecx,%edi
  100706:	56                   	push   %esi
  100707:	53                   	push   %ebx
  100708:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  10070a:	81 fb 9f 8f 0b 00    	cmp    $0xb8f9f,%ebx
  100710:	88 d0                	mov    %dl,%al
  100712:	76 05                	jbe    100719 <console_putc+0x16>
  100714:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100719:	3c 0a                	cmp    $0xa,%al
  10071b:	75 2f                	jne    10074c <console_putc+0x49>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10071d:	8d 83 00 80 f4 ff    	lea    0xfff48000(%ebx),%eax
  100723:	be 50 00 00 00       	mov    $0x50,%esi
  100728:	d1 f8                	sar    %eax
  10072a:	89 d9                	mov    %ebx,%ecx
  10072c:	99                   	cltd   
  10072d:	f7 fe                	idiv   %esi
  10072f:	89 d6                	mov    %edx,%esi
  100731:	eb 0a                	jmp    10073d <console_putc+0x3a>
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100733:	89 f8                	mov    %edi,%eax
  100735:	42                   	inc    %edx
  100736:	83 c8 20             	or     $0x20,%eax
  100739:	66 89 41 fe          	mov    %ax,0xfffffffe(%ecx)
  10073d:	83 c1 02             	add    $0x2,%ecx
  100740:	83 fa 50             	cmp    $0x50,%edx
  100743:	75 ee                	jne    100733 <console_putc+0x30>
  100745:	29 f2                	sub    %esi,%edx
  100747:	8d 04 53             	lea    (%ebx,%edx,2),%eax
  10074a:	eb 0c                	jmp    100758 <console_putc+0x55>
	} else
		*cursor++ = c | color;
  10074c:	66 0f b6 c0          	movzbw %al,%ax
  100750:	09 f8                	or     %edi,%eax
  100752:	66 89 03             	mov    %ax,(%ebx)
  100755:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100758:	5b                   	pop    %ebx
  100759:	5e                   	pop    %esi
  10075a:	5f                   	pop    %edi
  10075b:	c3                   	ret    

0010075c <fill_numbuf>:

static const char upper_digits[] = "0123456789ABCDEF";
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10075c:	57                   	push   %edi
  10075d:	56                   	push   %esi
  10075e:	89 ce                	mov    %ecx,%esi
  100760:	53                   	push   %ebx
  100761:	8b 7c 24 10          	mov    0x10(%esp),%edi
	*--numbuf_end = '\0';
  100765:	8d 58 ff             	lea    0xffffffff(%eax),%ebx
  100768:	c6 40 ff 00          	movb   $0x0,0xffffffff(%eax)
	if (precision != 0 || val != 0)
  10076c:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100771:	75 04                	jne    100777 <fill_numbuf+0x1b>
  100773:	85 d2                	test   %edx,%edx
  100775:	74 12                	je     100789 <fill_numbuf+0x2d>
		do {
			*--numbuf_end = digits[val % base];
  100777:	89 d0                	mov    %edx,%eax
  100779:	31 d2                	xor    %edx,%edx
  10077b:	f7 f6                	div    %esi
  10077d:	4b                   	dec    %ebx
  10077e:	89 c1                	mov    %eax,%ecx
  100780:	8a 04 17             	mov    (%edi,%edx,1),%al
			val /= base;
  100783:	89 ca                	mov    %ecx,%edx
  100785:	88 03                	mov    %al,(%ebx)
  100787:	eb ea                	jmp    100773 <fill_numbuf+0x17>
		} while (val != 0);
	return numbuf_end;
}
  100789:	89 d8                	mov    %ebx,%eax
  10078b:	5b                   	pop    %ebx
  10078c:	5e                   	pop    %esi
  10078d:	5f                   	pop    %edi
  10078e:	c3                   	ret    

0010078f <console_vprintf>:

#define FLAG_ALT		(1<<0)
#define FLAG_ZERO		(1<<1)
#define FLAG_LEFTJUSTIFY	(1<<2)
#define FLAG_SPACEPOSITIVE	(1<<3)
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10078f:	55                   	push   %ebp
  100790:	57                   	push   %edi
  100791:	56                   	push   %esi
  100792:	53                   	push   %ebx
  100793:	83 ec 3c             	sub    $0x3c,%esp
  100796:	8b 6c 24 58          	mov    0x58(%esp),%ebp
  10079a:	8b 7c 24 5c          	mov    0x5c(%esp),%edi
  10079e:	e9 b1 03 00 00       	jmp    100b54 <console_vprintf+0x3c5>
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
		if (*format != '%') {
  1007a3:	3c 25                	cmp    $0x25,%al
  1007a5:	74 19                	je     1007c0 <console_vprintf+0x31>
			cursor = console_putc(cursor, *format, color);
  1007a7:	0f b6 d0             	movzbl %al,%edx
  1007aa:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  1007ae:	8b 44 24 50          	mov    0x50(%esp),%eax
  1007b2:	e8 4c ff ff ff       	call   100703 <console_putc>
  1007b7:	89 44 24 50          	mov    %eax,0x50(%esp)
  1007bb:	e9 93 03 00 00       	jmp    100b53 <console_vprintf+0x3c4>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007c0:	45                   	inc    %ebp
  1007c1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1007c8:	eb 1c                	jmp    1007e6 <console_vprintf+0x57>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1007ca:	41                   	inc    %ecx
  1007cb:	8a 01                	mov    (%ecx),%al
  1007cd:	84 c0                	test   %al,%al
  1007cf:	74 27                	je     1007f8 <console_vprintf+0x69>
  1007d1:	38 d0                	cmp    %dl,%al
  1007d3:	75 f5                	jne    1007ca <console_vprintf+0x3b>
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  1007d5:	81 e9 4c 0c 10 00    	sub    $0x100c4c,%ecx
  1007db:	b8 01 00 00 00       	mov    $0x1,%eax
  1007e0:	d3 e0                	shl    %cl,%eax
  1007e2:	45                   	inc    %ebp
  1007e3:	09 04 24             	or     %eax,(%esp)
  1007e6:	8a 55 00             	mov    0x0(%ebp),%dl
  1007e9:	84 d2                	test   %dl,%dl
  1007eb:	0f 84 70 03 00 00    	je     100b61 <console_vprintf+0x3d2>
  1007f1:	b9 4c 0c 10 00       	mov    $0x100c4c,%ecx
  1007f6:	eb d3                	jmp    1007cb <console_vprintf+0x3c>
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1007f8:	8d 42 cf             	lea    0xffffffcf(%edx),%eax
  1007fb:	3c 08                	cmp    $0x8,%al
  1007fd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100804:	00 
  100805:	76 13                	jbe    10081a <console_vprintf+0x8b>
  100807:	eb 1d                	jmp    100826 <console_vprintf+0x97>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100809:	6b 44 24 04 0a       	imul   $0xa,0x4(%esp),%eax
  10080e:	0f be d2             	movsbl %dl,%edx
  100811:	45                   	inc    %ebp
  100812:	8d 54 02 d0          	lea    0xffffffd0(%edx,%eax,1),%edx
  100816:	89 54 24 04          	mov    %edx,0x4(%esp)
  10081a:	8a 55 00             	mov    0x0(%ebp),%dl
  10081d:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  100820:	3c 09                	cmp    $0x9,%al
  100822:	76 e5                	jbe    100809 <console_vprintf+0x7a>
  100824:	eb 18                	jmp    10083e <console_vprintf+0xaf>
		} else if (*format == '*') {
  100826:	80 fa 2a             	cmp    $0x2a,%dl
  100829:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  100830:	ff 
  100831:	75 0b                	jne    10083e <console_vprintf+0xaf>
			width = va_arg(val, int);
  100833:	83 c7 04             	add    $0x4,%edi
			++format;
  100836:	45                   	inc    %ebp
  100837:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  10083a:	89 44 24 04          	mov    %eax,0x4(%esp)
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10083e:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
  100845:	ff 
  100846:	80 7d 00 2e          	cmpb   $0x2e,0x0(%ebp)
  10084a:	75 4f                	jne    10089b <console_vprintf+0x10c>
			++format;
  10084c:	45                   	inc    %ebp
			if (*format >= '0' && *format <= '9') {
  10084d:	8a 55 00             	mov    0x0(%ebp),%dl
  100850:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  100853:	3c 09                	cmp    $0x9,%al
  100855:	77 25                	ja     10087c <console_vprintf+0xed>
  100857:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10085e:	00 
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10085f:	6b 44 24 08 0a       	imul   $0xa,0x8(%esp),%eax
  100864:	0f be d2             	movsbl %dl,%edx
  100867:	45                   	inc    %ebp
  100868:	8d 54 10 d0          	lea    0xffffffd0(%eax,%edx,1),%edx
  10086c:	89 54 24 08          	mov    %edx,0x8(%esp)
  100870:	8a 55 00             	mov    0x0(%ebp),%dl
  100873:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  100876:	3c 09                	cmp    $0x9,%al
  100878:	77 12                	ja     10088c <console_vprintf+0xfd>
  10087a:	eb e3                	jmp    10085f <console_vprintf+0xd0>
			} else if (*format == '*') {
  10087c:	80 fa 2a             	cmp    $0x2a,%dl
  10087f:	75 12                	jne    100893 <console_vprintf+0x104>
				precision = va_arg(val, int);
  100881:	83 c7 04             	add    $0x4,%edi
				++format;
  100884:	45                   	inc    %ebp
  100885:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  100888:	89 54 24 08          	mov    %edx,0x8(%esp)
			}
			if (precision < 0)
  10088c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100891:	79 08                	jns    10089b <console_vprintf+0x10c>
  100893:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10089a:	00 
				precision = 0;
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10089b:	8a 45 00             	mov    0x0(%ebp),%al
  10089e:	3c 64                	cmp    $0x64,%al
  1008a0:	74 34                	je     1008d6 <console_vprintf+0x147>
  1008a2:	7f 1d                	jg     1008c1 <console_vprintf+0x132>
  1008a4:	3c 58                	cmp    $0x58,%al
  1008a6:	0f 84 bd 00 00 00    	je     100969 <console_vprintf+0x1da>
  1008ac:	3c 63                	cmp    $0x63,%al
  1008ae:	0f 84 eb 00 00 00    	je     10099f <console_vprintf+0x210>
  1008b4:	3c 43                	cmp    $0x43,%al
  1008b6:	0f 85 06 01 00 00    	jne    1009c2 <console_vprintf+0x233>
  1008bc:	e9 cf 00 00 00       	jmp    100990 <console_vprintf+0x201>
  1008c1:	3c 75                	cmp    $0x75,%al
  1008c3:	74 5c                	je     100921 <console_vprintf+0x192>
  1008c5:	3c 78                	cmp    $0x78,%al
  1008c7:	74 6e                	je     100937 <console_vprintf+0x1a8>
  1008c9:	3c 73                	cmp    $0x73,%al
  1008cb:	0f 85 f1 00 00 00    	jne    1009c2 <console_vprintf+0x233>
  1008d1:	e9 a4 00 00 00       	jmp    10097a <console_vprintf+0x1eb>
		case 'd': {
			int x = va_arg(val, int);
  1008d6:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1008d9:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008de:	8b 5f fc             	mov    0xfffffffc(%edi),%ebx
  1008e1:	ff 74 24 08          	pushl  0x8(%esp)
  1008e5:	89 d8                	mov    %ebx,%eax
  1008e7:	c1 f8 1f             	sar    $0x1f,%eax
  1008ea:	89 c2                	mov    %eax,%edx
  1008ec:	68 52 0c 10 00       	push   $0x100c52
  1008f1:	31 da                	xor    %ebx,%edx
  1008f3:	29 c2                	sub    %eax,%edx
  1008f5:	8d 44 24 44          	lea    0x44(%esp),%eax
  1008f9:	e8 5e fe ff ff       	call   10075c <fill_numbuf>
			if (x < 0)
  1008fe:	85 db                	test   %ebx,%ebx
  100900:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  100904:	5e                   	pop    %esi
  100905:	be 01 00 00 00       	mov    $0x1,%esi
  10090a:	58                   	pop    %eax
  10090b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
  100912:	00 
  100913:	0f 88 d1 00 00 00    	js     1009ea <console_vprintf+0x25b>
  100919:	66 31 f6             	xor    %si,%si
  10091c:	e9 c9 00 00 00       	jmp    1009ea <console_vprintf+0x25b>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100921:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100924:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100929:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  10092c:	ff 74 24 08          	pushl  0x8(%esp)
  100930:	68 52 0c 10 00       	push   $0x100c52
  100935:	eb 14                	jmp    10094b <console_vprintf+0x1bc>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100937:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10093a:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  10093d:	ff 74 24 08          	pushl  0x8(%esp)
  100941:	68 63 0c 10 00       	push   $0x100c63
  100946:	b9 10 00 00 00       	mov    $0x10,%ecx
  10094b:	8d 44 24 44          	lea    0x44(%esp),%eax
  10094f:	31 f6                	xor    %esi,%esi
  100951:	e8 06 fe ff ff       	call   10075c <fill_numbuf>
  100956:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%esp)
  10095d:	00 
  10095e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
			numeric = 1;
			break;
  100962:	59                   	pop    %ecx
  100963:	5b                   	pop    %ebx
  100964:	e9 81 00 00 00       	jmp    1009ea <console_vprintf+0x25b>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100969:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  10096c:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  10096f:	ff 74 24 08          	pushl  0x8(%esp)
  100973:	68 52 0c 10 00       	push   $0x100c52
  100978:	eb cc                	jmp    100946 <console_vprintf+0x1b7>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10097a:	83 c7 04             	add    $0x4,%edi
  10097d:	31 f6                	xor    %esi,%esi
  10097f:	8b 4f fc             	mov    0xfffffffc(%edi),%ecx
  100982:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100989:	00 
  10098a:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  10098e:	eb 5a                	jmp    1009ea <console_vprintf+0x25b>
			break;
		case 'C':
			color = va_arg(val, int);
  100990:	83 c7 04             	add    $0x4,%edi
  100993:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  100996:	89 44 24 54          	mov    %eax,0x54(%esp)
  10099a:	e9 b4 01 00 00       	jmp    100b53 <console_vprintf+0x3c4>
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  10099f:	83 c7 04             	add    $0x4,%edi
			numbuf[1] = '\0';
  1009a2:	31 f6                	xor    %esi,%esi
  1009a4:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  1009a7:	8d 54 24 28          	lea    0x28(%esp),%edx
  1009ab:	c6 44 24 29 00       	movb   $0x0,0x29(%esp)
  1009b0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1009b7:	00 
  1009b8:	89 54 24 14          	mov    %edx,0x14(%esp)
  1009bc:	88 44 24 28          	mov    %al,0x28(%esp)
  1009c0:	eb 28                	jmp    1009ea <console_vprintf+0x25b>
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1009c2:	84 c0                	test   %al,%al
  1009c4:	75 02                	jne    1009c8 <console_vprintf+0x239>
  1009c6:	b0 25                	mov    $0x25,%al
  1009c8:	88 44 24 28          	mov    %al,0x28(%esp)
  1009cc:	8d 44 24 28          	lea    0x28(%esp),%eax
			numbuf[1] = '\0';
  1009d0:	c6 44 24 29 00       	movb   $0x0,0x29(%esp)
			if (!*format)
  1009d5:	80 7d 00 00          	cmpb   $0x0,0x0(%ebp)
  1009d9:	75 01                	jne    1009dc <console_vprintf+0x24d>
				format--;
  1009db:	4d                   	dec    %ebp
  1009dc:	31 f6                	xor    %esi,%esi
  1009de:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1009e5:	00 
  1009e6:	89 44 24 14          	mov    %eax,0x14(%esp)
			break;
		}

		if (precision >= 0)
  1009ea:	31 c0                	xor    %eax,%eax
  1009ec:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009f1:	78 16                	js     100a09 <console_vprintf+0x27a>
			len = strnlen(data, precision);
  1009f3:	ff 74 24 08          	pushl  0x8(%esp)
  1009f7:	ff 74 24 18          	pushl  0x18(%esp)
  1009fb:	e8 eb fc ff ff       	call   1006eb <strnlen>
  100a00:	89 44 24 18          	mov    %eax,0x18(%esp)
  100a04:	58                   	pop    %eax
  100a05:	5a                   	pop    %edx
  100a06:	eb 0f                	jmp    100a17 <console_vprintf+0x288>
  100a08:	40                   	inc    %eax
  100a09:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  100a0d:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100a11:	75 f5                	jne    100a08 <console_vprintf+0x279>
		else
			len = strlen(data);
  100a13:	89 44 24 10          	mov    %eax,0x10(%esp)
		if (numeric && negative)
  100a17:	8a 54 24 0c          	mov    0xc(%esp),%dl
  100a1b:	84 d2                	test   %dl,%dl
  100a1d:	74 0c                	je     100a2b <console_vprintf+0x29c>
  100a1f:	85 f6                	test   %esi,%esi
  100a21:	c7 44 24 18 2d 00 00 	movl   $0x2d,0x18(%esp)
  100a28:	00 
  100a29:	75 22                	jne    100a4d <console_vprintf+0x2be>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100a2b:	f6 04 24 10          	testb  $0x10,(%esp)
  100a2f:	c7 44 24 18 2b 00 00 	movl   $0x2b,0x18(%esp)
  100a36:	00 
  100a37:	75 14                	jne    100a4d <console_vprintf+0x2be>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100a39:	8b 04 24             	mov    (%esp),%eax
  100a3c:	83 e0 08             	and    $0x8,%eax
  100a3f:	83 f8 01             	cmp    $0x1,%eax
  100a42:	19 c0                	sbb    %eax,%eax
  100a44:	f7 d0                	not    %eax
  100a46:	83 e0 20             	and    $0x20,%eax
  100a49:	89 44 24 18          	mov    %eax,0x18(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100a4d:	84 d2                	test   %dl,%dl
  100a4f:	74 12                	je     100a63 <console_vprintf+0x2d4>
  100a51:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  100a55:	39 4c 24 08          	cmp    %ecx,0x8(%esp)
  100a59:	7e 08                	jle    100a63 <console_vprintf+0x2d4>
			zeros = precision - len;
  100a5b:	8b 5c 24 08          	mov    0x8(%esp),%ebx
  100a5f:	29 cb                	sub    %ecx,%ebx
  100a61:	eb 39                	jmp    100a9c <console_vprintf+0x30d>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a63:	8b 04 24             	mov    (%esp),%eax
  100a66:	83 e0 06             	and    $0x6,%eax
  100a69:	83 f8 02             	cmp    $0x2,%eax
  100a6c:	75 2c                	jne    100a9a <console_vprintf+0x30b>
  100a6e:	84 d2                	test   %dl,%dl
  100a70:	74 28                	je     100a9a <console_vprintf+0x30b>
  100a72:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a77:	79 21                	jns    100a9a <console_vprintf+0x30b>
  100a79:	31 d2                	xor    %edx,%edx
  100a7b:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  100a7f:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  100a84:	0f 95 c2             	setne  %dl
  100a87:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
  100a8a:	3b 44 24 04          	cmp    0x4(%esp),%eax
  100a8e:	7d 0a                	jge    100a9a <console_vprintf+0x30b>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a90:	8b 5c 24 04          	mov    0x4(%esp),%ebx
  100a94:	29 cb                	sub    %ecx,%ebx
  100a96:	29 d3                	sub    %edx,%ebx
  100a98:	eb 02                	jmp    100a9c <console_vprintf+0x30d>
  100a9a:	31 db                	xor    %ebx,%ebx
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a9c:	8b 74 24 04          	mov    0x4(%esp),%esi
  100aa0:	31 c0                	xor    %eax,%eax
  100aa2:	2b 74 24 10          	sub    0x10(%esp),%esi
  100aa6:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  100aab:	0f 95 c0             	setne  %al
  100aae:	29 c6                	sub    %eax,%esi
  100ab0:	29 de                	sub    %ebx,%esi
  100ab2:	eb 17                	jmp    100acb <console_vprintf+0x33c>
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100ab4:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  100ab8:	ba 20 00 00 00       	mov    $0x20,%edx
  100abd:	4e                   	dec    %esi
  100abe:	8b 44 24 50          	mov    0x50(%esp),%eax
  100ac2:	e8 3c fc ff ff       	call   100703 <console_putc>
  100ac7:	89 44 24 50          	mov    %eax,0x50(%esp)
  100acb:	f6 04 24 04          	testb  $0x4,(%esp)
  100acf:	75 04                	jne    100ad5 <console_vprintf+0x346>
  100ad1:	85 f6                	test   %esi,%esi
  100ad3:	7f df                	jg     100ab4 <console_vprintf+0x325>
		if (negative)
  100ad5:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  100ada:	74 2f                	je     100b0b <console_vprintf+0x37c>
			cursor = console_putc(cursor, negative, color);
  100adc:	0f b6 54 24 18       	movzbl 0x18(%esp),%edx
  100ae1:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  100ae5:	8b 44 24 50          	mov    0x50(%esp),%eax
  100ae9:	e8 15 fc ff ff       	call   100703 <console_putc>
  100aee:	89 44 24 50          	mov    %eax,0x50(%esp)
  100af2:	eb 17                	jmp    100b0b <console_vprintf+0x37c>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100af4:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  100af8:	ba 30 00 00 00       	mov    $0x30,%edx
  100afd:	4b                   	dec    %ebx
  100afe:	8b 44 24 50          	mov    0x50(%esp),%eax
  100b02:	e8 fc fb ff ff       	call   100703 <console_putc>
  100b07:	89 44 24 50          	mov    %eax,0x50(%esp)
  100b0b:	85 db                	test   %ebx,%ebx
  100b0d:	7f e5                	jg     100af4 <console_vprintf+0x365>
  100b0f:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  100b13:	eb 19                	jmp    100b2e <console_vprintf+0x39f>
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100b15:	0f b6 53 ff          	movzbl 0xffffffff(%ebx),%edx
  100b19:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  100b1d:	8b 44 24 50          	mov    0x50(%esp),%eax
  100b21:	e8 dd fb ff ff       	call   100703 <console_putc>
  100b26:	ff 4c 24 10          	decl   0x10(%esp)
  100b2a:	89 44 24 50          	mov    %eax,0x50(%esp)
  100b2e:	43                   	inc    %ebx
  100b2f:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100b34:	7f df                	jg     100b15 <console_vprintf+0x386>
  100b36:	eb 17                	jmp    100b4f <console_vprintf+0x3c0>
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100b38:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  100b3c:	ba 20 00 00 00       	mov    $0x20,%edx
  100b41:	4e                   	dec    %esi
  100b42:	8b 44 24 50          	mov    0x50(%esp),%eax
  100b46:	e8 b8 fb ff ff       	call   100703 <console_putc>
  100b4b:	89 44 24 50          	mov    %eax,0x50(%esp)
  100b4f:	85 f6                	test   %esi,%esi
  100b51:	7f e5                	jg     100b38 <console_vprintf+0x3a9>
  100b53:	45                   	inc    %ebp
  100b54:	8a 45 00             	mov    0x0(%ebp),%al
  100b57:	84 c0                	test   %al,%al
  100b59:	0f 85 44 fc ff ff    	jne    1007a3 <console_vprintf+0x14>
  100b5f:	eb 15                	jmp    100b76 <console_vprintf+0x3e7>
  100b61:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
  100b68:	ff 
  100b69:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  100b70:	ff 
  100b71:	e9 50 fe ff ff       	jmp    1009c6 <console_vprintf+0x237>
	done: ;
	}

	return cursor;
}
  100b76:	8b 44 24 50          	mov    0x50(%esp),%eax
  100b7a:	83 c4 3c             	add    $0x3c,%esp
  100b7d:	5b                   	pop    %ebx
  100b7e:	5e                   	pop    %esi
  100b7f:	5f                   	pop    %edi
  100b80:	5d                   	pop    %ebp
  100b81:	c3                   	ret    

00100b82 <console_printf>:

uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100b82:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b86:	50                   	push   %eax
  100b87:	ff 74 24 10          	pushl  0x10(%esp)
  100b8b:	ff 74 24 10          	pushl  0x10(%esp)
  100b8f:	ff 74 24 10          	pushl  0x10(%esp)
  100b93:	e8 f7 fb ff ff       	call   10078f <console_vprintf>
  100b98:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b9b:	c3                   	ret    
