
obj/mpos-app2:     file format elf32-i386

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
  200019:	0f b6 92 43 06 20 00 	movzbl 0x200643(%edx),%edx
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
  200033:	e8 df 01 00 00       	call   200217 <console_vprintf>
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
  200042:	53                   	push   %ebx
  200043:	83 ec 08             	sub    $0x8,%esp
	int input_counter = counter;
  200046:	8b 1d 70 16 20 00    	mov    0x201670,%ebx

	counter++;		/* Note that all "processes" share an address
  20004c:	a1 70 16 20 00       	mov    0x201670,%eax
  200051:	40                   	inc    %eax
  200052:	a3 70 16 20 00       	mov    %eax,0x201670
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  200057:	cd 30                	int    $0x30
				   space, so this change to 'counter' will be
				   visible to all processes. */
	#ifdef EXTRA
	int pid = sys_getpid();
	if(!(pid&1)){			//even number
  200059:	a8 01                	test   $0x1,%al
  20005b:	75 11                	jne    20006e <run_child+0x2c>
  20005d:	ba 03 00 00 00       	mov    $0x3,%edx
static inline int
sys_kill(pid_t pid)
{
	int retval;
	asm volatile("int %1\n"
  200062:	89 d0                	mov    %edx,%eax
  200064:	cd 35                	int    $0x35
		int i;
		for( i = 3; i< NPROCS; i+=2)
  200066:	83 c2 02             	add    $0x2,%edx
  200069:	83 fa 11             	cmp    $0x11,%edx
  20006c:	75 f4                	jne    200062 <run_child+0x20>
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  20006e:	cd 30                	int    $0x30
		{
			int result = sys_kill(i);
		}
	}
	#endif
	app_printf("Process %d lives, counter %d!\n",
  200070:	52                   	push   %edx
  200071:	53                   	push   %ebx
  200072:	50                   	push   %eax
  200073:	68 24 06 20 00       	push   $0x200624
  200078:	e8 83 ff ff ff       	call   200000 <app_printf>
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  20007d:	89 d8                	mov    %ebx,%eax
  20007f:	cd 33                	int    $0x33
  200081:	83 c4 10             	add    $0x10,%esp
  200084:	eb fe                	jmp    200084 <run_child+0x42>

00200086 <start>:
  200086:	53                   	push   %ebx
  200087:	83 ec 08             	sub    $0x8,%esp
  20008a:	c7 05 70 16 20 00 00 	movl   $0x0,0x201670
  200091:	00 00 00 
  200094:	eb 33                	jmp    2000c9 <start+0x43>
{
	// This system call follows the same pattern as sys_getpid().

	pid_t result;
	asm volatile("int %1\n"
  200096:	cd 31                	int    $0x31
  200098:	83 f8 00             	cmp    $0x0,%eax
  20009b:	75 07                	jne    2000a4 <start+0x1e>
  20009d:	e8 a0 ff ff ff       	call   200042 <run_child>
  2000a2:	eb 03                	jmp    2000a7 <start+0x21>
  2000a4:	7e 10                	jle    2000b6 <start+0x30>
  2000a6:	43                   	inc    %ebx
  2000a7:	a1 70 16 20 00       	mov    0x201670,%eax
  2000ac:	8d 04 03             	lea    (%ebx,%eax,1),%eax
  2000af:	3d 00 04 00 00       	cmp    $0x400,%eax
  2000b4:	7e e0                	jle    200096 <start+0x10>
  2000b6:	85 db                	test   %ebx,%ebx
  2000b8:	74 1d                	je     2000d7 <start+0x51>
  2000ba:	ba 02 00 00 00       	mov    $0x2,%edx
static inline int
sys_wait(pid_t pid)
{
	int retval;
	asm volatile("int %1\n"
  2000bf:	89 d0                	mov    %edx,%eax
  2000c1:	cd 34                	int    $0x34
  2000c3:	42                   	inc    %edx
  2000c4:	83 fa 10             	cmp    $0x10,%edx
  2000c7:	75 f6                	jne    2000bf <start+0x39>
  2000c9:	a1 70 16 20 00       	mov    0x201670,%eax
  2000ce:	83 f8 0e             	cmp    $0xe,%eax
  2000d1:	7f 04                	jg     2000d7 <start+0x51>
  2000d3:	31 db                	xor    %ebx,%ebx
  2000d5:	eb d0                	jmp    2000a7 <start+0x21>
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  2000d7:	31 c0                	xor    %eax,%eax
  2000d9:	cd 33                	int    $0x33
  2000db:	eb fe                	jmp    2000db <start+0x55>
  2000dd:	90                   	nop    
  2000de:	90                   	nop    
  2000df:	90                   	nop    

002000e0 <memcpy>:
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  2000e0:	53                   	push   %ebx
  2000e1:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  2000e5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  2000e9:	8b 54 24 08          	mov    0x8(%esp),%edx
  2000ed:	eb 06                	jmp    2000f5 <memcpy+0x15>
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
		*d++ = *s++;
  2000ef:	8a 41 ff             	mov    0xffffffff(%ecx),%al
  2000f2:	88 42 ff             	mov    %al,0xffffffff(%edx)
  2000f5:	4b                   	dec    %ebx
  2000f6:	41                   	inc    %ecx
  2000f7:	42                   	inc    %edx
  2000f8:	83 fb ff             	cmp    $0xffffffff,%ebx
  2000fb:	75 f2                	jne    2000ef <memcpy+0xf>
	return dst;
}
  2000fd:	8b 44 24 08          	mov    0x8(%esp),%eax
  200101:	5b                   	pop    %ebx
  200102:	c3                   	ret    

00200103 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  200103:	56                   	push   %esi
  200104:	53                   	push   %ebx
  200105:	8b 74 24 0c          	mov    0xc(%esp),%esi
  200109:	8b 44 24 10          	mov    0x10(%esp),%eax
  20010d:	8b 54 24 14          	mov    0x14(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  200111:	39 f0                	cmp    %esi,%eax
  200113:	73 0a                	jae    20011f <memmove+0x1c>
  200115:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
  200118:	39 f3                	cmp    %esi,%ebx
		s += n, d += n;
  20011a:	8d 0c 16             	lea    (%esi,%edx,1),%ecx
  20011d:	77 0c                	ja     20012b <memmove+0x28>
  20011f:	89 c3                	mov    %eax,%ebx
  200121:	89 f1                	mov    %esi,%ecx
  200123:	eb 14                	jmp    200139 <memmove+0x36>
		while (n-- > 0)
			*--d = *--s;
  200125:	4b                   	dec    %ebx
  200126:	49                   	dec    %ecx
  200127:	8a 03                	mov    (%ebx),%al
  200129:	88 01                	mov    %al,(%ecx)
  20012b:	4a                   	dec    %edx
  20012c:	83 fa ff             	cmp    $0xffffffff,%edx
  20012f:	75 f4                	jne    200125 <memmove+0x22>
  200131:	eb 0e                	jmp    200141 <memmove+0x3e>
	} else
		while (n-- > 0)
			*d++ = *s++;
  200133:	8a 43 ff             	mov    0xffffffff(%ebx),%al
  200136:	88 41 ff             	mov    %al,0xffffffff(%ecx)
  200139:	4a                   	dec    %edx
  20013a:	43                   	inc    %ebx
  20013b:	41                   	inc    %ecx
  20013c:	83 fa ff             	cmp    $0xffffffff,%edx
  20013f:	75 f2                	jne    200133 <memmove+0x30>
	return dst;
}
  200141:	89 f0                	mov    %esi,%eax
  200143:	5b                   	pop    %ebx
  200144:	5e                   	pop    %esi
  200145:	c3                   	ret    

00200146 <memset>:

void *
memset(void *v, int c, size_t n)
{
  200146:	53                   	push   %ebx
  200147:	8b 44 24 08          	mov    0x8(%esp),%eax
  20014b:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  20014f:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  200153:	89 c2                	mov    %eax,%edx
  200155:	eb 03                	jmp    20015a <memset+0x14>
	char *p = (char *) v;
	while (n-- > 0)
		*p++ = c;
  200157:	88 5a ff             	mov    %bl,0xffffffff(%edx)
  20015a:	49                   	dec    %ecx
  20015b:	42                   	inc    %edx
  20015c:	83 f9 ff             	cmp    $0xffffffff,%ecx
  20015f:	75 f6                	jne    200157 <memset+0x11>
	return v;
}
  200161:	5b                   	pop    %ebx
  200162:	c3                   	ret    

00200163 <strlen>:

size_t
strlen(const char *s)
{
  200163:	8b 54 24 04          	mov    0x4(%esp),%edx
  200167:	31 c0                	xor    %eax,%eax
  200169:	eb 01                	jmp    20016c <strlen+0x9>
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  20016b:	40                   	inc    %eax
  20016c:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  200170:	75 f9                	jne    20016b <strlen+0x8>
	return n;
}
  200172:	c3                   	ret    

00200173 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  200173:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  200177:	31 c0                	xor    %eax,%eax
  200179:	8b 54 24 08          	mov    0x8(%esp),%edx
  20017d:	eb 01                	jmp    200180 <strnlen+0xd>
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  20017f:	40                   	inc    %eax
  200180:	39 d0                	cmp    %edx,%eax
  200182:	74 06                	je     20018a <strnlen+0x17>
  200184:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  200188:	75 f5                	jne    20017f <strnlen+0xc>
	return n;
}
  20018a:	c3                   	ret    

0020018b <console_putc>:


/*****************************************************************************
 * console_vprintf
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  20018b:	57                   	push   %edi
  20018c:	89 cf                	mov    %ecx,%edi
  20018e:	56                   	push   %esi
  20018f:	53                   	push   %ebx
  200190:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  200192:	81 fb 9f 8f 0b 00    	cmp    $0xb8f9f,%ebx
  200198:	88 d0                	mov    %dl,%al
  20019a:	76 05                	jbe    2001a1 <console_putc+0x16>
  20019c:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  2001a1:	3c 0a                	cmp    $0xa,%al
  2001a3:	75 2f                	jne    2001d4 <console_putc+0x49>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  2001a5:	8d 83 00 80 f4 ff    	lea    0xfff48000(%ebx),%eax
  2001ab:	be 50 00 00 00       	mov    $0x50,%esi
  2001b0:	d1 f8                	sar    %eax
  2001b2:	89 d9                	mov    %ebx,%ecx
  2001b4:	99                   	cltd   
  2001b5:	f7 fe                	idiv   %esi
  2001b7:	89 d6                	mov    %edx,%esi
  2001b9:	eb 0a                	jmp    2001c5 <console_putc+0x3a>
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  2001bb:	89 f8                	mov    %edi,%eax
  2001bd:	42                   	inc    %edx
  2001be:	83 c8 20             	or     $0x20,%eax
  2001c1:	66 89 41 fe          	mov    %ax,0xfffffffe(%ecx)
  2001c5:	83 c1 02             	add    $0x2,%ecx
  2001c8:	83 fa 50             	cmp    $0x50,%edx
  2001cb:	75 ee                	jne    2001bb <console_putc+0x30>
  2001cd:	29 f2                	sub    %esi,%edx
  2001cf:	8d 04 53             	lea    (%ebx,%edx,2),%eax
  2001d2:	eb 0c                	jmp    2001e0 <console_putc+0x55>
	} else
		*cursor++ = c | color;
  2001d4:	66 0f b6 c0          	movzbw %al,%ax
  2001d8:	09 f8                	or     %edi,%eax
  2001da:	66 89 03             	mov    %ax,(%ebx)
  2001dd:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  2001e0:	5b                   	pop    %ebx
  2001e1:	5e                   	pop    %esi
  2001e2:	5f                   	pop    %edi
  2001e3:	c3                   	ret    

002001e4 <fill_numbuf>:

static const char upper_digits[] = "0123456789ABCDEF";
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  2001e4:	57                   	push   %edi
  2001e5:	56                   	push   %esi
  2001e6:	89 ce                	mov    %ecx,%esi
  2001e8:	53                   	push   %ebx
  2001e9:	8b 7c 24 10          	mov    0x10(%esp),%edi
	*--numbuf_end = '\0';
  2001ed:	8d 58 ff             	lea    0xffffffff(%eax),%ebx
  2001f0:	c6 40 ff 00          	movb   $0x0,0xffffffff(%eax)
	if (precision != 0 || val != 0)
  2001f4:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  2001f9:	75 04                	jne    2001ff <fill_numbuf+0x1b>
  2001fb:	85 d2                	test   %edx,%edx
  2001fd:	74 12                	je     200211 <fill_numbuf+0x2d>
		do {
			*--numbuf_end = digits[val % base];
  2001ff:	89 d0                	mov    %edx,%eax
  200201:	31 d2                	xor    %edx,%edx
  200203:	f7 f6                	div    %esi
  200205:	4b                   	dec    %ebx
  200206:	89 c1                	mov    %eax,%ecx
  200208:	8a 04 17             	mov    (%edi,%edx,1),%al
			val /= base;
  20020b:	89 ca                	mov    %ecx,%edx
  20020d:	88 03                	mov    %al,(%ebx)
  20020f:	eb ea                	jmp    2001fb <fill_numbuf+0x17>
		} while (val != 0);
	return numbuf_end;
}
  200211:	89 d8                	mov    %ebx,%eax
  200213:	5b                   	pop    %ebx
  200214:	5e                   	pop    %esi
  200215:	5f                   	pop    %edi
  200216:	c3                   	ret    

00200217 <console_vprintf>:

#define FLAG_ALT		(1<<0)
#define FLAG_ZERO		(1<<1)
#define FLAG_LEFTJUSTIFY	(1<<2)
#define FLAG_SPACEPOSITIVE	(1<<3)
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  200217:	55                   	push   %ebp
  200218:	57                   	push   %edi
  200219:	56                   	push   %esi
  20021a:	53                   	push   %ebx
  20021b:	83 ec 3c             	sub    $0x3c,%esp
  20021e:	8b 6c 24 58          	mov    0x58(%esp),%ebp
  200222:	8b 7c 24 5c          	mov    0x5c(%esp),%edi
  200226:	e9 b1 03 00 00       	jmp    2005dc <console_vprintf+0x3c5>
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
		if (*format != '%') {
  20022b:	3c 25                	cmp    $0x25,%al
  20022d:	74 19                	je     200248 <console_vprintf+0x31>
			cursor = console_putc(cursor, *format, color);
  20022f:	0f b6 d0             	movzbl %al,%edx
  200232:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  200236:	8b 44 24 50          	mov    0x50(%esp),%eax
  20023a:	e8 4c ff ff ff       	call   20018b <console_putc>
  20023f:	89 44 24 50          	mov    %eax,0x50(%esp)
  200243:	e9 93 03 00 00       	jmp    2005db <console_vprintf+0x3c4>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  200248:	45                   	inc    %ebp
  200249:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  200250:	eb 1c                	jmp    20026e <console_vprintf+0x57>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  200252:	41                   	inc    %ecx
  200253:	8a 01                	mov    (%ecx),%al
  200255:	84 c0                	test   %al,%al
  200257:	74 27                	je     200280 <console_vprintf+0x69>
  200259:	38 d0                	cmp    %dl,%al
  20025b:	75 f5                	jne    200252 <console_vprintf+0x3b>
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  20025d:	81 e9 48 06 20 00    	sub    $0x200648,%ecx
  200263:	b8 01 00 00 00       	mov    $0x1,%eax
  200268:	d3 e0                	shl    %cl,%eax
  20026a:	45                   	inc    %ebp
  20026b:	09 04 24             	or     %eax,(%esp)
  20026e:	8a 55 00             	mov    0x0(%ebp),%dl
  200271:	84 d2                	test   %dl,%dl
  200273:	0f 84 70 03 00 00    	je     2005e9 <console_vprintf+0x3d2>
  200279:	b9 48 06 20 00       	mov    $0x200648,%ecx
  20027e:	eb d3                	jmp    200253 <console_vprintf+0x3c>
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  200280:	8d 42 cf             	lea    0xffffffcf(%edx),%eax
  200283:	3c 08                	cmp    $0x8,%al
  200285:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  20028c:	00 
  20028d:	76 13                	jbe    2002a2 <console_vprintf+0x8b>
  20028f:	eb 1d                	jmp    2002ae <console_vprintf+0x97>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  200291:	6b 44 24 04 0a       	imul   $0xa,0x4(%esp),%eax
  200296:	0f be d2             	movsbl %dl,%edx
  200299:	45                   	inc    %ebp
  20029a:	8d 54 02 d0          	lea    0xffffffd0(%edx,%eax,1),%edx
  20029e:	89 54 24 04          	mov    %edx,0x4(%esp)
  2002a2:	8a 55 00             	mov    0x0(%ebp),%dl
  2002a5:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  2002a8:	3c 09                	cmp    $0x9,%al
  2002aa:	76 e5                	jbe    200291 <console_vprintf+0x7a>
  2002ac:	eb 18                	jmp    2002c6 <console_vprintf+0xaf>
		} else if (*format == '*') {
  2002ae:	80 fa 2a             	cmp    $0x2a,%dl
  2002b1:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  2002b8:	ff 
  2002b9:	75 0b                	jne    2002c6 <console_vprintf+0xaf>
			width = va_arg(val, int);
  2002bb:	83 c7 04             	add    $0x4,%edi
			++format;
  2002be:	45                   	inc    %ebp
  2002bf:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  2002c2:	89 44 24 04          	mov    %eax,0x4(%esp)
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  2002c6:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
  2002cd:	ff 
  2002ce:	80 7d 00 2e          	cmpb   $0x2e,0x0(%ebp)
  2002d2:	75 4f                	jne    200323 <console_vprintf+0x10c>
			++format;
  2002d4:	45                   	inc    %ebp
			if (*format >= '0' && *format <= '9') {
  2002d5:	8a 55 00             	mov    0x0(%ebp),%dl
  2002d8:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  2002db:	3c 09                	cmp    $0x9,%al
  2002dd:	77 25                	ja     200304 <console_vprintf+0xed>
  2002df:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  2002e6:	00 
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  2002e7:	6b 44 24 08 0a       	imul   $0xa,0x8(%esp),%eax
  2002ec:	0f be d2             	movsbl %dl,%edx
  2002ef:	45                   	inc    %ebp
  2002f0:	8d 54 10 d0          	lea    0xffffffd0(%eax,%edx,1),%edx
  2002f4:	89 54 24 08          	mov    %edx,0x8(%esp)
  2002f8:	8a 55 00             	mov    0x0(%ebp),%dl
  2002fb:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  2002fe:	3c 09                	cmp    $0x9,%al
  200300:	77 12                	ja     200314 <console_vprintf+0xfd>
  200302:	eb e3                	jmp    2002e7 <console_vprintf+0xd0>
			} else if (*format == '*') {
  200304:	80 fa 2a             	cmp    $0x2a,%dl
  200307:	75 12                	jne    20031b <console_vprintf+0x104>
				precision = va_arg(val, int);
  200309:	83 c7 04             	add    $0x4,%edi
				++format;
  20030c:	45                   	inc    %ebp
  20030d:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  200310:	89 54 24 08          	mov    %edx,0x8(%esp)
			}
			if (precision < 0)
  200314:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  200319:	79 08                	jns    200323 <console_vprintf+0x10c>
  20031b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  200322:	00 
				precision = 0;
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  200323:	8a 45 00             	mov    0x0(%ebp),%al
  200326:	3c 64                	cmp    $0x64,%al
  200328:	74 34                	je     20035e <console_vprintf+0x147>
  20032a:	7f 1d                	jg     200349 <console_vprintf+0x132>
  20032c:	3c 58                	cmp    $0x58,%al
  20032e:	0f 84 bd 00 00 00    	je     2003f1 <console_vprintf+0x1da>
  200334:	3c 63                	cmp    $0x63,%al
  200336:	0f 84 eb 00 00 00    	je     200427 <console_vprintf+0x210>
  20033c:	3c 43                	cmp    $0x43,%al
  20033e:	0f 85 06 01 00 00    	jne    20044a <console_vprintf+0x233>
  200344:	e9 cf 00 00 00       	jmp    200418 <console_vprintf+0x201>
  200349:	3c 75                	cmp    $0x75,%al
  20034b:	74 5c                	je     2003a9 <console_vprintf+0x192>
  20034d:	3c 78                	cmp    $0x78,%al
  20034f:	74 6e                	je     2003bf <console_vprintf+0x1a8>
  200351:	3c 73                	cmp    $0x73,%al
  200353:	0f 85 f1 00 00 00    	jne    20044a <console_vprintf+0x233>
  200359:	e9 a4 00 00 00       	jmp    200402 <console_vprintf+0x1eb>
		case 'd': {
			int x = va_arg(val, int);
  20035e:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  200361:	b9 0a 00 00 00       	mov    $0xa,%ecx
  200366:	8b 5f fc             	mov    0xfffffffc(%edi),%ebx
  200369:	ff 74 24 08          	pushl  0x8(%esp)
  20036d:	89 d8                	mov    %ebx,%eax
  20036f:	c1 f8 1f             	sar    $0x1f,%eax
  200372:	89 c2                	mov    %eax,%edx
  200374:	68 4e 06 20 00       	push   $0x20064e
  200379:	31 da                	xor    %ebx,%edx
  20037b:	29 c2                	sub    %eax,%edx
  20037d:	8d 44 24 44          	lea    0x44(%esp),%eax
  200381:	e8 5e fe ff ff       	call   2001e4 <fill_numbuf>
			if (x < 0)
  200386:	85 db                	test   %ebx,%ebx
  200388:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  20038c:	5e                   	pop    %esi
  20038d:	be 01 00 00 00       	mov    $0x1,%esi
  200392:	58                   	pop    %eax
  200393:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
  20039a:	00 
  20039b:	0f 88 d1 00 00 00    	js     200472 <console_vprintf+0x25b>
  2003a1:	66 31 f6             	xor    %si,%si
  2003a4:	e9 c9 00 00 00       	jmp    200472 <console_vprintf+0x25b>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  2003a9:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  2003ac:	b9 0a 00 00 00       	mov    $0xa,%ecx
  2003b1:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  2003b4:	ff 74 24 08          	pushl  0x8(%esp)
  2003b8:	68 4e 06 20 00       	push   $0x20064e
  2003bd:	eb 14                	jmp    2003d3 <console_vprintf+0x1bc>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  2003bf:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  2003c2:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  2003c5:	ff 74 24 08          	pushl  0x8(%esp)
  2003c9:	68 5f 06 20 00       	push   $0x20065f
  2003ce:	b9 10 00 00 00       	mov    $0x10,%ecx
  2003d3:	8d 44 24 44          	lea    0x44(%esp),%eax
  2003d7:	31 f6                	xor    %esi,%esi
  2003d9:	e8 06 fe ff ff       	call   2001e4 <fill_numbuf>
  2003de:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%esp)
  2003e5:	00 
  2003e6:	89 44 24 1c          	mov    %eax,0x1c(%esp)
			numeric = 1;
			break;
  2003ea:	59                   	pop    %ecx
  2003eb:	5b                   	pop    %ebx
  2003ec:	e9 81 00 00 00       	jmp    200472 <console_vprintf+0x25b>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  2003f1:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  2003f4:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  2003f7:	ff 74 24 08          	pushl  0x8(%esp)
  2003fb:	68 4e 06 20 00       	push   $0x20064e
  200400:	eb cc                	jmp    2003ce <console_vprintf+0x1b7>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  200402:	83 c7 04             	add    $0x4,%edi
  200405:	31 f6                	xor    %esi,%esi
  200407:	8b 4f fc             	mov    0xfffffffc(%edi),%ecx
  20040a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  200411:	00 
  200412:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  200416:	eb 5a                	jmp    200472 <console_vprintf+0x25b>
			break;
		case 'C':
			color = va_arg(val, int);
  200418:	83 c7 04             	add    $0x4,%edi
  20041b:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  20041e:	89 44 24 54          	mov    %eax,0x54(%esp)
  200422:	e9 b4 01 00 00       	jmp    2005db <console_vprintf+0x3c4>
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  200427:	83 c7 04             	add    $0x4,%edi
			numbuf[1] = '\0';
  20042a:	31 f6                	xor    %esi,%esi
  20042c:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  20042f:	8d 54 24 28          	lea    0x28(%esp),%edx
  200433:	c6 44 24 29 00       	movb   $0x0,0x29(%esp)
  200438:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  20043f:	00 
  200440:	89 54 24 14          	mov    %edx,0x14(%esp)
  200444:	88 44 24 28          	mov    %al,0x28(%esp)
  200448:	eb 28                	jmp    200472 <console_vprintf+0x25b>
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  20044a:	84 c0                	test   %al,%al
  20044c:	75 02                	jne    200450 <console_vprintf+0x239>
  20044e:	b0 25                	mov    $0x25,%al
  200450:	88 44 24 28          	mov    %al,0x28(%esp)
  200454:	8d 44 24 28          	lea    0x28(%esp),%eax
			numbuf[1] = '\0';
  200458:	c6 44 24 29 00       	movb   $0x0,0x29(%esp)
			if (!*format)
  20045d:	80 7d 00 00          	cmpb   $0x0,0x0(%ebp)
  200461:	75 01                	jne    200464 <console_vprintf+0x24d>
				format--;
  200463:	4d                   	dec    %ebp
  200464:	31 f6                	xor    %esi,%esi
  200466:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  20046d:	00 
  20046e:	89 44 24 14          	mov    %eax,0x14(%esp)
			break;
		}

		if (precision >= 0)
  200472:	31 c0                	xor    %eax,%eax
  200474:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  200479:	78 16                	js     200491 <console_vprintf+0x27a>
			len = strnlen(data, precision);
  20047b:	ff 74 24 08          	pushl  0x8(%esp)
  20047f:	ff 74 24 18          	pushl  0x18(%esp)
  200483:	e8 eb fc ff ff       	call   200173 <strnlen>
  200488:	89 44 24 18          	mov    %eax,0x18(%esp)
  20048c:	58                   	pop    %eax
  20048d:	5a                   	pop    %edx
  20048e:	eb 0f                	jmp    20049f <console_vprintf+0x288>
  200490:	40                   	inc    %eax
  200491:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  200495:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  200499:	75 f5                	jne    200490 <console_vprintf+0x279>
		else
			len = strlen(data);
  20049b:	89 44 24 10          	mov    %eax,0x10(%esp)
		if (numeric && negative)
  20049f:	8a 54 24 0c          	mov    0xc(%esp),%dl
  2004a3:	84 d2                	test   %dl,%dl
  2004a5:	74 0c                	je     2004b3 <console_vprintf+0x29c>
  2004a7:	85 f6                	test   %esi,%esi
  2004a9:	c7 44 24 18 2d 00 00 	movl   $0x2d,0x18(%esp)
  2004b0:	00 
  2004b1:	75 22                	jne    2004d5 <console_vprintf+0x2be>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  2004b3:	f6 04 24 10          	testb  $0x10,(%esp)
  2004b7:	c7 44 24 18 2b 00 00 	movl   $0x2b,0x18(%esp)
  2004be:	00 
  2004bf:	75 14                	jne    2004d5 <console_vprintf+0x2be>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  2004c1:	8b 04 24             	mov    (%esp),%eax
  2004c4:	83 e0 08             	and    $0x8,%eax
  2004c7:	83 f8 01             	cmp    $0x1,%eax
  2004ca:	19 c0                	sbb    %eax,%eax
  2004cc:	f7 d0                	not    %eax
  2004ce:	83 e0 20             	and    $0x20,%eax
  2004d1:	89 44 24 18          	mov    %eax,0x18(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  2004d5:	84 d2                	test   %dl,%dl
  2004d7:	74 12                	je     2004eb <console_vprintf+0x2d4>
  2004d9:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  2004dd:	39 4c 24 08          	cmp    %ecx,0x8(%esp)
  2004e1:	7e 08                	jle    2004eb <console_vprintf+0x2d4>
			zeros = precision - len;
  2004e3:	8b 5c 24 08          	mov    0x8(%esp),%ebx
  2004e7:	29 cb                	sub    %ecx,%ebx
  2004e9:	eb 39                	jmp    200524 <console_vprintf+0x30d>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004eb:	8b 04 24             	mov    (%esp),%eax
  2004ee:	83 e0 06             	and    $0x6,%eax
  2004f1:	83 f8 02             	cmp    $0x2,%eax
  2004f4:	75 2c                	jne    200522 <console_vprintf+0x30b>
  2004f6:	84 d2                	test   %dl,%dl
  2004f8:	74 28                	je     200522 <console_vprintf+0x30b>
  2004fa:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  2004ff:	79 21                	jns    200522 <console_vprintf+0x30b>
  200501:	31 d2                	xor    %edx,%edx
  200503:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  200507:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  20050c:	0f 95 c2             	setne  %dl
  20050f:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
  200512:	3b 44 24 04          	cmp    0x4(%esp),%eax
  200516:	7d 0a                	jge    200522 <console_vprintf+0x30b>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  200518:	8b 5c 24 04          	mov    0x4(%esp),%ebx
  20051c:	29 cb                	sub    %ecx,%ebx
  20051e:	29 d3                	sub    %edx,%ebx
  200520:	eb 02                	jmp    200524 <console_vprintf+0x30d>
  200522:	31 db                	xor    %ebx,%ebx
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  200524:	8b 74 24 04          	mov    0x4(%esp),%esi
  200528:	31 c0                	xor    %eax,%eax
  20052a:	2b 74 24 10          	sub    0x10(%esp),%esi
  20052e:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  200533:	0f 95 c0             	setne  %al
  200536:	29 c6                	sub    %eax,%esi
  200538:	29 de                	sub    %ebx,%esi
  20053a:	eb 17                	jmp    200553 <console_vprintf+0x33c>
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  20053c:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  200540:	ba 20 00 00 00       	mov    $0x20,%edx
  200545:	4e                   	dec    %esi
  200546:	8b 44 24 50          	mov    0x50(%esp),%eax
  20054a:	e8 3c fc ff ff       	call   20018b <console_putc>
  20054f:	89 44 24 50          	mov    %eax,0x50(%esp)
  200553:	f6 04 24 04          	testb  $0x4,(%esp)
  200557:	75 04                	jne    20055d <console_vprintf+0x346>
  200559:	85 f6                	test   %esi,%esi
  20055b:	7f df                	jg     20053c <console_vprintf+0x325>
		if (negative)
  20055d:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  200562:	74 2f                	je     200593 <console_vprintf+0x37c>
			cursor = console_putc(cursor, negative, color);
  200564:	0f b6 54 24 18       	movzbl 0x18(%esp),%edx
  200569:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  20056d:	8b 44 24 50          	mov    0x50(%esp),%eax
  200571:	e8 15 fc ff ff       	call   20018b <console_putc>
  200576:	89 44 24 50          	mov    %eax,0x50(%esp)
  20057a:	eb 17                	jmp    200593 <console_vprintf+0x37c>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  20057c:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  200580:	ba 30 00 00 00       	mov    $0x30,%edx
  200585:	4b                   	dec    %ebx
  200586:	8b 44 24 50          	mov    0x50(%esp),%eax
  20058a:	e8 fc fb ff ff       	call   20018b <console_putc>
  20058f:	89 44 24 50          	mov    %eax,0x50(%esp)
  200593:	85 db                	test   %ebx,%ebx
  200595:	7f e5                	jg     20057c <console_vprintf+0x365>
  200597:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  20059b:	eb 19                	jmp    2005b6 <console_vprintf+0x39f>
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  20059d:	0f b6 53 ff          	movzbl 0xffffffff(%ebx),%edx
  2005a1:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  2005a5:	8b 44 24 50          	mov    0x50(%esp),%eax
  2005a9:	e8 dd fb ff ff       	call   20018b <console_putc>
  2005ae:	ff 4c 24 10          	decl   0x10(%esp)
  2005b2:	89 44 24 50          	mov    %eax,0x50(%esp)
  2005b6:	43                   	inc    %ebx
  2005b7:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  2005bc:	7f df                	jg     20059d <console_vprintf+0x386>
  2005be:	eb 17                	jmp    2005d7 <console_vprintf+0x3c0>
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  2005c0:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  2005c4:	ba 20 00 00 00       	mov    $0x20,%edx
  2005c9:	4e                   	dec    %esi
  2005ca:	8b 44 24 50          	mov    0x50(%esp),%eax
  2005ce:	e8 b8 fb ff ff       	call   20018b <console_putc>
  2005d3:	89 44 24 50          	mov    %eax,0x50(%esp)
  2005d7:	85 f6                	test   %esi,%esi
  2005d9:	7f e5                	jg     2005c0 <console_vprintf+0x3a9>
  2005db:	45                   	inc    %ebp
  2005dc:	8a 45 00             	mov    0x0(%ebp),%al
  2005df:	84 c0                	test   %al,%al
  2005e1:	0f 85 44 fc ff ff    	jne    20022b <console_vprintf+0x14>
  2005e7:	eb 15                	jmp    2005fe <console_vprintf+0x3e7>
  2005e9:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
  2005f0:	ff 
  2005f1:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  2005f8:	ff 
  2005f9:	e9 50 fe ff ff       	jmp    20044e <console_vprintf+0x237>
	done: ;
	}

	return cursor;
}
  2005fe:	8b 44 24 50          	mov    0x50(%esp),%eax
  200602:	83 c4 3c             	add    $0x3c,%esp
  200605:	5b                   	pop    %ebx
  200606:	5e                   	pop    %esi
  200607:	5f                   	pop    %edi
  200608:	5d                   	pop    %ebp
  200609:	c3                   	ret    

0020060a <console_printf>:

uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  20060a:	8d 44 24 10          	lea    0x10(%esp),%eax
  20060e:	50                   	push   %eax
  20060f:	ff 74 24 10          	pushl  0x10(%esp)
  200613:	ff 74 24 10          	pushl  0x10(%esp)
  200617:	ff 74 24 10          	pushl  0x10(%esp)
  20061b:	e8 f7 fb ff ff       	call   200217 <console_vprintf>
  200620:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  200623:	c3                   	ret    
