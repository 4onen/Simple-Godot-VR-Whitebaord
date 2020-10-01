# Simple Godot VR Whiteboard

## About

This repo is a simple whiteboarding app, built on [Godot-OpenVR](https://github.com/GodotVR/godot_openvr)
and developed targeting *Windows Mixed Reality*. I started it
with the intent to use it with my Teacher's Assistant position
at UCSB, only to realize that more realtime solutions 
(such as [Google Jamboard](https://edu.google.com/products/jamboard/))
were available.

The repository is a [Godot](https://godotengine.org/) project, made
in the edition of Godot 3.2 released on Steam.

## Use

Upon entering the app, you will be standing before the whiteboard.

A dry-erase pen is available on the platform to your right, which
can be picked up and dropped with your VR drivers' `VR_GRIP` control.
Pressing `VR_TRIGGER` will change the color of the pen's tip. White
serves as an eraser.

To your left is a row of buttons. From left to right, the functions
of these buttons are:

| Leftmost | Center-left | Center-right | Rightmost |
| -------- | ----------- | ------------ | --------- |
| Move to next board left | Reload current board from disk | Save all boards | Move to next board right (add new board if no more boards to the right) |

With these, you may request from the aether as much whiteboard space
as you may find that you need.

If your VR play environment is not sufficiently large to reach all parts 
of the whiteboard, you may find the "Space Drag" feature in
[OpenVR Advanced Settings](https://store.steampowered.com/app/1009850/OVR_Advanced_Settings/)
very useful. 

## Export

All whiteboards are saved to your Godot data directory, in an
application folder called "Whiteboard". On Windows, that path is:

    C:\Users\YOUR_USERNAME\AppData\Roaming\Godot\app_userdata\Whiteboard\Whiteboard

where `YOUR_USERNAME` is the name of your windows user directory.

The whiteboards are saved as PNG images, labeled left-to-right in
ascending order.

## Import

Any PNG image may be loaded as a whiteboard, but all whiteboard images
are assumed to be 1024x512 pixels, and will be cropped or expanded
to that size.

Any PNGs found in the whiteboard folder described in the **Export** section
will be loaded in lexographic order as whiteboards, and will be overwritten
when the in-world save button is pressed.

## Development

The basic techniques used to develop this app come from the execellent
[Godot VR Weapons Tutorial](https://www.youtube.com/watch?v=KaJSifo8Wis&list=PLe63S5Eft1KaIq9N5PsS5FA3pcLrh686y&ab_channel=BastiaanOlij)
by Bastiaan Olij on YouTube. Part 3, on firing the gun, is exactly the
implementation used for the pen to work, barring some tweaks to add
color and scale parameters and check collisions continuously.

The physical buttons are carefully calibrated Generic 6DOF joints.
They are debounced by script, by entering a "pressed" state when they
fall below a certain height, then leaving that state only when they
return to above a higher point. This state has no impact on their
physical forces, instead only emitting pressed and unpressed signals.

