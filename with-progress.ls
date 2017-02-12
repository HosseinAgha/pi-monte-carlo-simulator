"use strict"

require! {
  'readline': { createInterface }:readline
  'tty'
}

circleHitsNum = 0
squareHitsNum = 0

generateLCGFunction = (seed = 65539) ->
  a = 65539
  x = seed
  c = 0 
  m = (2 ^ 63) - 1
  ->
    x := (a * x) % m
    x / m

random = generateLCGFunction!

simulatePi = (useLCG) ->
  i = if useLCG then random! else Math.random!
  j = if useLCG then random! else Math.random!
  if (i * i) + (j * j) <= 1
    circleHitsNum++
    squareHitsNum++
  else
    squareHitsNum++

getPi = (circleHitsNum, squareHitsNum) ->
  ( circleHitsNum / squareHitsNum ) * 4

readline.emitKeypressEvents process.stdin
process.stdin.setRawMode yes

numberOfTries = 0
calculatePi = (isLCG) ->
  interval = setInterval do
    ->
      for i from 0 til 1000000
        numberOfTries := numberOfTries + 1
        simulatePi(isLCG)
      if circleHitsNum >= Number.MAX_SAFE_INTEGER or circleHitsNum >= Number.MAX_SAFE_INTEGER
        clearInterval interval
      console.log "after #{numberOfTries} hits"
      console.log "pi is:", getPi(circleHitsNum, squareHitsNum)
    100

console.log "Press enter to start using system random and space to start using LCG:"
process.stdin.on \keypress, (c, key) ->
  if c is '\r'
    calculatePi(no)
  else if c is ' '
    calculatePi(yes)

  if key.name is \c and key?.ctrl
    process.exit!

