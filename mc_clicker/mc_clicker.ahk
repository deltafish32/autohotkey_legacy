; tested environment
;   screen resolution: 1920*1080
;   version: 1.19.2
;   gui scale: auto
;   fov: 70 (default)
;   windows mouse point speed: center


function := ""


FunctionToggle(f) {
	global function
	
	if (function != f) {
		function := f
	}
	else {
		function := ""
	}
}


RelativeMouseMove(x, y, smooth := 1, smooth_delay := 16) {
	Loop %smooth% {
		tx := x / smooth
		ty := y / smooth
		DllCall("mouse_event", "UInt", 0x0001, "Int", tx, "Int", ty, "UInt", 0, "UPtr", 0)
		Sleep, %smooth_delay%
	}
}



Loop {
	if (function == "je_sell") {
		Send, {Shift down}
		Loop 8 {
			MouseClick, Left
			Send, {Space}
			Sleep, 80
		}
		Send, {Shift up}
		function = 0;
	}
	else if (function == "lclick_repeat") {
		MouseClick, Left
		Sleep, 80
	}
	else if (function == "lclick_hold") {
		Click down
		while function == "lclick_hold" {
			Sleep, 100
		}
		Click up
	}
	else if (function == "rclick_repeat") {
		MouseClick, Right
		Sleep, 100
	}
	else if (function == "block_jump") {
		Click down Right
		Send, {space down}
		while function == "block_jump" {
			Sleep, 100
		}
		Send, {space up}
		Click up Right
	}
	else if (function == "wood") {
		mouse_down = 0
	
		mouse_speed = 2
		delta = 1
		ddelta := delta * 2
		
		step = 0
		while function == "wood" {
			base = 40
			smooth = 5
			smooth_delay = 16
			
			if (step == 0) {
				RelativeMouseMove(-5 * base, -3 * base, smooth, smooth_delay)
				if (mouse_down == 0) {
					mouse_down = 1
					Click down Left
				}
				step = 1
			}
			else if (step == 1) {
				RelativeMouseMove(10 * base, 0, smooth, smooth_delay)
				step = 2
			}
			else if (step == 2) {
				RelativeMouseMove(-5 * base, -1 * base, smooth, smooth_delay)
				step = 3
			}
			else if (step == 3) {
				RelativeMouseMove(0, 4 * base, smooth, smooth_delay)
				step = 0
			}
			
			total_sleep := 400 - (smooth * smooth_delay) ; Diamond Axe Efficiency V
			; total_sleep := 500 - (smooth * smooth_delay) ; Iron Axe Efficiency III
			; total_sleep := 840 - (smooth * smooth_delay) ; Iron Axe
			Sleep, %total_sleep%
		}
		
		if (mouse_down != 0) {
			Click up Left
		}
	}
	else if (function == "stick") {
		ImageSearch, ix, iy, 348, 236, 876, 840, plank.png
		
		if (ErrorLevel == 0) {
			ix += 48
			iy += 48
			
			MouseMove, ix, iy, 0
			Send, {Shift down}
			MouseClick, Left
			MouseMove, 1564, 352, 0
			MouseClick, Left
			Send, {Shift up}
		}
		
		Loop 2 {
			ImageSearch, ix, iy, 348, 236, 876, 840, stick.png
			
			if (ErrorLevel == 0) {
				ix += 48
				iy += 48
				MouseMove, ix, iy, 0
				Send, {Shift down}
				MouseClick, Left
				MouseMove, 1564, 352, 0
				MouseClick, Left
				Send, {Shift up}
			}
		}
	
		function := ""
	}
}
return




f1::FunctionToggle("stick")
return

f4::FunctionToggle("wood")
return

f6::FunctionToggle("je_sell")
return

f7::FunctionToggle("lclick_repeat")
return

f8::FunctionToggle("lclick_hold")
return

f9::FunctionToggle("block_jump")
return
