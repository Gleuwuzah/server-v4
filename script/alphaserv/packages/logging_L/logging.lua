module("alpha.logging.events", package.seeall)

server.event_handler("failedconnect", function(...) alpha.log_event("ss", "failedconnect", unpack(arg)) end)
server.event_handler("connect", function(...) alpha.log_event("p", "connect", unpack(arg)) end)
server.event_handler("disconnect", function(...) alpha.log_event("ps", "disconnect", unpack(arg)) end)
server.event_handler("kick", function(...) alpha.log_event("piss", "kick", unpack(arg)) end)
server.event_handler("rename", function(...) alpha.log_event("pss", "rename", unpack(arg)) end)
server.event_handler("reteam", function(...) alpha.log_event("pss", "reteam", unpack(arg)) end)
server.event_handler("text", function(...) alpha.log_event("ps", "text", unpack(arg)) end)
server.event_handler("sayteam", function(...) alpha.log_event("ps", "sayteam", unpack(arg)) end)
server.event_handler("mapvote", function(...) alpha.log_event("pss", "mapvote", unpack(arg)) end)
server.event_handler("mapchange", function(...) alpha.log_event("ss", "mapchange", unpack(arg)) end)
server.event_handler("mastermode", function(...) alpha.log_event("pss", "mastermode", unpack(arg)) end)
server.event_handler("privilege", function(...) alpha.log_event("pss", "privilege", unpack(arg)) end)
server.event_handler("spectator", function(...) alpha.log_event("pi", "spectator", unpack(arg)) end)
server.event_handler("gamepaused", function(...) alpha.log_event("", "gamepaused", unpack(arg)) end)
server.event_handler("gameresumed", function(...) alpha.log_event("", "gameresumed", unpack(arg)) end)
server.event_handler("addbot", function(...) alpha.log_event("psp", "addbot", unpack(arg)) end)
server.event_handler("delbot", function(...) alpha.log_event("p", "delbot", unpack(arg)) end)
server.event_handler("beginrecord", function(...) alpha.log_event("is", "beginrecord", unpack(arg)) end)
server.event_handler("endrecord", function(...) alpha.log_event("ii", "endrecord", unpack(arg)) end)
server.event_handler("mapcrcfail", function(...) alpha.log_event("p", "mapcrcfail", unpack(arg)) end)
server.event_handler("shutdown", function(...) alpha.log_event("i", "shutdown", unpack(arg)) end)
