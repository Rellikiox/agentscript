#!/bin/bash

files="\
  util.coffee \
  shapes.coffee \
  agentset.coffee \
  agentsets.coffee \
  model.coffee \
"

echo "cat .coffee files to agentscript.coffee"
cat $files > agentscript.coffee

foo=`cat agentscript.coffee | sed '
  /^ *#/d
  s:#.*$::
  /^ *$/d
  /setRootVars/,$d
' | wc`; echo "AgentScript: CoffeeScript lines of code:" $foo
foo=`cat agentscript.js | sed '
  /^ *\/\//d
  s://.*$::
  /^ *$/d
  /setRootVars/,$d
' | wc`; echo "AgentScript: JavaScript lines of code: " $foo

echo "uglify agentscript.js"
uglifyjs agentscript.js -c -m > agentscript.min.js
# echo "zip agentscript/"
# cd ..
# zip -rq agentscript.zip agentscript
