j:=1



/*
; set center points

NumpadEnter::
SetMouseDelay -1
SetDefaultMouseSpeed 0

shift=38

y:=225

Loop, 21
{
x:=442

Loop, 21
{
   click %x%, %y%
   x:=x+shift
}

y:=y+shift
}
return
*/


/*
; create conections 

NumpadEnter::
SetMouseDelay -1
SetDefaultMouseSpeed 0

shift=38

y:=225

Loop, 21
{
x:=442

Loop, 21
{
   click left, %x%, %y%, down
   shifted:=x+shift
   click left, %shifted%, %y%, up

   click left, %x%, %y%, down
   shifted:=y+shift
   click left, %x%, %shifted%, up

   x:=x+shift
}

y:=y+shift
}
return
*/

/*
; name territories

NumpadEnter::
SetMouseDelay -1
SetDefaultMouseSpeed 0

shift=38


i=1

y:=225

Loop, 21
{
x:=442

Loop, 21
{
   click %x%, %y%
   x:=x+shift

   sleep 100

   sendraw %i%
   i:=i+1

   sleep 200
}

y:=y+shift
}
return
*/


/*
; create bonuses

Numpad1::SendRaw #008000
Numpad2::SendRaw #0000ff
Numpad3::SendRaw #800000
Numpad4::SendRaw #00ffff
Numpad5::SendRaw #ffff00
Numpad6::SendRaw #800080
Numpad7::SendRaw #ff7f2a

NumpadAdd::
SetMouseDelay -1
SetDefaultMouseSpeed 0

send {enter}
MouseClick, left,  598,  610
return

Numpad0::
SetMouseDelay -1
SetDefaultMouseSpeed 0

MouseClick, left,  817,  668
Sleep, 100
MouseClick, left,  624,  556
Sleep, 100
Send, {BACKSPACE}5
MouseClick, left,  624,  521
Sleep, 100
Send, %j%
MouseClick, left,  598,  584

j:=j+1
return
*/


/*
; select a 3x3 square

NumpadEnter::
SetMouseDelay -1
SetDefaultMouseSpeed 0

mousegetpos startx, starty



shift=38

y:=starty

Loop, 3
{
x:=startx

Loop, 3
{
   Send ^{Click %x%, %y%}
   x:=x+shift
}

y:=y+shift
}
return
*/
