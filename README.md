# CMake message helpers

small helper functions to display nice framed cmake messages

these functions are to print nice messsages in some boxes ...

## Installation

In your git project

```{.sh}
git submodule add https://github.com/dlyr/cmake-message-helpers.git cmake/cmake-message-helpers
```

And in your `CMakeLists.txt`

```{.cmake}
include(${CMAKE_SOURCE_DIR}/cmake/cmake-message-helpers/MessageHelpers.cmake)
```

or 

```{.cmake}
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/cmake-message-helpers/ )
include(MessageHelpers)
```

## Usage

you can control the output width with the `DISPLAY_WIDTH` var
which as a default value set to set(DISPLAY_WIDTH 80)

For instance

```{.cmake}
message_title(" Example ")
message_info(" Some information")
message_setting("DISPLAY_WIDTH")
message_end()
```

Outputs

```{.sh}
┌────────────────────────────────┤│ Example │├──────────────────────────────────┐
│  Some information                                                             │
│ DISPLAY_WIDTH                  80                                             │
└───────────────────────────────────────────────────────────────────────────────┘
```

Or outputs

```{.sh}
┌──┤│ Example │├────┐
│  Some information │
│ DISPLAY_WIDTH    ⏎│
│                20 │
└───────────────────┘
```

Depending of the `DISPLAY_WIDTH` value.

## Example `CMakeLists.txt`

```{.sh}
> cmake -S . -B build
#outputs

normal message
-- status message
CMake Warning at CMakeLists.txt:21 (message):
  warning message


[prefix1] normal message
-- [prefix1] status message
CMake Warning at CMakeLists.txt:26 (message):
  warning message ignores prefix


[prefix1] [prefix2] normal message
-- [prefix1] [prefix2] status message
[prefix1] normal message
-- [prefix1] status message

┌─────────────────────┤│ Final overview for TestMessage │├──────────────────────┐
│                                                                               │
│ Version:               0.2. @                                                 │
│ Git Changeset: 61bfe6dc7d8ca34a9ce10f3975819a5e7b222400                       │
│                                                                               │
│ Install prefix:                                                               │
│   /usr/local                                                                  │
│                                                                               │
│ Compiler: /usr/bin/c++ - GNU in version 12.2.0.                               │
│ CMAKE_BUILD_TYPE                                                              │
│   possible options: Debug Release RelWithDebInfo MinSizeRel                   │
│   set with ` cmake -DCMAKE_BUILD_TYPE=Debug .. `                              │
│                                                                               │
│ print setting                                                                 │
│ TEST_GENERATE_LIB              ON                                             │
│                                                                               │
│ print option with help                                                        │
│ TEST_GENERATE_LIB              ON                                             │
│ Do generate lib ?                                                             │
│                                                                               │
│  -- Configured components: Test1 Test1                                        │
└───────────────────────────────────────────────────────────────────────────────┘

-- Configuring done
-- Generating done
```
