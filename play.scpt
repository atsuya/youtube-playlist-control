set Controller to run script ("script s" & return & (read alias (POSIX file "./lib/controller.scpt") as «class utf8») & return & "end script " & return & "return s")

Controller's control("'play'")
