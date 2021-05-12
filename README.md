# CMake message helpers.

small helper functions to display nice framed cmake messages

these functions are to print nice messsages in some boxes ...

you can control the output width with the `DISPLAY_WIDTH` var
which as a default value set to set(DISPLAY_WIDTH 80)

For instance
```
messageTitle(" Example ")
messageInfo(" Some information")
messageSetting("DISPLAY_WIDTH")
messageEnd()
```
Outputs
```
┌────────────────────────────────┤│ Example │├──────────────────────────────────┐
│  Some information                                                             │
│ DISPLAY_WIDTH                  80                                             │
└───────────────────────────────────────────────────────────────────────────────┘
```
Or outputs
```
┌──┤│ Example │├────┐
│  Some information │
│ DISPLAY_WIDTH    ⏎│
│                20 │
└───────────────────┘
```
Depending of the `DISPLAY_WIDTH` value.
