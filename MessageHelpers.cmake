# Author David Vanderhaeghe (@dlyr)
# Licence GPL3.0

# these functions are to print nice messages in some boxes ...

# you can control the output width with the DISPLAY_WIDTH var which as a default value set to
# set(DISPLAY_WIDTH 80)

# ~~~
# For instance
#
# message_title(" Example ")
# message_info(" Some information")
# message_setting("DISPLAY_WIDTH")
# message_end()
#
# Outputs
#
# ┌────────────────────────────────┤│ Example │├──────────────────────────────────┐
# │  Some information                                                             │
# │ DISPLAY_WIDTH                  80                                             │
# └───────────────────────────────────────────────────────────────────────────────┘
#
# Or outputs
#
# ┌──┤│ Example │├────┐
# │  Some information │
# │ DISPLAY_WIDTH    ⏎│
# │                20 │
# └───────────────────┘
#
# Depending of the DISPLAY_WIDTH value
# ~~~

# set default value
if(NOT DEFINED DISPLAY_WIDTH)
    set(DISPLAY_WIDTH 80)
endif()

# message_format used internally
function(message_format TEXT PRE PRE_LEN POST POST_LEN FILL)
    set(TEXT_LEN 0)
    if(TEXT)
        string(LENGTH ${TEXT} TEXT_LEN)
    endif()
    math(EXPR LEN "${DISPLAY_WIDTH} - ${TEXT_LEN} - ${PRE_LEN} - ${POST_LEN}")
    set(FILL1 "")
    if(LEN LESS 0)
        math(EXPR SUBLEN "${DISPLAY_WIDTH} - ${PRE_LEN} - ${POST_LEN}-1")
        string(SUBSTRING ${TEXT} 0 ${SUBLEN} STRING1)
        math(EXPR PL2 "${POST_LEN}+1")
        message_format(${STRING1} ${PRE} ${PRE_LEN} "⏎${POST}" ${PL2} ${FILL})
        string(SUBSTRING ${TEXT} ${SUBLEN} -1 STRING2)
        message_format(${STRING2} ${PRE} ${PRE_LEN} ${POST} ${POST_LEN} ${FILL})
    else()
        foreach(i RANGE ${LEN})
            set(FILL1 "${FILL1}${FILL}")
        endforeach()

        message(NOTICE "${PRE}${TEXT}${FILL1}${POST}")
    endif()
endfunction()

function(message_info INFO)
    set(PRE "│ ")
    set(PRE_LEN 2)
    set(POST "│")
    set(POST_LEN 1)
    message_format(${INFO} ${PRE} ${PRE_LEN} ${POST} ${POST_LEN} " ")
endfunction()

function(message_setting OPTION)
    set(PRE "│ ")
    set(PRE_LEN 2)
    set(POST "│")
    set(POST_LEN 1)

    string(LENGTH ${OPTION} len)
    math(EXPR len "30-${len}")
    set(FILL "")
    foreach(i RANGE ${len})
        set(FILL "${FILL} ")
    endforeach()

    if(DEFINED ${OPTION})
        set(MSG "${OPTION}${FILL}${${OPTION}}")
    else()
        set(MSG "${OPTION}${FILL}[undef]")
    endif()
    message_format(${MSG} ${PRE} ${PRE_LEN} ${POST} ${POST_LEN} " ")
endfunction()

function(message_option OPTION)
    get_property(HELP CACHE ${OPTION} PROPERTY HELPSTRING)
    message_setting(${OPTION})
    message_info(${HELP})
endfunction()

function(message_title TITLE)
    string(LENGTH ${TITLE} len)
    math(EXPR len "${DISPLAY_WIDTH}-6-${len}")
    math(EXPR len1 "${len}/2")
    math(EXPR len1 "${len1}-1")
    math(EXPR len2 "${len}-${len1}-1")
    set(FILL1 "")
    foreach(i RANGE ${len1})
        set(FILL1 "${FILL1}─")
    endforeach()
    set(FILL2 "")

    foreach(i RANGE ${len2})
        set(FILL2 "${FILL2}─")
    endforeach()
    message(NOTICE "┌${FILL1}┤│${TITLE}│├${FILL2}┐")
endfunction()

function(message_end)
    set(PRE "└")
    set(PRE_LEN 1)
    set(POST "┘")
    set(POST_LEN 1)
    message_format("" ${PRE} ${PRE_LEN} ${POST} ${POST_LEN} "─")
endfunction()

macro(message_prefix_push PREFIX)
    list(APPEND CMAKE_MESSAGE_INDENT "[${PREFIX}] ")
endmacro()

macro(message_prefix_pop)
    list(REMOVE_AT CMAKE_MESSAGE_INDENT -1)
endmacro()

macro(message_prefix_clear)
    set(CMAKE_MESSAGE_INDENT "")
endmacro()
