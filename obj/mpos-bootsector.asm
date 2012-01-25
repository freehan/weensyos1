
obj/mpos-bootsector.out:     file format elf32-i386

Disassembly of section .text:

00007c00 <start>:
.set CR0_PE_ON,0x1		# protected mode enable flag

.globl start					# Entry point
start:		.code16				# This runs in real mode
		cli				# Disable interrupts
    7c00:	fa                   	cli    
		cld				# String operations increment
    7c01:	fc                   	cld    

		# Set up the important data segment registers (DS, ES, SS).
		xorw	%ax,%ax			# Segment number zero
    7c02:	31 c0                	xor    %eax,%eax
		movw	%ax,%ds			# -> Data Segment
    7c04:	8e d8                	movl   %eax,%ds
		movw	%ax,%es			# -> Extra Segment
    7c06:	8e c0                	movl   %eax,%es
		movw	%ax,%ss			# -> Stack Segment
    7c08:	8e d0                	movl   %eax,%ss

		# Set up the stack pointer, growing downward from 0x7c00.
		movw	$start,%sp         	# Stack Pointer
    7c0a:	bc 00 7c e4 64       	mov    $0x64e47c00,%esp

00007c0d <seta20.1>:

# Enable A20:
#   For fascinating historical reasons (related to the fact that
#   the earliest 8086-based PCs could only address 1MB of physical memory
#   and subsequent 80286-based PCs wanted to retain maximum compatibility),
#   physical address line 20 is tied to low when the machine boots.
#   Obviously this a bit of a drag for us, especially when trying to
#   address memory above 1MB.  This code undoes this.

seta20.1:	inb	$0x64,%al		# Get status
    7c0d:	e4 64                	in     $0x64,%al
		testb	$0x2,%al		# Busy?
    7c0f:	a8 02                	test   $0x2,%al
		jnz	seta20.1		# Yes
    7c11:	75 fa                	jne    7c0d <seta20.1>
		movb	$0xd1,%al		# Command: Write
    7c13:	b0 d1                	mov    $0xd1,%al
		outb	%al,$0x64		#  output port
    7c15:	e6 64                	out    %al,$0x64

00007c17 <seta20.2>:
seta20.2:	inb	$0x64,%al		# Get status
    7c17:	e4 64                	in     $0x64,%al
		testb	$0x2,%al		# Busy?
    7c19:	a8 02                	test   $0x2,%al
		jnz	seta20.2		# Yes
    7c1b:	75 fa                	jne    7c17 <seta20.2>
		movb	$0xdf,%al		# Enable
    7c1d:	b0 df                	mov    $0xdf,%al
		outb	%al,$0x60		#  A20
    7c1f:	e6 60                	out    %al,$0x60

00007c21 <real_to_prot>:

# Switch from real to protected mode:
#   Up until now, there's been no protection, so we've gotten along perfectly
#   well without explicitly telling the processor how to translate addresses.
#   When we switch to protected mode, this is no longer true!
#   We need at least to set up some "segments" that tell the processor it's
#   OK to run code at any address, or write to any address.
#   The 'gdt' and 'gdtdesc' tables below define these segments.
#   This code loads them into the processor.
#   We need this setup to ensure the transition to protected mode is smooth.

real_to_prot:	cli			# Don't allow interrupts: mandatory,
    7c21:	fa                   	cli    
					# since we didn't set up an interrupt
					# descriptor table for handling them
		lgdt	gdtdesc		# load GDT: mandatory in protected mode
    7c22:	0f 01 16             	lgdtl  (%esi)
    7c25:	64                   	fs
    7c26:	7c 0f                	jl     7c37 <protcseg+0x1>
		movl	%cr0, %eax	# Turn on protected mode
    7c28:	20 c0                	and    %al,%al
		orl	$CR0_PE_ON, %eax
    7c2a:	66 83 c8 01          	or     $0x1,%ax
		movl	%eax, %cr0
    7c2e:	0f 22 c0             	mov    %eax,%cr0

	        # CPU magic: jump to relocation, flush prefetch queue, and
		# reload %cs.  Has the effect of just jmp to the next
		# instruction, but simultaneously loads CS with
		# $SEGSEL_BOOT_CODE.
		ljmp	$SEGSEL_BOOT_CODE, $protcseg
    7c31:	ea 36 7c 08 00 66 b8 	ljmp   $0xb866,$0x87c36

00007c36 <protcseg>:

		.code32			# run in 32-bit protected mode
		# Set up the protected-mode data segment registers
protcseg:	movw	$SEGSEL_BOOT_DATA, %ax	# Our data segment selector
    7c36:	66 b8 10 00          	mov    $0x10,%ax
		movw	%ax, %ds		# -> DS: Data Segment
    7c3a:	8e d8                	movl   %eax,%ds
		movw	%ax, %es		# -> ES: Extra Segment
    7c3c:	8e c0                	movl   %eax,%es
		movw	%ax, %fs		# -> FS
    7c3e:	8e e0                	movl   %eax,%fs
		movw	%ax, %gs		# -> GS
    7c40:	8e e8                	movl   %eax,%gs
		movw	%ax, %ss		# -> SS: Stack Segment
    7c42:	8e d0                	movl   %eax,%ss

		call bootmain		# finish the boot!  Shouldn't return,
    7c44:	e8 d8 00 00 00       	call   7d21 <bootmain>

00007c49 <spinloop>:

spinloop:	jmp spinloop		# ..but in case it does, spin.
    7c49:	eb fe                	jmp    7c49 <spinloop>
    7c4b:	90                   	nop    

00007c4c <gdt>:
	...
    7c54:	ff                   	(bad)  
    7c55:	ff 00                	incl   (%eax)
    7c57:	00 00                	add    %al,(%eax)
    7c59:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7c60:	00 92 cf 00 17 00    	add    %dl,0x1700cf(%edx)

00007c64 <gdtdesc>:
    7c64:	17                   	pop    %ss
    7c65:	00 4c 7c 00          	add    %cl,0x0(%esp,%edi,2)
    7c69:	00 90 90 ba f7 01    	add    %dl,0x1f7ba90(%eax)

00007c6c <waitdisk>:
static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
    7c6c:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7c71:	ec                   	in     (%dx),%al
void
waitdisk(void)
{
	// wait for disk reaady
	while ((inb(0x1F7) & 0xC0) != 0x40)
    7c72:	25 c0 00 00 00       	and    $0xc0,%eax
    7c77:	83 f8 40             	cmp    $0x40,%eax
    7c7a:	75 f0                	jne    7c6c <waitdisk>
		/* do nothing */;
}
    7c7c:	c3                   	ret    

00007c7d <readsect>:

void
readsect(void *dst, uint32_t sect)
{
    7c7d:	57                   	push   %edi
    7c7e:	8b 7c 24 08          	mov    0x8(%esp),%edi
    7c82:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
    7c86:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7c8b:	ec                   	in     (%dx),%al
    7c8c:	25 c0 00 00 00       	and    $0xc0,%eax
    7c91:	83 f8 40             	cmp    $0x40,%eax
    7c94:	75 f0                	jne    7c86 <readsect+0x9>

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
    7c96:	b0 01                	mov    $0x1,%al
    7c98:	b2 f2                	mov    $0xf2,%dl
    7c9a:	ee                   	out    %al,(%dx)
    7c9b:	0f b6 c1             	movzbl %cl,%eax
    7c9e:	b2 f3                	mov    $0xf3,%dl
    7ca0:	ee                   	out    %al,(%dx)
    7ca1:	0f b6 c5             	movzbl %ch,%eax
    7ca4:	b2 f4                	mov    $0xf4,%dl
    7ca6:	ee                   	out    %al,(%dx)
    7ca7:	c1 e9 10             	shr    $0x10,%ecx
    7caa:	b2 f5                	mov    $0xf5,%dl
    7cac:	0f b6 c1             	movzbl %cl,%eax
    7caf:	ee                   	out    %al,(%dx)
    7cb0:	c1 e9 08             	shr    $0x8,%ecx
    7cb3:	b2 f6                	mov    $0xf6,%dl
    7cb5:	80 c9 e0             	or     $0xe0,%cl
    7cb8:	88 c8                	mov    %cl,%al
    7cba:	ee                   	out    %al,(%dx)
    7cbb:	b0 20                	mov    $0x20,%al
    7cbd:	b2 f7                	mov    $0xf7,%dl
    7cbf:	ee                   	out    %al,(%dx)
    7cc0:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7cc5:	ec                   	in     (%dx),%al
    7cc6:	25 c0 00 00 00       	and    $0xc0,%eax
    7ccb:	83 f8 40             	cmp    $0x40,%eax
    7cce:	75 f0                	jne    7cc0 <readsect+0x43>

static inline void
insl(int port, void *addr, int cnt)
{
	asm volatile("cld\n\trepne\n\tinsl"			:
    7cd0:	b2 f0                	mov    $0xf0,%dl
    7cd2:	b9 80 00 00 00       	mov    $0x80,%ecx
    7cd7:	fc                   	cld    
    7cd8:	f2 6d                	repnz insl (%dx),%es:(%edi)
	// wait for disk to be ready
	waitdisk();

	outb(0x1F2, 1);		// count = 1
	outb(0x1F3, sect);
	outb(0x1F4, sect >> 8);
	outb(0x1F5, sect >> 16);
	outb(0x1F6, (sect >> 24) | 0xE0);
	outb(0x1F7, 0x20);	// cmd 0x20 - read sectors

	// wait for disk to be ready
	waitdisk();

	// read a sector
	insl(0x1F0, dst, SECTORSIZE/4);
}
    7cda:	5f                   	pop    %edi
    7cdb:	c3                   	ret    

00007cdc <readseg>:
    7cdc:	55                   	push   %ebp
    7cdd:	57                   	push   %edi
    7cde:	56                   	push   %esi
    7cdf:	53                   	push   %ebx
    7ce0:	8b 44 24 14          	mov    0x14(%esp),%eax
    7ce4:	8b 74 24 18          	mov    0x18(%esp),%esi
    7ce8:	8b 6c 24 1c          	mov    0x1c(%esp),%ebp
    7cec:	8b 7c 24 20          	mov    0x20(%esp),%edi
    7cf0:	89 c3                	mov    %eax,%ebx
    7cf2:	01 c6                	add    %eax,%esi
    7cf4:	81 e3 00 fe ff ff    	and    $0xfffffe00,%ebx
    7cfa:	01 c5                	add    %eax,%ebp
    7cfc:	eb 10                	jmp    7d0e <readseg+0x32>
    7cfe:	57                   	push   %edi
    7cff:	47                   	inc    %edi
    7d00:	53                   	push   %ebx
    7d01:	81 c3 00 02 00 00    	add    $0x200,%ebx
    7d07:	e8 71 ff ff ff       	call   7c7d <readsect>
    7d0c:	58                   	pop    %eax
    7d0d:	5a                   	pop    %edx
    7d0e:	39 f3                	cmp    %esi,%ebx
    7d10:	72 ec                	jb     7cfe <readseg+0x22>
    7d12:	eb 04                	jmp    7d18 <readseg+0x3c>
    7d14:	c6 06 00             	movb   $0x0,(%esi)
    7d17:	46                   	inc    %esi
    7d18:	39 ee                	cmp    %ebp,%esi
    7d1a:	72 f8                	jb     7d14 <readseg+0x38>
    7d1c:	5b                   	pop    %ebx
    7d1d:	5e                   	pop    %esi
    7d1e:	5f                   	pop    %edi
    7d1f:	5d                   	pop    %ebp
    7d20:	c3                   	ret    

00007d21 <bootmain>:
    7d21:	56                   	push   %esi
    7d22:	53                   	push   %ebx
    7d23:	6a 01                	push   $0x1
    7d25:	68 00 10 00 00       	push   $0x1000
    7d2a:	68 00 10 00 00       	push   $0x1000
    7d2f:	68 00 00 01 00       	push   $0x10000
    7d34:	e8 a3 ff ff ff       	call   7cdc <readseg>
    7d39:	83 c4 10             	add    $0x10,%esp
    7d3c:	81 3d 00 00 01 00 7f 	cmpl   $0x464c457f,0x10000
    7d43:	45 4c 46 
    7d46:	75 45                	jne    7d8d <bootmain+0x6c>
    7d48:	8b 1d 1c 00 01 00    	mov    0x1001c,%ebx
    7d4e:	0f b7 05 2c 00 01 00 	movzwl 0x1002c,%eax
    7d55:	81 c3 00 00 01 00    	add    $0x10000,%ebx
    7d5b:	c1 e0 05             	shl    $0x5,%eax
    7d5e:	8d 34 03             	lea    (%ebx,%eax,1),%esi
    7d61:	eb 1c                	jmp    7d7f <bootmain+0x5e>
    7d63:	8b 43 04             	mov    0x4(%ebx),%eax
    7d66:	c1 e8 09             	shr    $0x9,%eax
    7d69:	40                   	inc    %eax
    7d6a:	50                   	push   %eax
    7d6b:	ff 73 14             	pushl  0x14(%ebx)
    7d6e:	ff 73 10             	pushl  0x10(%ebx)
    7d71:	ff 73 08             	pushl  0x8(%ebx)
    7d74:	83 c3 20             	add    $0x20,%ebx
    7d77:	e8 60 ff ff ff       	call   7cdc <readseg>
    7d7c:	83 c4 10             	add    $0x10,%esp
    7d7f:	39 f3                	cmp    %esi,%ebx
    7d81:	72 e0                	jb     7d63 <bootmain+0x42>
    7d83:	ba 18 00 01 00       	mov    $0x10018,%edx
    7d88:	31 c0                	xor    %eax,%eax
    7d8a:	89 d4                	mov    %edx,%esp
    7d8c:	c3                   	ret    
    7d8d:	5b                   	pop    %ebx
    7d8e:	5e                   	pop    %esi
    7d8f:	c3                   	ret    
