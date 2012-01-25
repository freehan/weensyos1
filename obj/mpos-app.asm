
obj/mpos-app:     file format elf32-i386

Disassembly of section .text:

00200000 <app_printf>:
static void app_printf(const char *format, ...) __attribute__((noinline));

static void
app_printf(const char *format, ...)
{
  200000:	53                   	push   %ebx
  200001:	83 ec 08             	sub    $0x8,%esp
  200004:	cd 30                	int    $0x30
	// set default color based on currently running process
	int color = sys_getpid();
	if (color < 0)
  200006:	85 c0                	test   %eax,%eax
  200008:	ba 00 07 00 00       	mov    $0x700,%edx
  20000d:	78 14                	js     200023 <app_printf+0x23>
		color = 0x0700;
	else {
		static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
		color = col[color % sizeof(col)] << 8;
  20000f:	66 ba 05 00          	mov    $0x5,%dx
  200013:	89 d3                	mov    %edx,%ebx
  200015:	31 d2                	xor    %edx,%edx
  200017:	f7 f3                	div    %ebx
  200019:	0f b6 92 f2 06 20 00 	movzbl 0x2006f2(%edx),%edx
  200020:	c1 e2 08             	shl    $0x8,%edx
	}

	va_list val;
	va_start(val, format);
	cursorpos = console_vprintf(cursorpos, color, format, val);
  200023:	8d 44 24 14          	lea    0x14(%esp),%eax
  200027:	50                   	push   %eax
  200028:	ff 74 24 14          	pushl  0x14(%esp)
  20002c:	52                   	push   %edx
  20002d:	ff 35 00 00 06 00    	pushl  0x60000
  200033:	e8 23 02 00 00       	call   20025b <console_vprintf>
  200038:	a3 00 00 06 00       	mov    %eax,0x60000
	va_end(val);
}
  20003d:	83 c4 18             	add    $0x18,%esp
  200040:	5b                   	pop    %ebx
  200041:	c3                   	ret    

00200042 <run_child>:
}

void
run_child(void)
{
  200042:	83 ec 24             	sub    $0x24,%esp
	int i;
	volatile int checker = 1; /* This variable checks that you correctly
  200045:	c7 44 24 20 01 00 00 	movl   $0x1,0x20(%esp)
  20004c:	00 
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  20004d:	cd 30                	int    $0x30
				     gave this process a new stack.
				     If the parent's 'checker' changed value
				     after the child ran, there's a problem! */

	app_printf("Child process %d!\n", sys_getpid());
  20004f:	50                   	push   %eax
  200050:	68 68 06 20 00       	push   $0x200668
  200055:	e8 a6 ff ff ff       	call   200000 <app_printf>
  20005a:	31 c0                	xor    %eax,%eax
  20005c:	83 c4 10             	add    $0x10,%esp
static inline void
sys_yield(void)
{
	// This system call has no return values, so there's no '=a' clause.
	asm volatile("int %0\n"
  20005f:	cd 32                	int    $0x32

	// Yield a couple times to help people test Exercise 3
	for (i = 0; i < 20; i++)
  200061:	40                   	inc    %eax
  200062:	83 f8 14             	cmp    $0x14,%eax
  200065:	75 f8                	jne    20005f <run_child+0x1d>
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  200067:	66 b8 e8 03          	mov    $0x3e8,%ax
  20006b:	cd 33                	int    $0x33
  20006d:	eb fe                	jmp    20006d <run_child+0x2b>

0020006f <start>:
  20006f:	56                   	push   %esi
  200070:	53                   	push   %ebx
  200071:	83 ec 20             	sub    $0x20,%esp
  200074:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  20007b:	00 
  20007c:	68 7b 06 20 00       	push   $0x20067b
  200081:	e8 7a ff ff ff       	call   200000 <app_printf>
{
	// This system call follows the same pattern as sys_getpid().

	pid_t result;
	asm volatile("int %1\n"
  200086:	cd 31                	int    $0x31
  200088:	83 c4 10             	add    $0x10,%esp
  20008b:	83 f8 00             	cmp    $0x0,%eax
{
	// This system call follows the same pattern as sys_getpid().

	pid_t result;
	asm volatile("int %1\n"
  20008e:	89 c6                	mov    %eax,%esi
  200090:	75 0a                	jne    20009c <start+0x2d>
  200092:	83 c4 14             	add    $0x14,%esp
  200095:	5b                   	pop    %ebx
  200096:	5e                   	pop    %esi
  200097:	e9 a6 ff ff ff       	jmp    200042 <run_child>
  20009c:	7e 6a                	jle    200108 <start+0x99>
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  20009e:	cd 30                	int    $0x30
  2000a0:	52                   	push   %edx
  2000a1:	52                   	push   %edx
  2000a2:	50                   	push   %eax
  2000a3:	68 9c 06 20 00       	push   $0x20069c
  2000a8:	e8 53 ff ff ff       	call   200000 <app_printf>
  2000ad:	83 c4 10             	add    $0x10,%esp
static inline int
sys_wait(pid_t pid)
{
	int retval;
	asm volatile("int %1\n"
  2000b0:	89 f0                	mov    %esi,%eax
  2000b2:	cd 34                	int    $0x34
  2000b4:	83 ec 0c             	sub    $0xc,%esp
static inline int
sys_wait(pid_t pid)
{
	int retval;
	asm volatile("int %1\n"
  2000b7:	89 c3                	mov    %eax,%ebx
  2000b9:	68 ae 06 20 00       	push   $0x2006ae
  2000be:	e8 3d ff ff ff       	call   200000 <app_printf>
  2000c3:	83 c4 10             	add    $0x10,%esp
  2000c6:	83 fb fe             	cmp    $0xfffffffe,%ebx
  2000c9:	74 e5                	je     2000b0 <start+0x41>
static inline int
sys_wait(pid_t pid)
{
	int retval;
	asm volatile("int %1\n"
  2000cb:	89 f0                	mov    %esi,%eax
  2000cd:	cd 34                	int    $0x34
  2000cf:	89 c2                	mov    %eax,%edx
  2000d1:	50                   	push   %eax
  2000d2:	52                   	push   %edx
  2000d3:	56                   	push   %esi
  2000d4:	68 b0 06 20 00       	push   $0x2006b0
  2000d9:	e8 22 ff ff ff       	call   200000 <app_printf>
  2000de:	8b 44 24 20          	mov    0x20(%esp),%eax
  2000e2:	83 c4 10             	add    $0x10,%esp
  2000e5:	85 c0                	test   %eax,%eax
  2000e7:	74 19                	je     200102 <start+0x93>
  2000e9:	83 ec 0c             	sub    $0xc,%esp
  2000ec:	68 d1 06 20 00       	push   $0x2006d1
  2000f1:	e8 0a ff ff ff       	call   200000 <app_printf>
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  2000f6:	b8 01 00 00 00       	mov    $0x1,%eax
  2000fb:	cd 33                	int    $0x33
  2000fd:	83 c4 10             	add    $0x10,%esp
  200100:	eb fe                	jmp    200100 <start+0x91>
  200102:	31 c0                	xor    %eax,%eax
  200104:	cd 33                	int    $0x33
  200106:	eb fe                	jmp    200106 <start+0x97>
  200108:	83 ec 0c             	sub    $0xc,%esp
  20010b:	68 ea 06 20 00       	push   $0x2006ea
  200110:	e8 eb fe ff ff       	call   200000 <app_printf>
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  200115:	b8 01 00 00 00       	mov    $0x1,%eax
  20011a:	cd 33                	int    $0x33
  20011c:	83 c4 10             	add    $0x10,%esp
  20011f:	eb fe                	jmp    20011f <start+0xb0>
  200121:	90                   	nop    
  200122:	90                   	nop    
  200123:	90                   	nop    

00200124 <memcpy>:
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  200124:	53                   	push   %ebx
  200125:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  200129:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  20012d:	8b 54 24 08          	mov    0x8(%esp),%edx
  200131:	eb 06                	jmp    200139 <memcpy+0x15>
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
		*d++ = *s++;
  200133:	8a 41 ff             	mov    0xffffffff(%ecx),%al
  200136:	88 42 ff             	mov    %al,0xffffffff(%edx)
  200139:	4b                   	dec    %ebx
  20013a:	41                   	inc    %ecx
  20013b:	42                   	inc    %edx
  20013c:	83 fb ff             	cmp    $0xffffffff,%ebx
  20013f:	75 f2                	jne    200133 <memcpy+0xf>
	return dst;
}
  200141:	8b 44 24 08          	mov    0x8(%esp),%eax
  200145:	5b                   	pop    %ebx
  200146:	c3                   	ret    

00200147 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  200147:	56                   	push   %esi
  200148:	53                   	push   %ebx
  200149:	8b 74 24 0c          	mov    0xc(%esp),%esi
  20014d:	8b 44 24 10          	mov    0x10(%esp),%eax
  200151:	8b 54 24 14          	mov    0x14(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  200155:	39 f0                	cmp    %esi,%eax
  200157:	73 0a                	jae    200163 <memmove+0x1c>
  200159:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
  20015c:	39 f3                	cmp    %esi,%ebx
		s += n, d += n;
  20015e:	8d 0c 16             	lea    (%esi,%edx,1),%ecx
  200161:	77 0c                	ja     20016f <memmove+0x28>
  200163:	89 c3                	mov    %eax,%ebx
  200165:	89 f1                	mov    %esi,%ecx
  200167:	eb 14                	jmp    20017d <memmove+0x36>
		while (n-- > 0)
			*--d = *--s;
  200169:	4b                   	dec    %ebx
  20016a:	49                   	dec    %ecx
  20016b:	8a 03                	mov    (%ebx),%al
  20016d:	88 01                	mov    %al,(%ecx)
  20016f:	4a                   	dec    %edx
  200170:	83 fa ff             	cmp    $0xffffffff,%edx
  200173:	75 f4                	jne    200169 <memmove+0x22>
  200175:	eb 0e                	jmp    200185 <memmove+0x3e>
	} else
		while (n-- > 0)
			*d++ = *s++;
  200177:	8a 43 ff             	mov    0xffffffff(%ebx),%al
  20017a:	88 41 ff             	mov    %al,0xffffffff(%ecx)
  20017d:	4a                   	dec    %edx
  20017e:	43                   	inc    %ebx
  20017f:	41                   	inc    %ecx
  200180:	83 fa ff             	cmp    $0xffffffff,%edx
  200183:	75 f2                	jne    200177 <memmove+0x30>
	return dst;
}
  200185:	89 f0                	mov    %esi,%eax
  200187:	5b                   	pop    %ebx
  200188:	5e                   	pop    %esi
  200189:	c3                   	ret    

0020018a <memset>:

void *
memset(void *v, int c, size_t n)
{
  20018a:	53                   	push   %ebx
  20018b:	8b 44 24 08          	mov    0x8(%esp),%eax
  20018f:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  200193:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  200197:	89 c2                	mov    %eax,%edx
  200199:	eb 03                	jmp    20019e <memset+0x14>
	char *p = (char *) v;
	while (n-- > 0)
		*p++ = c;
  20019b:	88 5a ff             	mov    %bl,0xffffffff(%edx)
  20019e:	49                   	dec    %ecx
  20019f:	42                   	inc    %edx
  2001a0:	83 f9 ff             	cmp    $0xffffffff,%ecx
  2001a3:	75 f6                	jne    20019b <memset+0x11>
	return v;
}
  2001a5:	5b                   	pop    %ebx
  2001a6:	c3                   	ret    

002001a7 <strlen>:

size_t
strlen(const char *s)
{
  2001a7:	8b 54 24 04          	mov    0x4(%esp),%edx
  2001ab:	31 c0                	xor    %eax,%eax
  2001ad:	eb 01                	jmp    2001b0 <strlen+0x9>
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  2001af:	40                   	inc    %eax
  2001b0:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  2001b4:	75 f9                	jne    2001af <strlen+0x8>
	return n;
}
  2001b6:	c3                   	ret    

002001b7 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  2001b7:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  2001bb:	31 c0                	xor    %eax,%eax
  2001bd:	8b 54 24 08          	mov    0x8(%esp),%edx
  2001c1:	eb 01                	jmp    2001c4 <strnlen+0xd>
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  2001c3:	40                   	inc    %eax
  2001c4:	39 d0                	cmp    %edx,%eax
  2001c6:	74 06                	je     2001ce <strnlen+0x17>
  2001c8:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  2001cc:	75 f5                	jne    2001c3 <strnlen+0xc>
	return n;
}
  2001ce:	c3                   	ret    

002001cf <console_putc>:


/*****************************************************************************
 * console_vprintf
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  2001cf:	57                   	push   %edi
  2001d0:	89 cf                	mov    %ecx,%edi
  2001d2:	56                   	push   %esi
  2001d3:	53                   	push   %ebx
  2001d4:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  2001d6:	81 fb 9f 8f 0b 00    	cmp    $0xb8f9f,%ebx
  2001dc:	88 d0                	mov    %dl,%al
  2001de:	76 05                	jbe    2001e5 <console_putc+0x16>
  2001e0:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  2001e5:	3c 0a                	cmp    $0xa,%al
  2001e7:	75 2f                	jne    200218 <console_putc+0x49>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  2001e9:	8d 83 00 80 f4 ff    	lea    0xfff48000(%ebx),%eax
  2001ef:	be 50 00 00 00       	mov    $0x50,%esi
  2001f4:	d1 f8                	sar    %eax
  2001f6:	89 d9                	mov    %ebx,%ecx
  2001f8:	99                   	cltd   
  2001f9:	f7 fe                	idiv   %esi
  2001fb:	89 d6                	mov    %edx,%esi
  2001fd:	eb 0a                	jmp    200209 <console_putc+0x3a>
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  2001ff:	89 f8                	mov    %edi,%eax
  200201:	42                   	inc    %edx
  200202:	83 c8 20             	or     $0x20,%eax
  200205:	66 89 41 fe          	mov    %ax,0xfffffffe(%ecx)
  200209:	83 c1 02             	add    $0x2,%ecx
  20020c:	83 fa 50             	cmp    $0x50,%edx
  20020f:	75 ee                	jne    2001ff <console_putc+0x30>
  200211:	29 f2                	sub    %esi,%edx
  200213:	8d 04 53             	lea    (%ebx,%edx,2),%eax
  200216:	eb 0c                	jmp    200224 <console_putc+0x55>
	} else
		*cursor++ = c | color;
  200218:	66 0f b6 c0          	movzbw %al,%ax
  20021c:	09 f8                	or     %edi,%eax
  20021e:	66 89 03             	mov    %ax,(%ebx)
  200221:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  200224:	5b                   	pop    %ebx
  200225:	5e                   	pop    %esi
  200226:	5f                   	pop    %edi
  200227:	c3                   	ret    

00200228 <fill_numbuf>:

static const char upper_digits[] = "0123456789ABCDEF";
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  200228:	57                   	push   %edi
  200229:	56                   	push   %esi
  20022a:	89 ce                	mov    %ecx,%esi
  20022c:	53                   	push   %ebx
  20022d:	8b 7c 24 10          	mov    0x10(%esp),%edi
	*--numbuf_end = '\0';
  200231:	8d 58 ff             	lea    0xffffffff(%eax),%ebx
  200234:	c6 40 ff 00          	movb   $0x0,0xffffffff(%eax)
	if (precision != 0 || val != 0)
  200238:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  20023d:	75 04                	jne    200243 <fill_numbuf+0x1b>
  20023f:	85 d2                	test   %edx,%edx
  200241:	74 12                	je     200255 <fill_numbuf+0x2d>
		do {
			*--numbuf_end = digits[val % base];
  200243:	89 d0                	mov    %edx,%eax
  200245:	31 d2                	xor    %edx,%edx
  200247:	f7 f6                	div    %esi
  200249:	4b                   	dec    %ebx
  20024a:	89 c1                	mov    %eax,%ecx
  20024c:	8a 04 17             	mov    (%edi,%edx,1),%al
			val /= base;
  20024f:	89 ca                	mov    %ecx,%edx
  200251:	88 03                	mov    %al,(%ebx)
  200253:	eb ea                	jmp    20023f <fill_numbuf+0x17>
		} while (val != 0);
	return numbuf_end;
}
  200255:	89 d8                	mov    %ebx,%eax
  200257:	5b                   	pop    %ebx
  200258:	5e                   	pop    %esi
  200259:	5f                   	pop    %edi
  20025a:	c3                   	ret    

0020025b <console_vprintf>:

#define FLAG_ALT		(1<<0)
#define FLAG_ZERO		(1<<1)
#define FLAG_LEFTJUSTIFY	(1<<2)
#define FLAG_SPACEPOSITIVE	(1<<3)
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  20025b:	55                   	push   %ebp
  20025c:	57                   	push   %edi
  20025d:	56                   	push   %esi
  20025e:	53                   	push   %ebx
  20025f:	83 ec 3c             	sub    $0x3c,%esp
  200262:	8b 6c 24 58          	mov    0x58(%esp),%ebp
  200266:	8b 7c 24 5c          	mov    0x5c(%esp),%edi
  20026a:	e9 b1 03 00 00       	jmp    200620 <console_vprintf+0x3c5>
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
		if (*format != '%') {
  20026f:	3c 25                	cmp    $0x25,%al
  200271:	74 19                	je     20028c <console_vprintf+0x31>
			cursor = console_putc(cursor, *format, color);
  200273:	0f b6 d0             	movzbl %al,%edx
  200276:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  20027a:	8b 44 24 50          	mov    0x50(%esp),%eax
  20027e:	e8 4c ff ff ff       	call   2001cf <console_putc>
  200283:	89 44 24 50          	mov    %eax,0x50(%esp)
  200287:	e9 93 03 00 00       	jmp    20061f <console_vprintf+0x3c4>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  20028c:	45                   	inc    %ebp
  20028d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  200294:	eb 1c                	jmp    2002b2 <console_vprintf+0x57>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  200296:	41                   	inc    %ecx
  200297:	8a 01                	mov    (%ecx),%al
  200299:	84 c0                	test   %al,%al
  20029b:	74 27                	je     2002c4 <console_vprintf+0x69>
  20029d:	38 d0                	cmp    %dl,%al
  20029f:	75 f5                	jne    200296 <console_vprintf+0x3b>
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  2002a1:	81 e9 f7 06 20 00    	sub    $0x2006f7,%ecx
  2002a7:	b8 01 00 00 00       	mov    $0x1,%eax
  2002ac:	d3 e0                	shl    %cl,%eax
  2002ae:	45                   	inc    %ebp
  2002af:	09 04 24             	or     %eax,(%esp)
  2002b2:	8a 55 00             	mov    0x0(%ebp),%dl
  2002b5:	84 d2                	test   %dl,%dl
  2002b7:	0f 84 70 03 00 00    	je     20062d <console_vprintf+0x3d2>
  2002bd:	b9 f7 06 20 00       	mov    $0x2006f7,%ecx
  2002c2:	eb d3                	jmp    200297 <console_vprintf+0x3c>
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  2002c4:	8d 42 cf             	lea    0xffffffcf(%edx),%eax
  2002c7:	3c 08                	cmp    $0x8,%al
  2002c9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  2002d0:	00 
  2002d1:	76 13                	jbe    2002e6 <console_vprintf+0x8b>
  2002d3:	eb 1d                	jmp    2002f2 <console_vprintf+0x97>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  2002d5:	6b 44 24 04 0a       	imul   $0xa,0x4(%esp),%eax
  2002da:	0f be d2             	movsbl %dl,%edx
  2002dd:	45                   	inc    %ebp
  2002de:	8d 54 02 d0          	lea    0xffffffd0(%edx,%eax,1),%edx
  2002e2:	89 54 24 04          	mov    %edx,0x4(%esp)
  2002e6:	8a 55 00             	mov    0x0(%ebp),%dl
  2002e9:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  2002ec:	3c 09                	cmp    $0x9,%al
  2002ee:	76 e5                	jbe    2002d5 <console_vprintf+0x7a>
  2002f0:	eb 18                	jmp    20030a <console_vprintf+0xaf>
		} else if (*format == '*') {
  2002f2:	80 fa 2a             	cmp    $0x2a,%dl
  2002f5:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  2002fc:	ff 
  2002fd:	75 0b                	jne    20030a <console_vprintf+0xaf>
			width = va_arg(val, int);
  2002ff:	83 c7 04             	add    $0x4,%edi
			++format;
  200302:	45                   	inc    %ebp
  200303:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  200306:	89 44 24 04          	mov    %eax,0x4(%esp)
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  20030a:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
  200311:	ff 
  200312:	80 7d 00 2e          	cmpb   $0x2e,0x0(%ebp)
  200316:	75 4f                	jne    200367 <console_vprintf+0x10c>
			++format;
  200318:	45                   	inc    %ebp
			if (*format >= '0' && *format <= '9') {
  200319:	8a 55 00             	mov    0x0(%ebp),%dl
  20031c:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  20031f:	3c 09                	cmp    $0x9,%al
  200321:	77 25                	ja     200348 <console_vprintf+0xed>
  200323:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  20032a:	00 
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  20032b:	6b 44 24 08 0a       	imul   $0xa,0x8(%esp),%eax
  200330:	0f be d2             	movsbl %dl,%edx
  200333:	45                   	inc    %ebp
  200334:	8d 54 10 d0          	lea    0xffffffd0(%eax,%edx,1),%edx
  200338:	89 54 24 08          	mov    %edx,0x8(%esp)
  20033c:	8a 55 00             	mov    0x0(%ebp),%dl
  20033f:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  200342:	3c 09                	cmp    $0x9,%al
  200344:	77 12                	ja     200358 <console_vprintf+0xfd>
  200346:	eb e3                	jmp    20032b <console_vprintf+0xd0>
			} else if (*format == '*') {
  200348:	80 fa 2a             	cmp    $0x2a,%dl
  20034b:	75 12                	jne    20035f <console_vprintf+0x104>
				precision = va_arg(val, int);
  20034d:	83 c7 04             	add    $0x4,%edi
				++format;
  200350:	45                   	inc    %ebp
  200351:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  200354:	89 54 24 08          	mov    %edx,0x8(%esp)
			}
			if (precision < 0)
  200358:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  20035d:	79 08                	jns    200367 <console_vprintf+0x10c>
  20035f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  200366:	00 
				precision = 0;
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  200367:	8a 45 00             	mov    0x0(%ebp),%al
  20036a:	3c 64                	cmp    $0x64,%al
  20036c:	74 34                	je     2003a2 <console_vprintf+0x147>
  20036e:	7f 1d                	jg     20038d <console_vprintf+0x132>
  200370:	3c 58                	cmp    $0x58,%al
  200372:	0f 84 bd 00 00 00    	je     200435 <console_vprintf+0x1da>
  200378:	3c 63                	cmp    $0x63,%al
  20037a:	0f 84 eb 00 00 00    	je     20046b <console_vprintf+0x210>
  200380:	3c 43                	cmp    $0x43,%al
  200382:	0f 85 06 01 00 00    	jne    20048e <console_vprintf+0x233>
  200388:	e9 cf 00 00 00       	jmp    20045c <console_vprintf+0x201>
  20038d:	3c 75                	cmp    $0x75,%al
  20038f:	74 5c                	je     2003ed <console_vprintf+0x192>
  200391:	3c 78                	cmp    $0x78,%al
  200393:	74 6e                	je     200403 <console_vprintf+0x1a8>
  200395:	3c 73                	cmp    $0x73,%al
  200397:	0f 85 f1 00 00 00    	jne    20048e <console_vprintf+0x233>
  20039d:	e9 a4 00 00 00       	jmp    200446 <console_vprintf+0x1eb>
		case 'd': {
			int x = va_arg(val, int);
  2003a2:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  2003a5:	b9 0a 00 00 00       	mov    $0xa,%ecx
  2003aa:	8b 5f fc             	mov    0xfffffffc(%edi),%ebx
  2003ad:	ff 74 24 08          	pushl  0x8(%esp)
  2003b1:	89 d8                	mov    %ebx,%eax
  2003b3:	c1 f8 1f             	sar    $0x1f,%eax
  2003b6:	89 c2                	mov    %eax,%edx
  2003b8:	68 fd 06 20 00       	push   $0x2006fd
  2003bd:	31 da                	xor    %ebx,%edx
  2003bf:	29 c2                	sub    %eax,%edx
  2003c1:	8d 44 24 44          	lea    0x44(%esp),%eax
  2003c5:	e8 5e fe ff ff       	call   200228 <fill_numbuf>
			if (x < 0)
  2003ca:	85 db                	test   %ebx,%ebx
  2003cc:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  2003d0:	5e                   	pop    %esi
  2003d1:	be 01 00 00 00       	mov    $0x1,%esi
  2003d6:	58                   	pop    %eax
  2003d7:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
  2003de:	00 
  2003df:	0f 88 d1 00 00 00    	js     2004b6 <console_vprintf+0x25b>
  2003e5:	66 31 f6             	xor    %si,%si
  2003e8:	e9 c9 00 00 00       	jmp    2004b6 <console_vprintf+0x25b>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  2003ed:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  2003f0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  2003f5:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  2003f8:	ff 74 24 08          	pushl  0x8(%esp)
  2003fc:	68 fd 06 20 00       	push   $0x2006fd
  200401:	eb 14                	jmp    200417 <console_vprintf+0x1bc>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  200403:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  200406:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  200409:	ff 74 24 08          	pushl  0x8(%esp)
  20040d:	68 0e 07 20 00       	push   $0x20070e
  200412:	b9 10 00 00 00       	mov    $0x10,%ecx
  200417:	8d 44 24 44          	lea    0x44(%esp),%eax
  20041b:	31 f6                	xor    %esi,%esi
  20041d:	e8 06 fe ff ff       	call   200228 <fill_numbuf>
  200422:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%esp)
  200429:	00 
  20042a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
			numeric = 1;
			break;
  20042e:	59                   	pop    %ecx
  20042f:	5b                   	pop    %ebx
  200430:	e9 81 00 00 00       	jmp    2004b6 <console_vprintf+0x25b>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  200435:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  200438:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  20043b:	ff 74 24 08          	pushl  0x8(%esp)
  20043f:	68 fd 06 20 00       	push   $0x2006fd
  200444:	eb cc                	jmp    200412 <console_vprintf+0x1b7>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  200446:	83 c7 04             	add    $0x4,%edi
  200449:	31 f6                	xor    %esi,%esi
  20044b:	8b 4f fc             	mov    0xfffffffc(%edi),%ecx
  20044e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  200455:	00 
  200456:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  20045a:	eb 5a                	jmp    2004b6 <console_vprintf+0x25b>
			break;
		case 'C':
			color = va_arg(val, int);
  20045c:	83 c7 04             	add    $0x4,%edi
  20045f:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  200462:	89 44 24 54          	mov    %eax,0x54(%esp)
  200466:	e9 b4 01 00 00       	jmp    20061f <console_vprintf+0x3c4>
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  20046b:	83 c7 04             	add    $0x4,%edi
			numbuf[1] = '\0';
  20046e:	31 f6                	xor    %esi,%esi
  200470:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  200473:	8d 54 24 28          	lea    0x28(%esp),%edx
  200477:	c6 44 24 29 00       	movb   $0x0,0x29(%esp)
  20047c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  200483:	00 
  200484:	89 54 24 14          	mov    %edx,0x14(%esp)
  200488:	88 44 24 28          	mov    %al,0x28(%esp)
  20048c:	eb 28                	jmp    2004b6 <console_vprintf+0x25b>
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  20048e:	84 c0                	test   %al,%al
  200490:	75 02                	jne    200494 <console_vprintf+0x239>
  200492:	b0 25                	mov    $0x25,%al
  200494:	88 44 24 28          	mov    %al,0x28(%esp)
  200498:	8d 44 24 28          	lea    0x28(%esp),%eax
			numbuf[1] = '\0';
  20049c:	c6 44 24 29 00       	movb   $0x0,0x29(%esp)
			if (!*format)
  2004a1:	80 7d 00 00          	cmpb   $0x0,0x0(%ebp)
  2004a5:	75 01                	jne    2004a8 <console_vprintf+0x24d>
				format--;
  2004a7:	4d                   	dec    %ebp
  2004a8:	31 f6                	xor    %esi,%esi
  2004aa:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  2004b1:	00 
  2004b2:	89 44 24 14          	mov    %eax,0x14(%esp)
			break;
		}

		if (precision >= 0)
  2004b6:	31 c0                	xor    %eax,%eax
  2004b8:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  2004bd:	78 16                	js     2004d5 <console_vprintf+0x27a>
			len = strnlen(data, precision);
  2004bf:	ff 74 24 08          	pushl  0x8(%esp)
  2004c3:	ff 74 24 18          	pushl  0x18(%esp)
  2004c7:	e8 eb fc ff ff       	call   2001b7 <strnlen>
  2004cc:	89 44 24 18          	mov    %eax,0x18(%esp)
  2004d0:	58                   	pop    %eax
  2004d1:	5a                   	pop    %edx
  2004d2:	eb 0f                	jmp    2004e3 <console_vprintf+0x288>
  2004d4:	40                   	inc    %eax
  2004d5:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  2004d9:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  2004dd:	75 f5                	jne    2004d4 <console_vprintf+0x279>
		else
			len = strlen(data);
  2004df:	89 44 24 10          	mov    %eax,0x10(%esp)
		if (numeric && negative)
  2004e3:	8a 54 24 0c          	mov    0xc(%esp),%dl
  2004e7:	84 d2                	test   %dl,%dl
  2004e9:	74 0c                	je     2004f7 <console_vprintf+0x29c>
  2004eb:	85 f6                	test   %esi,%esi
  2004ed:	c7 44 24 18 2d 00 00 	movl   $0x2d,0x18(%esp)
  2004f4:	00 
  2004f5:	75 22                	jne    200519 <console_vprintf+0x2be>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  2004f7:	f6 04 24 10          	testb  $0x10,(%esp)
  2004fb:	c7 44 24 18 2b 00 00 	movl   $0x2b,0x18(%esp)
  200502:	00 
  200503:	75 14                	jne    200519 <console_vprintf+0x2be>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  200505:	8b 04 24             	mov    (%esp),%eax
  200508:	83 e0 08             	and    $0x8,%eax
  20050b:	83 f8 01             	cmp    $0x1,%eax
  20050e:	19 c0                	sbb    %eax,%eax
  200510:	f7 d0                	not    %eax
  200512:	83 e0 20             	and    $0x20,%eax
  200515:	89 44 24 18          	mov    %eax,0x18(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  200519:	84 d2                	test   %dl,%dl
  20051b:	74 12                	je     20052f <console_vprintf+0x2d4>
  20051d:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  200521:	39 4c 24 08          	cmp    %ecx,0x8(%esp)
  200525:	7e 08                	jle    20052f <console_vprintf+0x2d4>
			zeros = precision - len;
  200527:	8b 5c 24 08          	mov    0x8(%esp),%ebx
  20052b:	29 cb                	sub    %ecx,%ebx
  20052d:	eb 39                	jmp    200568 <console_vprintf+0x30d>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  20052f:	8b 04 24             	mov    (%esp),%eax
  200532:	83 e0 06             	and    $0x6,%eax
  200535:	83 f8 02             	cmp    $0x2,%eax
  200538:	75 2c                	jne    200566 <console_vprintf+0x30b>
  20053a:	84 d2                	test   %dl,%dl
  20053c:	74 28                	je     200566 <console_vprintf+0x30b>
  20053e:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  200543:	79 21                	jns    200566 <console_vprintf+0x30b>
  200545:	31 d2                	xor    %edx,%edx
  200547:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  20054b:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  200550:	0f 95 c2             	setne  %dl
  200553:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
  200556:	3b 44 24 04          	cmp    0x4(%esp),%eax
  20055a:	7d 0a                	jge    200566 <console_vprintf+0x30b>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  20055c:	8b 5c 24 04          	mov    0x4(%esp),%ebx
  200560:	29 cb                	sub    %ecx,%ebx
  200562:	29 d3                	sub    %edx,%ebx
  200564:	eb 02                	jmp    200568 <console_vprintf+0x30d>
  200566:	31 db                	xor    %ebx,%ebx
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  200568:	8b 74 24 04          	mov    0x4(%esp),%esi
  20056c:	31 c0                	xor    %eax,%eax
  20056e:	2b 74 24 10          	sub    0x10(%esp),%esi
  200572:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  200577:	0f 95 c0             	setne  %al
  20057a:	29 c6                	sub    %eax,%esi
  20057c:	29 de                	sub    %ebx,%esi
  20057e:	eb 17                	jmp    200597 <console_vprintf+0x33c>
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  200580:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  200584:	ba 20 00 00 00       	mov    $0x20,%edx
  200589:	4e                   	dec    %esi
  20058a:	8b 44 24 50          	mov    0x50(%esp),%eax
  20058e:	e8 3c fc ff ff       	call   2001cf <console_putc>
  200593:	89 44 24 50          	mov    %eax,0x50(%esp)
  200597:	f6 04 24 04          	testb  $0x4,(%esp)
  20059b:	75 04                	jne    2005a1 <console_vprintf+0x346>
  20059d:	85 f6                	test   %esi,%esi
  20059f:	7f df                	jg     200580 <console_vprintf+0x325>
		if (negative)
  2005a1:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  2005a6:	74 2f                	je     2005d7 <console_vprintf+0x37c>
			cursor = console_putc(cursor, negative, color);
  2005a8:	0f b6 54 24 18       	movzbl 0x18(%esp),%edx
  2005ad:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  2005b1:	8b 44 24 50          	mov    0x50(%esp),%eax
  2005b5:	e8 15 fc ff ff       	call   2001cf <console_putc>
  2005ba:	89 44 24 50          	mov    %eax,0x50(%esp)
  2005be:	eb 17                	jmp    2005d7 <console_vprintf+0x37c>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  2005c0:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  2005c4:	ba 30 00 00 00       	mov    $0x30,%edx
  2005c9:	4b                   	dec    %ebx
  2005ca:	8b 44 24 50          	mov    0x50(%esp),%eax
  2005ce:	e8 fc fb ff ff       	call   2001cf <console_putc>
  2005d3:	89 44 24 50          	mov    %eax,0x50(%esp)
  2005d7:	85 db                	test   %ebx,%ebx
  2005d9:	7f e5                	jg     2005c0 <console_vprintf+0x365>
  2005db:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  2005df:	eb 19                	jmp    2005fa <console_vprintf+0x39f>
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  2005e1:	0f b6 53 ff          	movzbl 0xffffffff(%ebx),%edx
  2005e5:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  2005e9:	8b 44 24 50          	mov    0x50(%esp),%eax
  2005ed:	e8 dd fb ff ff       	call   2001cf <console_putc>
  2005f2:	ff 4c 24 10          	decl   0x10(%esp)
  2005f6:	89 44 24 50          	mov    %eax,0x50(%esp)
  2005fa:	43                   	inc    %ebx
  2005fb:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  200600:	7f df                	jg     2005e1 <console_vprintf+0x386>
  200602:	eb 17                	jmp    20061b <console_vprintf+0x3c0>
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  200604:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  200608:	ba 20 00 00 00       	mov    $0x20,%edx
  20060d:	4e                   	dec    %esi
  20060e:	8b 44 24 50          	mov    0x50(%esp),%eax
  200612:	e8 b8 fb ff ff       	call   2001cf <console_putc>
  200617:	89 44 24 50          	mov    %eax,0x50(%esp)
  20061b:	85 f6                	test   %esi,%esi
  20061d:	7f e5                	jg     200604 <console_vprintf+0x3a9>
  20061f:	45                   	inc    %ebp
  200620:	8a 45 00             	mov    0x0(%ebp),%al
  200623:	84 c0                	test   %al,%al
  200625:	0f 85 44 fc ff ff    	jne    20026f <console_vprintf+0x14>
  20062b:	eb 15                	jmp    200642 <console_vprintf+0x3e7>
  20062d:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
  200634:	ff 
  200635:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  20063c:	ff 
  20063d:	e9 50 fe ff ff       	jmp    200492 <console_vprintf+0x237>
	done: ;
	}

	return cursor;
}
  200642:	8b 44 24 50          	mov    0x50(%esp),%eax
  200646:	83 c4 3c             	add    $0x3c,%esp
  200649:	5b                   	pop    %ebx
  20064a:	5e                   	pop    %esi
  20064b:	5f                   	pop    %edi
  20064c:	5d                   	pop    %ebp
  20064d:	c3                   	ret    

0020064e <console_printf>:

uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  20064e:	8d 44 24 10          	lea    0x10(%esp),%eax
  200652:	50                   	push   %eax
  200653:	ff 74 24 10          	pushl  0x10(%esp)
  200657:	ff 74 24 10          	pushl  0x10(%esp)
  20065b:	ff 74 24 10          	pushl  0x10(%esp)
  20065f:	e8 f7 fb ff ff       	call   20025b <console_vprintf>
  200664:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  200667:	c3                   	ret    
