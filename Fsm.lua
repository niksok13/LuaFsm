local State = Class(){
	init = function (self, name)
		self.name = name
	end
}

local Fsm = { states = {},State = State}

function Fsm.add(state)
	if state and type(state) ~= "table" then
		print ("Fsm.add: wrong argument type:",type(state))
		return
	end
	if not state.name then
		print ("state name is empty.")
		return
	end
	Fsm.states[state.name] = state()
end

function Fsm.addAll(states) 
	for _, state in pairs(states) do Fsm.add(state) end 
end

function Fsm.change(name)
	if Fsm.current then
		local res = Fsm.current.exit and Fsm.current:exit()
		if res and type(res) == "string" then Fsm.change(res) return end
	end
	Fsm.current = Fsm.states[name];
	if Fsm.current then
		local res = Fsm.current.enter and Fsm.current:enter()
		if res and type(res) == "string" then Fsm.change(res) return end
	end
end

function Fsm.update(dt)
	---TODO - implement timers
end

function Fsm.btn(name, ...)
	if Fsm.current and Fsm.current.btn then
		local action = Fsm.current.btn[name]
		if type(action) == "string" then
			Fsm:change(action)
			return
		end
		local res = action(Fsm.current, ...)
		if res and type(res) == "string" then Fsm:change(res) end
	end
	
end

function Fsm.event(ev, ...)
	if Fsm.current and Fsm.current.event then
		local res = Fsm.current:event(ev, ...)
		if res and type(res) == "string" then Fsm.change(res) end
	end
end

return Fsm
