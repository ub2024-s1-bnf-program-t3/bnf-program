arraySize = 0

function getCoordinates(x, y)
	varx1 = string.sub(x, 1, 1) -- Getting Individual letters from the Sentences
	vary1 = string.sub(x, 2, 2)

	varx2 = string.sub(y, 1, 1)
	vary2 = string.sub(y, 2, 2)
end

function getTriCoordinates(x, y, b)
	trix1 = string.sub(tricoordxy1, 1, 1) -- Getting Individual letters from the Sentences
	triy1 = string.sub(tricoordxy1, 2, 2)

	trix2 = string.sub(tricoordxy2, 1, 1)
	triy2 = string.sub(tricoordxy2, 2, 2)

	trix3 = string.sub(tricoordxy3, 1, 1)
	triy3 = string.sub(tricoordxy3, 2, 2)
end

function sqrParse() -- Parse based on Shape this is Square
	for x = 1, 6 do
		if (words[x] == stmSQR) then
			coordxy1 = words[x + 1]
			coordxy2 = words[x + 3]
			getCoordinates(coordxy1, coordxy2)
			--print(coordxy2,coordxy1)
		end
	end



	tempsqrparse =
	"\t   SQR\n\t   /|\\ \n     <coord>,<coord>\n     / \\\t  / \\\n   <x> <y>\t<x> <y>"                                          -- formatting for squareParsing
	temptriparse =
	"\t\t\t TRI\n\t\t    /   / |   \\  \\ \n \t\t<coord>,<coord>,<coord>\n \t\t  / \\\t  / \\\t  / \\ \n\t\t<x> <y> <x> <y> <x> <y>" -- formatting for Triangular Parsing

	joined = "    " ..
		varx1 ..
		"   " .. vary1 ..
		"\t " ..
		varx2 ..
		"   " ..
		vary2                     -- Collect Individual letters and create a formatting for display purpose
	print(tempsqrparse)           -- Print to the Screen the tree structure
	print(joined)                 -- Print to the Screen the leaf structure



	if (shape[2] == stmTRI) then        -- if the second argument is a Triangular
		print(temptriparse)
		trix1 = string.sub(tricoordxy1, 1, 1) --Getting Individual letters from the Sentences
		triy1 = string.sub(tricoordxy1, 2, 2)

		trix2 = string.sub(tricoordxy2, 1, 1) -- Place like this so that Individual tree takes it own shape and form
		triy2 = string.sub(tricoordxy2, 2, 2)

		trix3 = string.sub(tricoordxy3, 1, 1)
		triy3 = string.sub(tricoordxy3, 2, 2)

		joined = "\t\t " ..
			trix1 ..
			"   " ..
			triy1 ..
			"   " ..
			trix2 ..
			"   " ..
			triy2 .. "   " .. trix3 ..
			"   " ..
			triy3              -- Collect Individual letters and create a formatting for display purpose
		print(joined)          -- Print to the Screen the leaf structure
	else
		if (shape[2] == stmSQR) then -- if its two Square Shaped
			for i = 1, arraySize do
				if (words[i] == stmSQR) then
					coordxy1 = words[i + 1]
					coordxy2 = words[i + 3]
					getCoordinates(coordxy1, coordxy2)
				end
			end

			print(
				"\t\t\t\tSQR\n\t\t\t\t/|\\ \n \t\t\t  <coord>,<coord>\n \t\t\t  / \\ \t   / \\\n  \t\t\t<x> <y>  <x> <y>") --
			joined = "\t\t\t " ..
				varx1 ..
				"   " ..
				vary1 ..
				"    " ..
				varx2 ..
				"    " ..
				vary2                 -- Collect Individual letters and create a formatting for display purpose
			print(joined)
		end
	end
end

function triParse() -- Parse based on Shape this is Triangular
	for x = 1, 6 do
		if (words[x] == stmTRI) then
			tricoordxy1 = words[x + 1]
			tricoordxy2 = words[x + 3]
			tricoordxy3 = words[x + 5]
			getTriCoordinates(tricoordxy1, tricoordxy2, tricoordxy3)
			--print(coordxy2,coordxy1)
		end
	end


	tempsqrparse =
	"\t\t\t\t\t\\\n\t\t\t\t\tSQR\n\t\t\t\t\t/|\\ \n\t\t\t\t <coord> , <coord>\n\t\t\t\t   / \\     /  \\\n\t\t\t\t<x>  <y>  <x>  <y>" -- formatting for Triangular Parsing
	temptriparse =
	"\t  |\n\t  TRI\n\t/|  \\  \\ \\  \\ \\ \t \n <coord> ,<coord>,<coord>\n  / \\ \t   / \\ \t   / \\ \n<x> <y>  <x> <y> <x> <y>"     -- formatting for Triangular Parsing


	print(temptriparse) -- Printing its Tree structure

	joined = "  " ..
		trix1 ..
		"   " ..
		triy1 ..
		"   " ..
		trix2 ..
		"   " .. triy2 ..
		"   " ..
		trix3 ..
		"   " ..
		triy3                     -- Collect Individual letters and create a formatting for display purpose
	print(joined)                 -- Print to the Screen the coordina structure





	if (shape[2] == stmSQR) then -- if the second arguement is a square
		varx1 = string.sub(coordxy1, 1, 1)
		vary1 = string.sub(coordxy1, 2, 2)
		-- Collect coordinates
		varx2 = string.sub(coordxy2, 1, 1)
		vary2 = string.sub(coordxy2, 2, 2)

		joinedsqr = "\t\t\t\t " ..
			varx1 ..
			"    " ..
			vary1 ..
			"    " ..
			varx2 ..
			"    " ..
			vary2                    --Collect Individual coordinates and create a formatting for display purpose
		print("\t\t\t\t   " .. instSymbol .. "\n\t\t\t\t       \\")
		print(tempsqrparse)
		print(joinedsqr)
	else
		if (shape[2] == stmTRI) then -- if the second arguement is a trigangle
			print("\t\t\t      \\\n\t\t\t     <inst>\n\t\t\t\t\\")
			print(
				"\t\t\t\tTRI\t\n\t\t\t      / |  \\   \\   \\ \n\t\t\t <coord>,<coord>,<coord>\n\t\t\t  / \\ \t   / \\ \t   / \\ \n\t\t\t<x> <y>  <x> <y> <x> <y>") -- print its secondary structure
			trix1 = string.sub(tricoordxy1, 1, 1)
			triy1 = string.sub(tricoordxy1, 2, 2)

			trix2 = string.sub(tricoordxy2, 1, 1) -- Collect coordinates
			triy2 = string.sub(tricoordxy2, 2, 2)

			trix3 = string.sub(tricoordxy3, 1, 1)
			triy3 = string.sub(tricoordxy3, 2, 2)

			for i = 1, arraySize do
				if (words[i] == stmTRI) then
					tricoordxy1 = words[i + 1]
					tricoordxy2 = words[i + 3]
					tricoordxy3 = words[i + 5]
					getTriCoordinates(tricoordxy1, tricoordxy2, tricoordxy3)
				end
			end


			joined = "\t\t\t  " ..
				trix1 ..
				"   " ..
				triy1 ..
				"   " ..
				trix2 ..
				"   " ..
				triy2 ..
				"   " ..
				trix3 ..
				"   " ..
				triy3               --Collect Individual coordinates and create a formatting for display purpose
			print(joined)
		end
	end
end

function parseString(vartobeParse)
	--deriviation(sentence) -- Just getting the words place in a array

	key = 2

	stmSQR = "SQR"                                       -- MAKE FOR FAST COMPARISION
	stmTRI = "TRI"
	arrayParse = {}                                      -- ARRAY FOR SHAPE AND coordinates
	shape = {}                                           -- HOLD THE AMOUNT OF SHAPES
	topParse = "\n\t<program> \n /          |     \t\\ " -- THE BEGIN OF THE PARSE TREE
	secondStep = "start \t <inst_list> \t finish \n\t    |" -- THE SECOND PHASE OF THE PARSE TREE
	instSymbol = "<inst>"
	arrayParse[1] = topParse                             -- PLACE THE PRIMARY COMPONENTS OF THE TREE
	arrayParse[2] = secondStep
	smtcount = 0


	print(arrayParse[1])
	print(arrayParse[2])

	for i = 1, arraySize do
		if (words[i] == stmSQR or words[i] == stmTRI) then
			smtcount = smtcount + 1
			shape[smtcount] = words[i]
			if (words[i] == stmSQR) then
				coordxy1 = words[i + 1]
				coordxy2 = words[i + 3]
			else
				if (words[i] == stmTRI) then
					tricoordxy1 = words[i + 1]
					tricoordxy2 = words[i + 3]
					tricoordxy3 = words[i + 5]
				end
			end
		end
	end



	if (smtcount > 1) then              -- CHECK TO SEE IF THERE IS MORE THAN ONE SHAPE
		if (shape[1] == stmSQR) then
			print("    \t <inst> ; <inst_list>") -- PRINT THE FOLLOW PART OF THE TREE
			sqrParse()                  -- CALL THE SQUARE PARSER
		else
			print("     <inst> ; <inst_list>") -- PRINT THE FOLLOW PART OF THE TREE
			triParse()                  -- CALL THE SQUARE PARSER
		end
	else                                --ELSE JUST PROCEED WITH CREATING ONE TREE
		if (shape[smtcount] == stmSQR) then
			print("\t  " .. instSymbol .. "\n \t    |")
			sqrParse()
		else
			print("\t  " .. instSymbol .. "\n \t    |")
			triParse()
		end
	end


	main()
end

function checkCoords(position, output)
	x = string.sub(words[position], 1, 1) --selects the <x> coordinate

	if (x == "A" or x == "B" or x == "C" or x == "D" or x == "E" or x == "F" or x == "G") then
		output = output .. " " .. x


		if (words[2] == "SQR") then --if instruction is SQR do appropriate deriviation
			if (words[position + 1] == "finish") then
				print(output .. "<y> " .. words[a])
			else
				print(output .. "<y>,<coord> " .. words[a])
			end
		else
			if (words[position + 1] == "finish") then --if instruction is TRI do appropriate deriviation
				print(output .. "<y> " .. words[a])
			elseif (words[position + 3] == "finish") then
				print(output .. "<y>,<coord> " .. words[a])
			else
				print(output .. "<y>,<coord>,<coord> " .. words[a])
			end
		end

		y = string.sub(words[position], 2, 2)
	else --if coordinate is  invalid then prompts for input
		print("ERROR: Unrecognized Coordinate: " .. words[position])
		main()
	end

	if (y == "1" or y == "2" or y == "3" or y == "4" or y == "5" or y == "6") then --selects the <x> coordinate
		if (words[position + 1] == "finish") then
			output = output .. y
		else
			output = output .. y .. words[position + 1]
		end

		if (words[2] == "SQR") then --if instruction is SQR do appropriate deriviation
			if (words[position + 1] == "finish") then
				print(output .. " " .. words[a])
			else
				print(output .. "<coord> " .. words[a])
			end
		else
			if (words[position + 1] == "finish") then --if instruction is TRI do appropriate deriviation
				print(output .. " " .. words[a])
			elseif (words[position + 3] == "finish") then
				print(output .. "<coord>" .. words[a])
			else
				print(output .. "<coord>,<coord> " .. words[a])
			end
		end
	else --if coordinate is invalid, prompts for input
		print("ERROR: Unrecognized Coordinate: " .. words[position])
		main()
	end

	position = position + 1


	if (words[position] == ",") then --if another coordinate follows do
		position = position + 1
		checkCoordLength(position, output)
	end


	if (words[position] == ";") then --if another inst follows do
		position = position + 1
		found = false;
		checkInst(position, output, found)
	end

	if (words[position] == "finish") then --ends if it reaches the end of the array
		return (0)
	end
	parseString(sentences)
end

function checkCoordLength(position, output)
	length = string.len(words[position])     --checks coordinate length

	if (length == 2 and words[2] == "SQR") then --if it is a SQR Coordinate
		if (words[position + 1] == "finish") then --prints appropriate deriviation
			print(output .. "<x><y> " .. words[a])
		else
			print(output .. " <x><y>,<coord> " .. words[a])
		end
		checkCoords(position, output)
	elseif (length == 2 and words[2] == "TRI") then --if it is a TRI coordinate
		if (words[position + 1] == "finish") then --prints appropriate deriviation
			print(output .. "<x><y> " .. words[a])
		elseif (words[position + 3] == "finish") then
			print(output .. "<x><y>,<coord> " .. words[a])
		else
			print(output .. " <x><y>,<coord>,<coord> " .. words[a])
		end

		checkCoords(position, output, found)
	else --if invalid prompts for input
		print("ERROR: Unrecognized coordinate: " .. words[position])
		main()
	end
end

function checkInst(position, output, found)
	if (words[position] == "SQR") then      --if instruction is SQR
		output = output .. " " .. words[position] --concatenates output

		if (found == false) then
			print(output .. " <coord>,<coord> " .. words[a]) --prints new deriviation
		else
			print(output .. " <coord>,<coord>;<inst_list> " .. words[a])
		end

		position = position + 1
		checkCoordLength(position, output)  --calls function
	elseif (words[position] == "TRI") then  --if instruction is TRI
		output = output .. " " .. words[position] --concatenates output

		if (found == false) then
			print(output .. " <coord>,<coord>,<coord> " .. words[a]) --prints new deriviation
		else
			print(output .. "<coord>,<coord>,<coord>;<inst_list> " .. words[a])
		end

		position = position + 1
		checkCoordLength(position, output)
	else --if instruction is invalid prompts for input
		print("Invalid instruction: " .. words[position])
		main()
	end
end

function checkListType(position, output, found)
	a = #words
	item = ";"

	found = false;

	for i = 1, a do          --searches for ; in the array
		if (words[i] == item) then --if found, then print new deriviation
			print(output .. " <inst>" .. words[i] .. "<inst_list> " .. words[a])
			found = true
		end
	end

	if (found == false) then --if not found, then print new deriviation
		print(output .. " <inst> " .. words[a])
	end

	checkInst(position, output, found) --calls function checkInst
end

function checkProgram()
	position = 1
	output = "program -> "
	if (words[position] == "start" and words[a] == "finish") then --checks if it is a valid program
		output = output .. words[position]                     --concatenates output
		print(output .. " <inst_list> " .. words[a])           --prints first deriviation
		position = position + 1
		checkListType(position, output)                        --calls function checkListType
	else
		print("ERROR: " .. sentence .. " is invalid")
		main()
	end
end

function deriviation(sentence)
	words = {} --declears an array
	index = 1

	for value in string.gmatch(sentence, "%S+") do
		words[index] = value --stores string ito array
		index = index + 1 --increments index by 1
	end

	a = #words --gets size of array
	arraySize = #words


	checkProgram() --calls function check program
end

function main()
	print("\n\n")
	print("<program> -> start <inst_list> finish")
	print("<inst_list-> <inst>")
	print("	     |<inst>;<inst_list>")
	print("   <inst> -> SQR <coord>,<coord>")
	print("          -> TRI <coord>, <coord>, <coord>")
	print("  <coord> -> <x> <y>")
	print("     <x>  -> A|B|C|D|E|F|G")
	print("     <y>  -> 1|2|3|4|5|6 ")
	print(" ")
	print(" ")

	io.write("Please enter a string base of the following Grammer:\n ") --prompts user to enter string
	sentence = io.read()                                             --reads string

	if (sentence == 'QUIT' or sentence == 'quit') then               --checks if user enters quit
		return (0)
	else
		deriviation(sentence) --call function deriviation
	end

	io.read()
end

main() --calls function main
