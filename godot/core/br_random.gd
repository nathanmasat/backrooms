class_name BRRandom
extends RefCounted
## The browser game's random numbers, bit for bit (mulberry32), so a seed makes the same level in both games.
## Browser: _s=(_s+0x6D2B79F5)|0; t=imul(_s^_s>>>15,1|_s); t=t+imul(t^t>>>7,61|t)^t; return ((t^t>>>14)>>>0)/4294967296

var _s: int = 1


func _init(seed_value: int = 1) -> void:
	_s = i32(seed_value)


## Wrap to a signed 32-bit integer (like JavaScript's `|0`).
static func i32(x: int) -> int:
	x = x & 0xFFFFFFFF
	return x - 0x100000000 if x >= 0x80000000 else x


## As an unsigned 32-bit integer (like JavaScript's `>>>0`).
static func u32(x: int) -> int:
	return x & 0xFFFFFFFF


## JavaScript's Math.imul: the low 32 bits of a*b, computed in 16-bit halves so nothing overflows.
static func imul(a: int, b: int) -> int:
	var ua := u32(a)
	var ub := u32(b)
	var al := ua & 0xFFFF
	var ah := ua >> 16
	var bl := ub & 0xFFFF
	var bh := ub >> 16
	var lo := al * bl
	var mid := ((ah * bl + al * bh) & 0xFFFF) << 16
	return i32(lo + mid)


## A number from 0 (inclusive) to 1 (exclusive): the browser's R().
func next_float() -> float:
	_s = i32(_s + 0x6D2B79F5)
	var t := imul(_s ^ (u32(_s) >> 15), 1 | _s)
	t = i32(i32(t + imul(t ^ (u32(t) >> 7), 61 | t)) ^ t)
	return float(u32(t ^ (u32(t) >> 14))) / 4294967296.0


## The browser's `(R()*n|0)`: a whole number from 0 to n-1.
func next_int(n: int) -> int:
	return int(floor(next_float() * n))


## How current Chrome (V8 in Chrome 141) sorts a short list with a comparator: a binary insertion sort.
## The browser shuffles maze directions with `.sort(()=>R()-.5)`, so the comparisons must happen
## in exactly Chrome's order for the maze to come out the same.
static func chrome_sort(arr: Array, cmp: Callable) -> Array:
	var a := arr.duplicate()
	for start in range(1, a.size()):
		var left := 0
		var right := start
		var pivot = a[start]
		while left < right:
			var mid := left + ((right - left) >> 1)
			var order: float = cmp.call(pivot, a[mid])
			if order < 0.0:
				right = mid
			else:
				left = mid + 1
		var p := start
		while p > left:
			a[p] = a[p - 1]
			p -= 1
		a[left] = pivot
	return a
