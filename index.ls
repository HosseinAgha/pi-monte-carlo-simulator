"use strict"

require! {
  'readline': { createInterface }:readline
  'tty'
}


generateLCGFunction = (seed = 65539) ->
  a = 65539
  x = seed
  c = 0 
  m = (2 ^ 63) - 1
  ->
    x := (a * x) % m
    x / m

circleHitsNum = 0
squareHitsNum = 0

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

calculatePi = (isLCG, numOfSim) ->
  for i from 0 til numOfSim
    simulatePi(isLCG)
  if not isLCG
    console.log "Using system random numbers"
  else
    console.log "Using LCG algorithm random numbers"
  console.log "Pi after #numOfSim simulations: ", getPi(circleHitsNum, squareHitsNum)
  circleHitsNum := 0
  squareHitsNum := 0


readline.emitKeypressEvents process.stdin
process.stdin.setRawMode yes

console.log "Press enter to simulate using system random and space to simulate using LCG:"

process.stdin.on \keypress, (c, key) ->
  if c is '\r'
    console.log "Simulating ......"
    calculatePi(no, 1000000)
  else if c is ' '
    console.log "Simulating ......"
    calculatePi(yes, 1000000)

  if key.name is \c and key?.ctrl
    process.exit!

