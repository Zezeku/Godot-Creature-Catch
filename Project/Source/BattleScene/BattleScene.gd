extends Node2D

#GENERAL FLOW OF BATTLE SCENE
#
#All Nodes get loaded, we put FSM last so that custom signal connections can happen before code execution
#Scene starts in Statemachine, state initialized to BattleStart
#All states inherit generic state class
#
#State child -> if it needs to update UI, call parent function
#Generic State -> emit signal based on function call
#Battle UI recieves signal
#Battle UI -> call child UI node function to display data based on signal

#If any UI input required, such as menu select, move select, etc.
#Child UI gets BattleUIHandler path -> calls function directly
#	this is preference, they are close in hiearchy, so cleaner than bubbling signals
#BattleUIHandler -> emits signal based on function call to State machine
#
#State machine recives signal -> executes input function based on signal recieved
#this allows us to filter signal by current state
#ie two states can be connected to the same signal, without one trying to execute when its not current state
#prevents dependancies and thus cycles
#
#TLDR:
#Signal Flow
#
#From FSM to UI
#Generic State -> BattleUI
#
#From UI to FSM
#BattleUIHandler -> State Machine
