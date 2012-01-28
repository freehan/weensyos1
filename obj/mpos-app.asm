
obj/mpos-app:     file format elf32-i386


Disassembly of section .text:

00200000 <app_printf>:

static void app_printf(const char *format, ...) __attribute__((noinline));

static void
app_printf(const char *format, ...)
{
  200000:	83 ec 0c             	sub    $0xc,%esp
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  200003:	cd 30                	int    $0x30
static void
app_printf(const char *format, ...)
{
	// set default color based on currently running process
	int color = sys_getpid();
	if (color < 0)
  200005:	85 c0                	test   %eax,%eax
  200007:	ba 00 07 00 00       	mov    $0x700,%edx
  20000c:	78 13                	js     200021 <app_printf+0x21>
		color = 0x0700;
	else {
		static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
		color = col[color % sizeof(col)] << 8;
  20000e:	b9 05 00 00 00       	mov    $0x5,%ecx
  200013:	31 d2                	xor    %edx,%edx
  200015:	f7 f1                	div    %ecx
  200017:	0f b6 92 b8 06 20 00 	movzbl 0x2006b8(%edx),%edx
  20001e:	c1 e2 08             	shl    $0x8,%edx
	}

	va_list val;
	va_start(val, format);
	cursorpos = console_vprintf(cursorpos, color, format, val);
  200021:	8d 44 24 14          	lea    0x14(%esp),%eax
  200025:	50                   	push   %eax
  200026:	ff 74 24 14          	pushl  0x14(%esp)
  20002a:	52                   	push   %edx
  20002b:	ff 35 00 00 06 00    	pushl  0x60000
  200031:	e8 25 02 00 00       	call   20025b <console_vprintf>
  200036:	a3 00 00 06 00       	mov    %eax,0x60000
	va_end(val);
}
  20003b:	83 c4 1c             	add    $0x1c,%esp
  20003e:	c3                   	ret    

0020003f <newThread>:
	sys_exit(1000);
}

// XIA: new thread
void newThread()
{
  20003f:	83 ec 14             	sub    $0x14,%esp
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  200042:	cd 30                	int    $0x30
    app_printf("newThread pid = %d\n",sys_getpid());
  200044:	50                   	push   %eax
  200045:	68 18 06 20 00       	push   $0x200618
  20004a:	e8 b1 ff ff ff       	call   200000 <app_printf>

static inline void
sys_yield(void)
{
	// This system call has no return values, so there's no '=a' clause.
	asm volatile("int %0\n"
  20004f:	cd 32                	int    $0x32
    sys_yield();
}
  200051:	83 c4 1c             	add    $0x1c,%esp
  200054:	c3                   	ret    

00200055 <run_child>:
	}
}

void
run_child(void)
{
  200055:	83 ec 24             	sub    $0x24,%esp
	int i;
	volatile int checker = 1; /* This variable checks that you correctly
  200058:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%esp)
  20005f:	00 
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  200060:	cd 30                	int    $0x30
				     gave this process a new stack.
				     If the parent's 'checker' changed value
				     after the child ran, there's a problem! */

	app_printf("Child process %d!\n", sys_getpid());
  200062:	50                   	push   %eax
  200063:	68 2c 06 20 00       	push   $0x20062c
  200068:	e8 93 ff ff ff       	call   200000 <app_printf>
  20006d:	31 c0                	xor    %eax,%eax
  20006f:	83 c4 10             	add    $0x10,%esp

static inline void
sys_yield(void)
{
	// This system call has no return values, so there's no '=a' clause.
	asm volatile("int %0\n"
  200072:	cd 32                	int    $0x32

	// Yield a couple times to help people test Exercise 3
	for (i = 0; i < 20; i++)
  200074:	40                   	inc    %eax
  200075:	83 f8 14             	cmp    $0x14,%eax
  200078:	75 f8                	jne    200072 <run_child+0x1d>
	// the 'int' instruction.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  20007a:	66 b8 e8 03          	mov    $0x3e8,%ax
  20007e:	cd 33                	int    $0x33
  200080:	eb fe                	jmp    200080 <run_child+0x2b>

00200082 <start>:
void run_child(void);
void newThread(void);//XIA: new thread

void
start(void)
{
  200082:	56                   	push   %esi
  200083:	53                   	push   %ebx
  200084:	83 ec 20             	sub    $0x20,%esp
	volatile int checker = 0; /* This variable checks that you correctly
  200087:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  20008e:	00 
				     gave the child process a new stack. */
	pid_t p;
	int status;

	app_printf("About to start a new process...\n");
  20008f:	68 3f 06 20 00       	push   $0x20063f
  200094:	e8 67 ff ff ff       	call   200000 <app_printf>
sys_fork(void)
{
	// This system call follows the same pattern as sys_getpid().

	pid_t result;
	asm volatile("int %1\n"
  200099:	cd 31                	int    $0x31

	p = sys_fork();
	if (p == 0)
  20009b:	83 c4 10             	add    $0x10,%esp
  20009e:	83 f8 00             	cmp    $0x0,%eax
  2000a1:	89 c3                	mov    %eax,%ebx
  2000a3:	75 0a                	jne    2000af <start+0x2d>

	} else {
		app_printf("Error!\n");
		sys_exit(1);
	}
}
  2000a5:	83 c4 14             	add    $0x14,%esp
  2000a8:	5b                   	pop    %ebx
  2000a9:	5e                   	pop    %esi

	app_printf("About to start a new process...\n");

	p = sys_fork();
	if (p == 0)
		run_child();
  2000aa:	e9 a6 ff ff ff       	jmp    200055 <run_child>
	else if (p > 0) {
  2000af:	7e 6b                	jle    20011c <start+0x9a>
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  2000b1:	cd 30                	int    $0x30
		app_printf("Main process %d!\n", sys_getpid());
  2000b3:	52                   	push   %edx
  2000b4:	52                   	push   %edx
  2000b5:	50                   	push   %eax
  2000b6:	68 60 06 20 00       	push   $0x200660
  2000bb:	e8 40 ff ff ff       	call   200000 <app_printf>
  2000c0:	83 c4 10             	add    $0x10,%esp

static inline int
sys_wait(pid_t pid)
{
	int retval;
	asm volatile("int %1\n"
  2000c3:	89 d8                	mov    %ebx,%eax
  2000c5:	cd 34                	int    $0x34
		
        
        do {
			status = sys_wait(p);
			app_printf("W");
  2000c7:	83 ec 0c             	sub    $0xc,%esp
  2000ca:	89 c6                	mov    %eax,%esi
  2000cc:	68 72 06 20 00       	push   $0x200672
  2000d1:	e8 2a ff ff ff       	call   200000 <app_printf>
		} while (status == WAIT_TRYAGAIN);
  2000d6:	83 c4 10             	add    $0x10,%esp
  2000d9:	83 fe fe             	cmp    $0xfffffffe,%esi
  2000dc:	74 e5                	je     2000c3 <start+0x41>

static inline pid_t
sys_newthread(void (*start_function)(void))
{
	pid_t pid;
	asm volatile("int %1\n"
  2000de:	b8 3f 00 20 00       	mov    $0x20003f,%eax
  2000e3:	cd 36                	int    $0x36
        //app_printf("newThread address: %d",&newThread);
        new = sys_newthread(&newThread);
#endif
         
        //status = sys_wait(p);               
		app_printf("Child %d exited with status %d!\n", p, status);
  2000e5:	50                   	push   %eax
  2000e6:	56                   	push   %esi
  2000e7:	53                   	push   %ebx
  2000e8:	68 74 06 20 00       	push   $0x200674
  2000ed:	e8 0e ff ff ff       	call   200000 <app_printf>

		// Check whether the child process corrupted our stack.
		// (This check doesn't find all errors, but it helps.)
		if (checker != 0) {
  2000f2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2000f6:	83 c4 10             	add    $0x10,%esp
  2000f9:	85 c0                	test   %eax,%eax
  2000fb:	74 19                	je     200116 <start+0x94>
			app_printf("Error: stack collision!\n");
  2000fd:	83 ec 0c             	sub    $0xc,%esp
  200100:	68 95 06 20 00       	push   $0x200695
  200105:	e8 f6 fe ff ff       	call   200000 <app_printf>
	// the 'int' instruction.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  20010a:	b8 01 00 00 00       	mov    $0x1,%eax
  20010f:	cd 33                	int    $0x33
  200111:	83 c4 10             	add    $0x10,%esp
  200114:	eb fe                	jmp    200114 <start+0x92>
  200116:	31 c0                	xor    %eax,%eax
  200118:	cd 33                	int    $0x33
  20011a:	eb fe                	jmp    20011a <start+0x98>
			sys_exit(1);
		} else
			sys_exit(0);

	} else {
		app_printf("Error!\n");
  20011c:	83 ec 0c             	sub    $0xc,%esp
  20011f:	68 ae 06 20 00       	push   $0x2006ae
  200124:	e8 d7 fe ff ff       	call   200000 <app_printf>
  200129:	b8 01 00 00 00       	mov    $0x1,%eax
  20012e:	cd 33                	int    $0x33
  200130:	83 c4 10             	add    $0x10,%esp
  200133:	eb fe                	jmp    200133 <start+0xb1>
  200135:	90                   	nop
  200136:	90                   	nop
  200137:	90                   	nop

00200138 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  200138:	56                   	push   %esi
  200139:	31 d2                	xor    %edx,%edx
  20013b:	53                   	push   %ebx
  20013c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200140:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  200144:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  200148:	eb 08                	jmp    200152 <memcpy+0x1a>
		*d++ = *s++;
  20014a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  20014d:	4e                   	dec    %esi
  20014e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  200151:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  200152:	85 f6                	test   %esi,%esi
  200154:	75 f4                	jne    20014a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  200156:	5b                   	pop    %ebx
  200157:	5e                   	pop    %esi
  200158:	c3                   	ret    

00200159 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  200159:	57                   	push   %edi
  20015a:	56                   	push   %esi
  20015b:	53                   	push   %ebx
  20015c:	8b 44 24 10          	mov    0x10(%esp),%eax
  200160:	8b 7c 24 14          	mov    0x14(%esp),%edi
  200164:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  200168:	39 c7                	cmp    %eax,%edi
  20016a:	73 26                	jae    200192 <memmove+0x39>
  20016c:	8d 34 17             	lea    (%edi,%edx,1),%esi
  20016f:	39 c6                	cmp    %eax,%esi
  200171:	76 1f                	jbe    200192 <memmove+0x39>
		s += n, d += n;
  200173:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  200176:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  200178:	eb 07                	jmp    200181 <memmove+0x28>
			*--d = *--s;
  20017a:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  20017d:	4a                   	dec    %edx
  20017e:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  200181:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  200182:	85 d2                	test   %edx,%edx
  200184:	75 f4                	jne    20017a <memmove+0x21>
  200186:	eb 10                	jmp    200198 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  200188:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  20018b:	4a                   	dec    %edx
  20018c:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  20018f:	41                   	inc    %ecx
  200190:	eb 02                	jmp    200194 <memmove+0x3b>
  200192:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  200194:	85 d2                	test   %edx,%edx
  200196:	75 f0                	jne    200188 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  200198:	5b                   	pop    %ebx
  200199:	5e                   	pop    %esi
  20019a:	5f                   	pop    %edi
  20019b:	c3                   	ret    

0020019c <memset>:

void *
memset(void *v, int c, size_t n)
{
  20019c:	53                   	push   %ebx
  20019d:	8b 44 24 08          	mov    0x8(%esp),%eax
  2001a1:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  2001a5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  2001a9:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  2001ab:	eb 04                	jmp    2001b1 <memset+0x15>
		*p++ = c;
  2001ad:	88 1a                	mov    %bl,(%edx)
  2001af:	49                   	dec    %ecx
  2001b0:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  2001b1:	85 c9                	test   %ecx,%ecx
  2001b3:	75 f8                	jne    2001ad <memset+0x11>
		*p++ = c;
	return v;
}
  2001b5:	5b                   	pop    %ebx
  2001b6:	c3                   	ret    

002001b7 <strlen>:

size_t
strlen(const char *s)
{
  2001b7:	8b 54 24 04          	mov    0x4(%esp),%edx
  2001bb:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  2001bd:	eb 01                	jmp    2001c0 <strlen+0x9>
		++n;
  2001bf:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  2001c0:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  2001c4:	75 f9                	jne    2001bf <strlen+0x8>
		++n;
	return n;
}
  2001c6:	c3                   	ret    

002001c7 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  2001c7:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  2001cb:	31 c0                	xor    %eax,%eax
  2001cd:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  2001d1:	eb 01                	jmp    2001d4 <strnlen+0xd>
		++n;
  2001d3:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  2001d4:	39 d0                	cmp    %edx,%eax
  2001d6:	74 06                	je     2001de <strnlen+0x17>
  2001d8:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  2001dc:	75 f5                	jne    2001d3 <strnlen+0xc>
		++n;
	return n;
}
  2001de:	c3                   	ret    

002001df <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  2001df:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  2001e0:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  2001e5:	53                   	push   %ebx
  2001e6:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  2001e8:	76 05                	jbe    2001ef <console_putc+0x10>
  2001ea:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  2001ef:	80 fa 0a             	cmp    $0xa,%dl
  2001f2:	75 2c                	jne    200220 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  2001f4:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  2001fa:	be 50 00 00 00       	mov    $0x50,%esi
  2001ff:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  200201:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  200204:	99                   	cltd   
  200205:	f7 fe                	idiv   %esi
  200207:	89 de                	mov    %ebx,%esi
  200209:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  20020b:	eb 07                	jmp    200214 <console_putc+0x35>
			*cursor++ = ' ' | color;
  20020d:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  200210:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  200211:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  200214:	83 f8 50             	cmp    $0x50,%eax
  200217:	75 f4                	jne    20020d <console_putc+0x2e>
  200219:	29 d0                	sub    %edx,%eax
  20021b:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  20021e:	eb 0b                	jmp    20022b <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  200220:	0f b6 d2             	movzbl %dl,%edx
  200223:	09 ca                	or     %ecx,%edx
  200225:	66 89 13             	mov    %dx,(%ebx)
  200228:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  20022b:	5b                   	pop    %ebx
  20022c:	5e                   	pop    %esi
  20022d:	c3                   	ret    

0020022e <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  20022e:	56                   	push   %esi
  20022f:	53                   	push   %ebx
  200230:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  200234:	8d 58 ff             	lea    -0x1(%eax),%ebx
  200237:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  20023b:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  200240:	75 04                	jne    200246 <fill_numbuf+0x18>
  200242:	85 d2                	test   %edx,%edx
  200244:	74 10                	je     200256 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  200246:	89 d0                	mov    %edx,%eax
  200248:	31 d2                	xor    %edx,%edx
  20024a:	f7 f1                	div    %ecx
  20024c:	4b                   	dec    %ebx
  20024d:	8a 14 16             	mov    (%esi,%edx,1),%dl
  200250:	88 13                	mov    %dl,(%ebx)
			val /= base;
  200252:	89 c2                	mov    %eax,%edx
  200254:	eb ec                	jmp    200242 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  200256:	89 d8                	mov    %ebx,%eax
  200258:	5b                   	pop    %ebx
  200259:	5e                   	pop    %esi
  20025a:	c3                   	ret    

0020025b <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  20025b:	55                   	push   %ebp
  20025c:	57                   	push   %edi
  20025d:	56                   	push   %esi
  20025e:	53                   	push   %ebx
  20025f:	83 ec 38             	sub    $0x38,%esp
  200262:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  200266:	8b 7c 24 54          	mov    0x54(%esp),%edi
  20026a:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  20026e:	e9 60 03 00 00       	jmp    2005d3 <console_vprintf+0x378>
		if (*format != '%') {
  200273:	80 fa 25             	cmp    $0x25,%dl
  200276:	74 13                	je     20028b <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  200278:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  20027c:	0f b6 d2             	movzbl %dl,%edx
  20027f:	89 f0                	mov    %esi,%eax
  200281:	e8 59 ff ff ff       	call   2001df <console_putc>
  200286:	e9 45 03 00 00       	jmp    2005d0 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  20028b:	47                   	inc    %edi
  20028c:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  200293:	00 
  200294:	eb 12                	jmp    2002a8 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  200296:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  200297:	8a 11                	mov    (%ecx),%dl
  200299:	84 d2                	test   %dl,%dl
  20029b:	74 1a                	je     2002b7 <console_vprintf+0x5c>
  20029d:	89 e8                	mov    %ebp,%eax
  20029f:	38 c2                	cmp    %al,%dl
  2002a1:	75 f3                	jne    200296 <console_vprintf+0x3b>
  2002a3:	e9 3f 03 00 00       	jmp    2005e7 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  2002a8:	8a 17                	mov    (%edi),%dl
  2002aa:	84 d2                	test   %dl,%dl
  2002ac:	74 0b                	je     2002b9 <console_vprintf+0x5e>
  2002ae:	b9 c0 06 20 00       	mov    $0x2006c0,%ecx
  2002b3:	89 d5                	mov    %edx,%ebp
  2002b5:	eb e0                	jmp    200297 <console_vprintf+0x3c>
  2002b7:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  2002b9:	8d 42 cf             	lea    -0x31(%edx),%eax
  2002bc:	3c 08                	cmp    $0x8,%al
  2002be:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  2002c5:	00 
  2002c6:	76 13                	jbe    2002db <console_vprintf+0x80>
  2002c8:	eb 1d                	jmp    2002e7 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  2002ca:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  2002cf:	0f be c0             	movsbl %al,%eax
  2002d2:	47                   	inc    %edi
  2002d3:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  2002d7:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  2002db:	8a 07                	mov    (%edi),%al
  2002dd:	8d 50 d0             	lea    -0x30(%eax),%edx
  2002e0:	80 fa 09             	cmp    $0x9,%dl
  2002e3:	76 e5                	jbe    2002ca <console_vprintf+0x6f>
  2002e5:	eb 18                	jmp    2002ff <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  2002e7:	80 fa 2a             	cmp    $0x2a,%dl
  2002ea:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  2002f1:	ff 
  2002f2:	75 0b                	jne    2002ff <console_vprintf+0xa4>
			width = va_arg(val, int);
  2002f4:	83 c3 04             	add    $0x4,%ebx
			++format;
  2002f7:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  2002f8:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2002fb:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  2002ff:	83 cd ff             	or     $0xffffffff,%ebp
  200302:	80 3f 2e             	cmpb   $0x2e,(%edi)
  200305:	75 37                	jne    20033e <console_vprintf+0xe3>
			++format;
  200307:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  200308:	31 ed                	xor    %ebp,%ebp
  20030a:	8a 07                	mov    (%edi),%al
  20030c:	8d 50 d0             	lea    -0x30(%eax),%edx
  20030f:	80 fa 09             	cmp    $0x9,%dl
  200312:	76 0d                	jbe    200321 <console_vprintf+0xc6>
  200314:	eb 17                	jmp    20032d <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  200316:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  200319:	0f be c0             	movsbl %al,%eax
  20031c:	47                   	inc    %edi
  20031d:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  200321:	8a 07                	mov    (%edi),%al
  200323:	8d 50 d0             	lea    -0x30(%eax),%edx
  200326:	80 fa 09             	cmp    $0x9,%dl
  200329:	76 eb                	jbe    200316 <console_vprintf+0xbb>
  20032b:	eb 11                	jmp    20033e <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  20032d:	3c 2a                	cmp    $0x2a,%al
  20032f:	75 0b                	jne    20033c <console_vprintf+0xe1>
				precision = va_arg(val, int);
  200331:	83 c3 04             	add    $0x4,%ebx
				++format;
  200334:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  200335:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  200338:	85 ed                	test   %ebp,%ebp
  20033a:	79 02                	jns    20033e <console_vprintf+0xe3>
  20033c:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  20033e:	8a 07                	mov    (%edi),%al
  200340:	3c 64                	cmp    $0x64,%al
  200342:	74 34                	je     200378 <console_vprintf+0x11d>
  200344:	7f 1d                	jg     200363 <console_vprintf+0x108>
  200346:	3c 58                	cmp    $0x58,%al
  200348:	0f 84 a2 00 00 00    	je     2003f0 <console_vprintf+0x195>
  20034e:	3c 63                	cmp    $0x63,%al
  200350:	0f 84 bf 00 00 00    	je     200415 <console_vprintf+0x1ba>
  200356:	3c 43                	cmp    $0x43,%al
  200358:	0f 85 d0 00 00 00    	jne    20042e <console_vprintf+0x1d3>
  20035e:	e9 a3 00 00 00       	jmp    200406 <console_vprintf+0x1ab>
  200363:	3c 75                	cmp    $0x75,%al
  200365:	74 4d                	je     2003b4 <console_vprintf+0x159>
  200367:	3c 78                	cmp    $0x78,%al
  200369:	74 5c                	je     2003c7 <console_vprintf+0x16c>
  20036b:	3c 73                	cmp    $0x73,%al
  20036d:	0f 85 bb 00 00 00    	jne    20042e <console_vprintf+0x1d3>
  200373:	e9 86 00 00 00       	jmp    2003fe <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  200378:	83 c3 04             	add    $0x4,%ebx
  20037b:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  20037e:	89 d1                	mov    %edx,%ecx
  200380:	c1 f9 1f             	sar    $0x1f,%ecx
  200383:	89 0c 24             	mov    %ecx,(%esp)
  200386:	31 ca                	xor    %ecx,%edx
  200388:	55                   	push   %ebp
  200389:	29 ca                	sub    %ecx,%edx
  20038b:	68 c8 06 20 00       	push   $0x2006c8
  200390:	b9 0a 00 00 00       	mov    $0xa,%ecx
  200395:	8d 44 24 40          	lea    0x40(%esp),%eax
  200399:	e8 90 fe ff ff       	call   20022e <fill_numbuf>
  20039e:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  2003a2:	58                   	pop    %eax
  2003a3:	5a                   	pop    %edx
  2003a4:	ba 01 00 00 00       	mov    $0x1,%edx
  2003a9:	8b 04 24             	mov    (%esp),%eax
  2003ac:	83 e0 01             	and    $0x1,%eax
  2003af:	e9 a5 00 00 00       	jmp    200459 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  2003b4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  2003b7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  2003bc:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2003bf:	55                   	push   %ebp
  2003c0:	68 c8 06 20 00       	push   $0x2006c8
  2003c5:	eb 11                	jmp    2003d8 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  2003c7:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  2003ca:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2003cd:	55                   	push   %ebp
  2003ce:	68 dc 06 20 00       	push   $0x2006dc
  2003d3:	b9 10 00 00 00       	mov    $0x10,%ecx
  2003d8:	8d 44 24 40          	lea    0x40(%esp),%eax
  2003dc:	e8 4d fe ff ff       	call   20022e <fill_numbuf>
  2003e1:	ba 01 00 00 00       	mov    $0x1,%edx
  2003e6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2003ea:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  2003ec:	59                   	pop    %ecx
  2003ed:	59                   	pop    %ecx
  2003ee:	eb 69                	jmp    200459 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  2003f0:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  2003f3:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2003f6:	55                   	push   %ebp
  2003f7:	68 c8 06 20 00       	push   $0x2006c8
  2003fc:	eb d5                	jmp    2003d3 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  2003fe:	83 c3 04             	add    $0x4,%ebx
  200401:	8b 43 fc             	mov    -0x4(%ebx),%eax
  200404:	eb 40                	jmp    200446 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  200406:	83 c3 04             	add    $0x4,%ebx
  200409:	8b 53 fc             	mov    -0x4(%ebx),%edx
  20040c:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  200410:	e9 bd 01 00 00       	jmp    2005d2 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  200415:	83 c3 04             	add    $0x4,%ebx
  200418:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  20041b:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  20041f:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  200424:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  200428:	88 44 24 24          	mov    %al,0x24(%esp)
  20042c:	eb 27                	jmp    200455 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  20042e:	84 c0                	test   %al,%al
  200430:	75 02                	jne    200434 <console_vprintf+0x1d9>
  200432:	b0 25                	mov    $0x25,%al
  200434:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  200438:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  20043d:	80 3f 00             	cmpb   $0x0,(%edi)
  200440:	74 0a                	je     20044c <console_vprintf+0x1f1>
  200442:	8d 44 24 24          	lea    0x24(%esp),%eax
  200446:	89 44 24 04          	mov    %eax,0x4(%esp)
  20044a:	eb 09                	jmp    200455 <console_vprintf+0x1fa>
				format--;
  20044c:	8d 54 24 24          	lea    0x24(%esp),%edx
  200450:	4f                   	dec    %edi
  200451:	89 54 24 04          	mov    %edx,0x4(%esp)
  200455:	31 d2                	xor    %edx,%edx
  200457:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  200459:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  20045b:	83 fd ff             	cmp    $0xffffffff,%ebp
  20045e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  200465:	74 1f                	je     200486 <console_vprintf+0x22b>
  200467:	89 04 24             	mov    %eax,(%esp)
  20046a:	eb 01                	jmp    20046d <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  20046c:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  20046d:	39 e9                	cmp    %ebp,%ecx
  20046f:	74 0a                	je     20047b <console_vprintf+0x220>
  200471:	8b 44 24 04          	mov    0x4(%esp),%eax
  200475:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  200479:	75 f1                	jne    20046c <console_vprintf+0x211>
  20047b:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  20047e:	89 0c 24             	mov    %ecx,(%esp)
  200481:	eb 1f                	jmp    2004a2 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  200483:	42                   	inc    %edx
  200484:	eb 09                	jmp    20048f <console_vprintf+0x234>
  200486:	89 d1                	mov    %edx,%ecx
  200488:	8b 14 24             	mov    (%esp),%edx
  20048b:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  20048f:	8b 44 24 04          	mov    0x4(%esp),%eax
  200493:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  200497:	75 ea                	jne    200483 <console_vprintf+0x228>
  200499:	8b 44 24 08          	mov    0x8(%esp),%eax
  20049d:	89 14 24             	mov    %edx,(%esp)
  2004a0:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  2004a2:	85 c0                	test   %eax,%eax
  2004a4:	74 0c                	je     2004b2 <console_vprintf+0x257>
  2004a6:	84 d2                	test   %dl,%dl
  2004a8:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  2004af:	00 
  2004b0:	75 24                	jne    2004d6 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  2004b2:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  2004b7:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  2004be:	00 
  2004bf:	75 15                	jne    2004d6 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  2004c1:	8b 44 24 14          	mov    0x14(%esp),%eax
  2004c5:	83 e0 08             	and    $0x8,%eax
  2004c8:	83 f8 01             	cmp    $0x1,%eax
  2004cb:	19 c9                	sbb    %ecx,%ecx
  2004cd:	f7 d1                	not    %ecx
  2004cf:	83 e1 20             	and    $0x20,%ecx
  2004d2:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  2004d6:	3b 2c 24             	cmp    (%esp),%ebp
  2004d9:	7e 0d                	jle    2004e8 <console_vprintf+0x28d>
  2004db:	84 d2                	test   %dl,%dl
  2004dd:	74 40                	je     20051f <console_vprintf+0x2c4>
			zeros = precision - len;
  2004df:	2b 2c 24             	sub    (%esp),%ebp
  2004e2:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  2004e6:	eb 3f                	jmp    200527 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004e8:	84 d2                	test   %dl,%dl
  2004ea:	74 33                	je     20051f <console_vprintf+0x2c4>
  2004ec:	8b 44 24 14          	mov    0x14(%esp),%eax
  2004f0:	83 e0 06             	and    $0x6,%eax
  2004f3:	83 f8 02             	cmp    $0x2,%eax
  2004f6:	75 27                	jne    20051f <console_vprintf+0x2c4>
  2004f8:	45                   	inc    %ebp
  2004f9:	75 24                	jne    20051f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  2004fb:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004fd:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  200500:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  200505:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  200508:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  20050b:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  20050f:	7d 0e                	jge    20051f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  200511:	8b 54 24 0c          	mov    0xc(%esp),%edx
  200515:	29 ca                	sub    %ecx,%edx
  200517:	29 c2                	sub    %eax,%edx
  200519:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  20051d:	eb 08                	jmp    200527 <console_vprintf+0x2cc>
  20051f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  200526:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  200527:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  20052b:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  20052d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  200531:	2b 2c 24             	sub    (%esp),%ebp
  200534:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  200539:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  20053c:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  20053f:	29 c5                	sub    %eax,%ebp
  200541:	89 f0                	mov    %esi,%eax
  200543:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  200547:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  20054b:	eb 0f                	jmp    20055c <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  20054d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200551:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  200556:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  200557:	e8 83 fc ff ff       	call   2001df <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  20055c:	85 ed                	test   %ebp,%ebp
  20055e:	7e 07                	jle    200567 <console_vprintf+0x30c>
  200560:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  200565:	74 e6                	je     20054d <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  200567:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  20056c:	89 c6                	mov    %eax,%esi
  20056e:	74 23                	je     200593 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  200570:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  200575:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200579:	e8 61 fc ff ff       	call   2001df <console_putc>
  20057e:	89 c6                	mov    %eax,%esi
  200580:	eb 11                	jmp    200593 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  200582:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200586:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  20058b:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  20058c:	e8 4e fc ff ff       	call   2001df <console_putc>
  200591:	eb 06                	jmp    200599 <console_vprintf+0x33e>
  200593:	89 f0                	mov    %esi,%eax
  200595:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  200599:	85 f6                	test   %esi,%esi
  20059b:	7f e5                	jg     200582 <console_vprintf+0x327>
  20059d:	8b 34 24             	mov    (%esp),%esi
  2005a0:	eb 15                	jmp    2005b7 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  2005a2:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  2005a6:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  2005a7:	0f b6 11             	movzbl (%ecx),%edx
  2005aa:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  2005ae:	e8 2c fc ff ff       	call   2001df <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  2005b3:	ff 44 24 04          	incl   0x4(%esp)
  2005b7:	85 f6                	test   %esi,%esi
  2005b9:	7f e7                	jg     2005a2 <console_vprintf+0x347>
  2005bb:	eb 0f                	jmp    2005cc <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  2005bd:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  2005c1:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  2005c6:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  2005c7:	e8 13 fc ff ff       	call   2001df <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  2005cc:	85 ed                	test   %ebp,%ebp
  2005ce:	7f ed                	jg     2005bd <console_vprintf+0x362>
  2005d0:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  2005d2:	47                   	inc    %edi
  2005d3:	8a 17                	mov    (%edi),%dl
  2005d5:	84 d2                	test   %dl,%dl
  2005d7:	0f 85 96 fc ff ff    	jne    200273 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  2005dd:	83 c4 38             	add    $0x38,%esp
  2005e0:	89 f0                	mov    %esi,%eax
  2005e2:	5b                   	pop    %ebx
  2005e3:	5e                   	pop    %esi
  2005e4:	5f                   	pop    %edi
  2005e5:	5d                   	pop    %ebp
  2005e6:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  2005e7:	81 e9 c0 06 20 00    	sub    $0x2006c0,%ecx
  2005ed:	b8 01 00 00 00       	mov    $0x1,%eax
  2005f2:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  2005f4:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  2005f5:	09 44 24 14          	or     %eax,0x14(%esp)
  2005f9:	e9 aa fc ff ff       	jmp    2002a8 <console_vprintf+0x4d>

002005fe <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  2005fe:	8d 44 24 10          	lea    0x10(%esp),%eax
  200602:	50                   	push   %eax
  200603:	ff 74 24 10          	pushl  0x10(%esp)
  200607:	ff 74 24 10          	pushl  0x10(%esp)
  20060b:	ff 74 24 10          	pushl  0x10(%esp)
  20060f:	e8 47 fc ff ff       	call   20025b <console_vprintf>
  200614:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  200617:	c3                   	ret    
