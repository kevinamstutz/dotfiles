# Copyright 2015 Koichi Murase <myoga.murase@gmail.com>. All rights reserved.
# This script is a part of blesh (https://github.com/akinomyoga/ble.sh)
# provided under the BSD-3-Clause license.  Do not edit this file because this
# is not the original source code: Various pre-processing has been applied.
# Also, the code comments and blank lines are stripped off in the installation
# process.  Please find the corresponding source file(s) in the repository
# "akinomyoga/ble.sh".
#
# Source: /lib/test-bash.sh
ble-import lib/core-test
ble/test/start-section 'bash' 49
(
  a='x y'
  ble/test code:'ret=$a' ret="x y"
  ble/test '[[ $a == "x y" ]]'
  ble/test 'case $a in ("x y") true ;; (*) false ;; esac'
  a='x  y'
  ble/test code:'ret=$a' ret="x  y"
  ble/test '[[ $a == "x  y" ]]'
  ble/test 'case $a in ("x  y") true ;; (*) false ;; esac'
  IFS=abc a='xabcy'
  ble/test code:'ret=$a' ret="xabcy"
  ble/test '[[ $a == "xabcy" ]]'
  ble/test 'case $a in ("xabcy") true ;; (*) false ;; esac'
  IFS=$' \t\n'
  a='x y'
  ble/test 'read -r ret <<< $a' ret="x y"
  a='x  y'
  if ((_ble_bash<40400)); then
    ble/test 'read -r ret <<< $a' ret="x y"
  else
    ble/test 'read -r ret <<< $a' ret="x  y"
  fi
  IFS=abc a='xabcy'
  if ((_ble_bash<40400)); then
    ble/test 'read -r ret <<< $a' ret="x   y"
  else
    ble/test 'read -r ret <<< $a' ret="xabcy"
  fi
  IFS=$' \t\n'
  b='/*'
  ble/test code:'ret=$b' ret="/*"
  ble/test 'case $b in ("/*") true ;; (*) false ;; esac'
  ble/test 'read -r ret <<< $b' ret="/*"
)
(
  a=("")
  function f1 { ret=$1; }
  if ((30100<=_ble_bash&&_ble_bash<30200)); then
    ble/test 'f1 "a${a[*]}b"' ret=$'a\177b'
    ble/test code:'ret="a${a[*]}b"' ret=$'a\177b'
    ble/test 'case "a${a[*]}b" in ($'\''a\177b'\'') true ;; (*) false ;; esac'
    ble/test 'read -r ret <<< "a${a[*]}b"' ret=$'a\177b'
  else
    ble/test 'f1 "a${a[*]}b"' ret='ab'
    ble/test code:'ret="a${a[*]}b"' ret='ab'
    ble/test 'case "a${a[*]}b" in (ab) true ;; (*) false ;; esac'
    ble/test 'read -r ret <<< "a${a[*]}b"' ret=ab
  fi
  var=X%dX%dX
  if ((_ble_bash<30200)); then
    ble/test code:'ret=${var//%d/.}' ret='X%dX%dX'
  else
    ble/test code:'ret=${var//%d/.}' ret='X.X.X'
  fi
  ble/test/chdir
  touch {a..c}.txt
  function f1 { local GLOBIGNORE='*.txt'; }
  if ((_ble_bash<30200)); then
    ble/test 'f1; echo *' stdout='*'
  else
    ble/test 'f1; echo *' stdout='a.txt b.txt c.txt'
  fi
  if ((_ble_bash<30004)); then
    ble/test code:'a=あ ret=${#a}' ret=3
  else
    ble/test code:'a=あ ret=${#a}' ret=1
  fi
  builtin unset -v v
  v=$'a\nb'
  if ((_ble_bash<30100)); then
    ble/test code:'declare -p v' stdout=$'declare -- v="a\\\nb"'
  elif ((_ble_bash<50200)); then
    ble/test code:'declare -p v' stdout=$'declare -- v="a\nb"'
  else
    ble/test code:'declare -p v' stdout='declare -- v=$'\''a\nb'\'
  fi
  builtin unset -v scalar
  if ((_ble_bash<30100)); then
    ble/test code:'ret="[${scalar-$'\''hello'\''}]"' ret="['hello']" # disable=#D1774
  else
    ble/test code:'ret="[${scalar-$'\''hello'\''}]"' ret='[hello]'   # disable=#D1774
  fi
)
(
  function f1 { local -a a; local -A a; }
  if ((_ble_bash<40000)); then
    ble/test f1 exit=2
  elif ((_ble_bash<50000)); then
    ble/test '(f1)' exit=139 # SIGSEGV
  else
    ble/test f1 exit=1
  fi
  c=(a b c)
  IFS=x
  if ((_ble_bash<50000)); then
    ble/test 'case ${c[*]} in ("a b c") true ;; (*) false ;; esac'
    ble/test 'read -r ret <<< ${c[*]}' ret="a b c"
  else
    ble/test 'case ${c[*]} in ("axbxc") true ;; (*) false ;; esac'
    ble/test 'read -r ret <<< ${c[*]}' ret="axbxc"
  fi
  ble/test 'case "${c[*]}" in ("axbxc") true ;; (*) false ;; esac'
  ble/test 'read -r ret <<< "${c[*]}"' ret="axbxc"
  IFS=$' \t\n'
  c=(a b c)
  ble/test code:'ret=${c[*]}' ret="a b c"
  ble/test 'case ${c[*]} in ("a b c") true ;; (*) false ;; esac'
  ble/test 'read -r ret <<< ${c[*]}' ret="a b c"
  IFS=x
  if ((_ble_bash<40300)); then
    ble/test code:'ret=${c[*]}' ret="a b c"
  else
    ble/test code:'ret=${c[*]}' ret="axbxc"
  fi
  ble/test code:'ret="${c[*]}"' ret="axbxc"
  IFS=$' \t\n'
  builtin unset -v arr1 arr2
  local arr1
  local -a arr2
  if ((_ble_bash<40200)); then
    ble/test code:'ret=${#arr1[@]}' ret=1
  else
    ble/test code:'ret=${#arr1[@]}' ret=0
  fi
  ble/test code:'ret=${#arr2[@]}' ret=0
  a=($'\x7F' $'\x01')
  if ((_ble_bash<40000)); then
    ble/test 'declare -p a' stdout=$'declare -a a=\'([0]="\x01\x01\x01\x7F" [1]="\x01\x01\x01\x01")\'' # '
  elif ((_ble_bash<40400)); then
    ble/test 'declare -p a' stdout=$'declare -a a=\'([0]="\x01\x7F" [1]="\x01\x01")\'' # '
  else
    ble/test 'declare -p a' stdout='declare -a a=([0]=$'\''\177'\'' [1]=$'\''\001'\'')' # disable=#D0525
  fi
  function f1 { local -a arr=(b b b); ble/util/print "(${arr[*]})"; }
  function f2 { local -a arr=(a a a); f1; }
  if ((30100<=_ble_bash&&_ble_bash<30104)); then
    ble/test f2 stdout='()'
  else
    ble/test f2 stdout='(b b b)'
  fi
  if ((30100<=_ble_bash&&_ble_bash<30104)); then
    ble/test 'function f1 { local -a alpha=(); local -a beta=(); }'
  else
    ble/test 'function f1 { local -a alpha=() beta=(); }'
  fi
  if ((_ble_bash<30200)); then
    ble/test code:'ret=あ ret=${#ret[0]}' ret=3 # disable=#D0182
  else
    ble/test code:'ret=あ ret=${#ret[0]}' ret=1 # disable=#D0182
  fi
  declare ret=(1 2 3) # disable=#D0184
  if ((_ble_bash<30100)); then
    ble/test ret='(1 2 3)'
  else
    ble/test ret='1'
  fi
  declare -a ret=("1 2") # disable=#D0525
  if ((_ble_bash<30100)); then
    ble/test ret='1'
  else
    ble/test ret='1 2'
  fi
  v="1 2 3"
  declare -a ret=("$v") # disable=#D0525
  if ((_ble_bash<30100)); then
    ble/test ret='1'
  else
    ble/test ret='1 2 3'
  fi
  builtin unset -v scalar
  scalar=abcd
  if ((_ble_bash<30100)); then
    ble/test code:'ret=${scalar[@]//[bc]}' ret=''   # disable=#D1570
  elif ((40300<=_ble_bash&&_ble_bash<40400)); then
    ble/test code:'ret=${scalar[@]//[bc]}' ret=$'\001a\001\001\001d' # disable=#D1570
  else
    ble/test code:'ret=${scalar[@]//[bc]}' ret='ad' # disable=#D1570
  fi
)
(
  q=\' line='$'$q'\'$q'!!'$q'\'$q
  ble/util/assign ret '(builtin history -s histentry; builtin history -p "$line")'
  if ((_ble_bash<30100)); then
    ble/test code:'' ret=
  elif ((_ble_bash<40100)) || [[ $- != *[iH]* ]]; then
    ble/test code:'' ret="${line//!!/histentry}"
  else
    ble/test code:'' ret="$line"
  fi
  ble/test '(builtin history -c; builtin history -p "$line")' stdout=
  function f1 { ble/util/print hello; } >&"$fd1"
  function f2 { ble/util/print hello >&"$fd1"; }
  function f3 { { ble/util/print hello; } >&"$fd1"; }
  function test1 {
    local fd1=
    ble/fd#alloc fd1 '>&1'
    "$1" >/dev/null & local pid=$!
    wait "$pid"
    ble/fd#close fd1
  }
  if ((_ble_bash<30100)); then
    ble/test 'test1 f1' stdout=
  else
    ble/test 'test1 f1' stdout=hello
  fi
  ble/test 'test1 f2' stdout=hello
  ble/test 'test1 f3' stdout=hello
)
ble/test/end-section
