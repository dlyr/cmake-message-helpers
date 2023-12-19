# CMake message helpers.

small helper functions to display nice framed cmake messages

these functions are to print nice messsages in some boxes ...
## Installation
 
In your git project
```{.sh}
git submodule add https://github.com/dlyr/cmake-message-helpers.git cmake/cmake-message-helpers
```

And in your `CMakeLists.txt`
```{.cmake}
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake-message-helpers/message-helpers.cmake)
```

## Usage

you can control the output width with the `DISPLAY_WIDTH` var
which as a default value set to set(DISPLAY_WIDTH 80)

For instance
```
message_title(" Example ")
message_info(" Some information")
message_setting("DISPLAY_WIDTH")
message_end()
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
