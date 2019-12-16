#define MTIME_BASE 			((volatile unsigned *) 0x3000000)
#define MTIME_CMP_BASE	(MTIME_BASE + 2)

typedef unsigned long long uint64;
typedef unsigned uint32;

/**
 * read the 64 bit mtime 
 */
inline uint64 readMTime () {
	return *((volatile uint64 *) MTIME_BASE);
}

/**
 * read the 64 bit mtimecmp 
 */
inline uint64 readMTimecmp () {
	return *((volatile uint64 *) MTIME_CMP_BASE);
}

/**
 * write the 64 bit mtime
 */
inline void writeMTime (uint64 val) {
	*((volatile uint64 *) MTIME_BASE) = val;
}

/**
 * write the 64 bit mtimecmp
 */
inline void writeMTimecmp (uint64 val) {
	*((volatile uint64 *) MTIME_CMP_BASE) = val;
}

/**
 * write upper 32 bits of mtime
 */
inline void writeMTimeUpper (uint32 val) {
	*(MTIME_BASE + 1) = val;
}

/**
 * write lower 32 bits of mtime
 */
inline void writeMTimeLower (uint32 val) {
	*MTIME_BASE = val;
}

/**
 * write upper 32 bits of mtimecmp
 */
inline void writeMTimecmpUpper (uint32 val) {
	*(MTIME_CMP_BASE + 1) = val;
}

/**
 * write lower 32 bits of mtime
 */
inline void writeMTimecmpLower (uint32 val) {
	*MTIME_CMP_BASE = val;
}