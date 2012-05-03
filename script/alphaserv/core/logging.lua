alpha.log = {}
alpha.log.printlogs = false
alpha.log.openedfiles = {}

function alpha.log.message(message, ...)
	return alpha.log.message_to(message, 'server', unpack(arg))
end

function alpha.log.message_to(message, file, ...)
	if #arg < 1 then
		alpha.log.write_to(file..".log",os.date("[%a %d %b %X] ",os.time())..message.."\n")
		return true
	else
		returning = string.format(os.date("[%a %d %b %X] ",os.time())..message.."\n", unpack(arg))
		alpha.log.write_to(file..".log", returning)
		return returning
	end
end

function alpha.log.write_to(file, message)
	alpha.log.checkopened(file)
	alpha.log.write_line(file, message)
end

function alpha.log.checkopened(file)
	if alpha.log.openedfiles[file] then return end
	
	alpha.log.openedfiles[file] = io.open("log/" .. file,"a+")
	if not alpha.log.openedfiles[file] then error("could not open logfile for writing: "..file) end
end

function alpha.log.write_line(file, message)
	alpha.log.openedfiles[file]:write(message)
	
	if alpha.log.printlogs then
		print("LOG:"..message)
	end
end

function alpha.log.close_all()
	server.sleep(1, function()
	for name, value in pairs(alpha.log.openedfiles) do
		alpha.log.close_file(name)
	end
	end)
end

function alpha.log.name(cn)
	return string.format("%s(%i)[%s][%s]", server.player_name(cn), cn, server.player_ip(cn), geoip.ip_to_country(server.player_ip(cn)) or "<unknown>")
end

function alpha.log.close_file(name)
	alpha.log.openedfiles[name]:close()
end

server.event_handler("shutdown", alpha.log.close_all)

alpha.log.debuglevels = {
	FATAL = 0,
	ERROR = 1,
	NOTICE = 2,
	INFO = 3,
}

for i, level in pairs(alpha.log.debuglevels) do
	_G["LOG_"..i] = level
end

alpha.log.debuglevel_names = {
	[alpha.log.debuglevels.FATAL] = "fatal",
	[alpha.log.debuglevels.ERROR] = "error",
	[alpha.log.debuglevels.NOTICE] = "notice",
	[alpha.log.debuglevels.INFO] = "info",
}

alpha.log.debuglevel = alpha.log.debuglevels.INFO

function alpha.log.debug(level, text)
--	if level <= alpha.log.debuglevel then
		local name = alpha.log.debuglevel_names[level]
		alpha.log.message_to("DEBUG %s(%i): %s", "debug", name, level, text)
		
		if not alpha.init_done and alpha.spamstartup then
			print(string.format("DEBUG %s(%i): %s", "debug", name, level, text))
		
		--message module loaded
		elseif alpha.init_done and messages.load then
			messages.load("DEBUG", "debug_"..name, {default_type = "debug", default_message = "DEBUG %(1)s(%(2)s): %(3)s"})
				:format(name, level, text)
				:send(server.players(), false)

		end
--	end
end

_G.log_msg = alpha.log.debug

function alpha.log_event(a, name, ...)
	local returning = "Event "..name
	local i = 1
	for i = 1, #a do
		local b = a:sub(i,i)
		if b == "p" then
			returning = returning.." ".. alpha.log.name(tonumber(arg[i]))
		elseif b == "s" then
			returning = returning.." ".. tostring(arg[i] or "<?>")
		elseif b == "i" then
			returning = returning.." ".. tonumber(arg[i] or 1/0)
		end					
		i = i + 1
	end
	alpha.log.message(returning)
end

if server.reloaded then
    alpha.log.message("reloaded server scripts")
else
    alpha.log.message("server started")
end

