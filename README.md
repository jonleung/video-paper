Made a fun weekend side project: VideoPaper. Send videos through physical paper!

LIVE DEMO: 
Open this up in one tab
http://mew.hackedu.us:1121/printer

(to get this to auto-print, see directions inside of it)

And open this in another tab
http://mew.hackedu.us:1121/scanner

===============

Phone Client
1) Send video from phone to server

Server
2) Process Video
  a) extract image
  b) extract audio
3) Create an id for the image / audio pair
  a) /0aiafnljsdfanwonifsnlkjd/audio.mp3
  b) /0aiafnljsdfanwonifsnlkjd/image.png

3a)
  a) Generate a PDF and send it to the client
    b) Generate QR code that can be used to obtain the audio file
  b) Send an AUdio

Send To Display Client
3) Recieve Push
  x) Checks to see if it is the right phone number, if it is, it updates the images
  a) Gets PDF URL which it prints out?
  b) Plays audio at the same time?


4) When the client recognizes the QR Code
  a) Play the sound 


TODO
- Validate reading QR code from webcam
  - http://atandrastoth.co.uk/main/pages/plugins/codereader/
- Print automagically
  /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --kiosk-printing --kiosk
  /Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --kiosk-printing --kiosk
- Split a Video from Audio on a server
  -- ffmpeg
- Send Video from Phone to Server
  - twilio
- How do you display a PDF and music at the same time


Twilio
  naruto137+5@gmail.com
