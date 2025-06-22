
# thief-gold-portmaster
A portmaster wrapper to run Thief Gold

# Installation
Drop all this repository content in the ports/thiefGold folder. Copy the "Thief Gold.sh" script to the ports folder.
Before launching Thief Gold in PortMaster, you must prepare a couple things :
## Warnings
This script is built around the RG552 device with Rocknix, it should be compatible with other devices with some tweaking. You may have to adapt the Wine prefix desktop's resolution and the game resolution, probably remap the controls too.
## Requirements
- **You will need a keyboard during the installation process** to type some Wine configuration and change the game installation folder to C:\thief
- The installation process need internet access to download Wine 8.7 binaries
- Copy Thief Gold installer file from GOG to the port's data folder, named **setup_thief_gold_1.26_nd_(21948).exe**
- Copy Thief Gold TFix 1.27b installer file to the port's data folder, named  **TFix_1.27b.exe**
- (Optional) to install the French translation, copy the community patch installer to the port's data folder, named **ThiefGold_FrenchPatch12b5.exe**
## Setup process

On the first launch the script will help you setup the game. The mouse is mapped to the right joystick with L1 and R1 as mouse buttons. You will have to perform some actions manually :
- **Launch winecfg**. You have to override ir50_32 dll in the "libraries" tab. Then check "Emulate a virtual desktop" and set the resolution to 960x592. Once done, click apply then OK
- **Install the game with GOG installer**. Click "options" then change the game installation folder to **C:\thief**, then proceed with the installation. The keyboard is no more necessary from this point.
- **Install TFix 1.27b patch**. Click "browse" and choose the game installation folder **C:\thief**, proceed with the update. During the installation you will be prompted to disable anti-aliasing, keep it turned off for performances purpose.
- **(Only if the installation file is present) Install the French translation community patch**. Indicate the game installation folder **C:\thief** and proceed with the update.
- **Copy basic configuration files for the RG552**. No manual actions to do here.
- **Launch the game**. Click "Options" then enable Joystick support to ON. Click "Customize Controls..." then "Load", in the list click on "My Binds" then "LOAD". Finally click on DONE. Click on "Quit" to exit the game and save your configuration.

All set ! You can enjoy Thief Gold with full cutscenes and controller support now !
You can now delete the .exe files in the port's data folder.
# Controls
Left stick : move forward, strafe left/right, backward
Right Stick : mouse look
R1 : left click
L1 : right click
L2 : quick load
R2 : quick save
L3 : crouch
Dpad up/down : change weapon
Dpad left/right : change object
A : unmapped
B : jump
X : clear weapon
Y : drop object in hands
