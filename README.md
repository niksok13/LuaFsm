```
Class = require "modules.Class"
FSM = require "modules.FSM"
State = FSM.State

Loader = Class(State){
		name = "loader",
		enter = function()
			print("Loading started")
		end,
		event = function(ev)
			if ev == "loading_done" then
				print("Loading finished")
				return "ready"
			end
		end,
		btn = {
			cancel = function()
				print("Loading canceled. Closing app...")
				return "exit"
			end,
			retry = function()
				print("Loading started")
			end
		},
		exit = function()
			print("Hide loader")
		end
}
FSM.add(Loader)
FSM.change("loader")
```
