mob/verb/SettingsWindow()
	set hidden = 1
	set name = ".settings"
	var/window = winget(src, "set.tab1", "current-tab")
	var/SetView/Set = new()
	Set.Display(src, window)
	del Set
/*	switch(window)
		if("general") winset(src, null, "command=BrowseGeneral")
		if("style") 	winset(src, null, "command=BrowseStyle")
		if("icons") 	winset(src, null, "command=BrowseIcons")
		if("events") 	winset(src, null, "command=BrowseEvents")
		if("filters") 	winset(src, null, "command=BrowseFilters")
		if("security") 	winset(src, null, "command=BrowseSecurity")
		if("system") 	winset(src, null, "command=BrowseSystem") */
SetView
	proc
		ShowSet()
			set hidden = 1
			winshow(src, "set", 1)
			call(usr, "BrowseGeneral") ()

		HideSet()
			set hidden = 1
			winshow(src, "set", 0)
			for(var/p in typesof(/Settings/General/proc))
				if(p in usr.verbs) usr.verbs -= p
			for(var/p in typesof(/Settings/Events/proc))
				if(p in usr.verbs) usr.verbs -= p
			for(var/p in typesof(/Settings/Style/proc))
				if(p in usr.verbs) usr.verbs -= p
			for(var/p in typesof(/Settings/Filters/proc))
				if(p in usr.verbs) usr.verbs -= p
			for(var/p in typesof(/Settings/System/proc))
				if(p in usr.verbs) usr.verbs -= p
			for(var/p in typesof(/Settings/Icons/proc))
				if(p in usr.verbs) usr.verbs -= p

		Display(mob/chatter/C, page)
			switch(page)
				if("general")
					C << output(null, "general.output")
					if(C.picture)
						C << output("<img src='[C.picture]' width=64 height=64>\...", "general.output")
					else
						src << browse_rsc('./resources/images/noimage.png', "noimage.png")
						C << output("<img src='noimage.png' width=64 height=64>\...", "general.output")
					winset(C, "general.picture", "text='[TextMan.escapeQuotes(C.picture)]'")
					winset(C, "general.age", "text='[TextMan.escapeQuotes(C.age)]'")
					if(C.gender == "male")
						winset(C, "general.male",  "is-checked=true")
						winset(C, "general.female","is-checked=false")
						winset(C, "general.neuter","is-checked=false")
						winset(C, "general.plural","is-checked=false")
					else if(C.gender == "female")
						winset(C, "general.male",  "is-checked=false")
						winset(C, "general.female","is-checked=true")
						winset(C, "general.neuter","is-checked=false")
						winset(C, "general.plural","is-checked=false")
					else if(C.gender == "neuter")
						winset(C, "general.male",  "is-checked=false")
						winset(C, "general.female","is-checked=false")
						winset(C, "general.neuter","is-checked=true")
						winset(C, "general.plural","is-checked=false")
					else if(C.gender == "plural")
						winset(C, "general.male",  "is-checked=false")
						winset(C, "general.female","is-checked=false")
						winset(C, "general.neuter","is-checked=false")
						winset(C, "general.plural","is-checked=true")
					winset(C, "general.location",  "text='[TextMan.escapeQuotes(C.location)]'")
					winset(C, "general.description",  "text='[TextMan.escapeQuotes(C.description)]'")
					winset(C, "general.interests",  "text='[TextMan.escapeQuotes(C.interests)]'")
				if("style")
					winset(C, "style_colors.name_color", "text='[C.name_color]'")
					winset(C, "style_colors.name_color_button", "background-color='[C.name_color]'")
					winset(C, "style_colors.text_color", "text='[C.text_color]'")
					winset(C, "style_colors.text_color_button", "background-color='[C.text_color]'")
					winset(C, "style_colors.background", "text='[C.background]'")
					winset(C, "style_colors.background_button", "background-color='[C.background]'")
					C << output("<b>[C.fade_name]</b>", "style_colors.output")
					if(C.show_colors)
						winset(C, "style_colors.show_colors", "is-checked=true")
						winset(C, "style_colors.no_colors", "is-checked=false")
					else
						winset(C, "style_colors.show_colors", "is-checked=false")
						winset(C, "style_colors.no_colors", "is-checked=true")
					if(C.forced_punctuation)
						winset(C, "style_formats.forced", "is-checked=true")
						winset(C, "style_formats.no_forced", "is-checked=false")
					else
						winset(C, "style_formats.forced", "is-checked=false")
						winset(C, "style_formats.no_forced", "is-checked=true")
					winset(C, "style_formats.chat_format", "text='[TextMan.escapeQuotes(list2text(C.say_format))]'")
					winset(C, "style_formats.emote_format", "text='[TextMan.escapeQuotes(list2text(C.me_format))]'")
					winset(C, "style_formats.inline_emote_format", "text='[TextMan.escapeQuotes(list2text(C.rpsay_format))]'")
					winset(C, "style_formats.time_format", "text='[TextMan.escapeQuotes(list2text(C.time_format))]'")
					winset(C, "style_formats.date_format", "text='[TextMan.escapeQuotes(list2text(C.date_format))]'")
					winset(C, "style_formats.long_date_format", "text='[TextMan.escapeQuotes(list2text(C.long_date_format))]'")
					winset(C, "style_default.output_style", "text='[TextMan.escapeQuotes(C.default_output_style)]';")
				if("icons")
				if("events")
					winset(C, "events.onjoin", "text='[TextMan.escapeQuotes(C.onJoin)]'")
					winset(C, "events.onquit", "text='[TextMan.escapeQuotes(C.onQuit)]'")
					winset(C, "events.cim_sounds", "is-checked=[C.im_sounds ? "true" : "false"];")
					if(C.im_volume == 33)
						winset(C, "events.vol_low", "is-checked=true;")
						winset(C, "events.vol_med", "is-checked=false;")
						winset(C, "events.vol_high", "is-checked=false;")
					else if(C.im_volume == 66)
						winset(C, "events.vol_low", "is-checked=false;")
						winset(C, "events.vol_med", "is-checked=true;")
						winset(C, "events.vol_high", "is-checked=false;")
					else
						winset(C, "events.vol_low", "is-checked=false;")
						winset(C, "events.vol_med", "is-checked=false;")
						winset(C, "events.vol_high", "is-checked=true;")
				if("filters")
					call(C, "ShowFilterList")()
					call(C, "SetFilter")("[C.filter]")
				if("security")
				if("system")
					if(C.show_title) winset(C, "system.show_title", "is-checked=true")
					else winset(C, "system.show_title", "is-checked=false")
					if(C.show_welcome) winset(C, "system.show_welcome", "is-checked=true")
					else winset(C, "system.show_welcome", "is-checked=false")
					if(C.show_motd) winset(C, "system.show_motd", "is-checked=true")
					else winset(C, "system.show_motd", "is-checked=false")
					if(C.show_qotd) winset(C, "system.show_qotd", "is-checked=true")
					else winset(C, "system.show_qotd", "is-checked=false")
					if(C.clear_on_reboot) winset(C, "system.clear_reboot", "is-checked=true")
					else winset(C, "system.clear_reboot", "is-checked=false")
					winset(C, "system.max_output", "text='[C.max_output]'")
					if(C.show_highlight) winset(C, "system.show_highlight", "is-checked=true")
					else winset(C, "system.show_highlight", "is-checked=false")
					winset(C, "system.telnet_pass", "text='[TextMan.escapeQuotes(C.telnet_pass)]';")
					var/X,Y
					if(C.winsize)
						X = copytext(C.winsize, 1, findtext(C.winsize, "x"))
						Y = copytext(C.winsize, findtext(C.winsize, "x")+1)
					call(C, "SetWinSizeX")(X)
					call(C, "SetWinSizeY")(Y)
					if(!C._24hr_time)
						winset(C, "system.24Hour", "is-checked=false")
						winset(C, "system.12Hour", "is-checked=true")
					winset(C, "system.offset", "text='[C.time_offset]'")
					var/time = TextMan.strip_html(C.ParseTime())
					C << output(time, "system.time")
					winset(C, "system.auto_afk", "text='[C.auto_away]'")
					winset(C, "system.away_msg", "text='[TextMan.escapeQuotes(C.auto_reason)]'")


		Initialize(mob/chatter/C)
			if(!C || !C.client) return
			C.verbs += /SetView/proc/ShowSet
			C.verbs += /SetView/proc/HideSet
			for(var/p in typesof(/Settings/General/proc)-/Settings/General/proc)
				if(!(p:name in C.verbs)) C.verbs += p
			for(var/p in typesof(/Settings/Style/proc)-/Settings/Style/proc)
				if(!(p:name in C.verbs)) C.verbs += p
			for(var/p in typesof(/Settings/Icons/proc)-/Settings/Icons/proc)
				if(!(p:name in C.verbs)) C.verbs += p
			for(var/p in typesof(/Settings/Events/proc)-/Settings/Events/proc)
				if(!(p:name in C.verbs)) C.verbs += p
			for(var/p in typesof(/Settings/Filters/proc)-/Settings/Filters/proc)
				if(!(p:name in C.verbs)) C.verbs += p
			for(var/p in typesof(/Settings/System/proc)-/Settings/System/proc)
				if(!(p:name in C.verbs)) C.verbs += p

