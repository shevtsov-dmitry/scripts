local utf8 = require("lua-utf8")

local text = "как. вытащить тебя. мой разум."
local randomized_split = {}

local function get_cur_list_as_string(list)
	local res = ""
	for _, value in ipairs(list) do
		res = res .. " " .. value
	end
	return string.sub(res, 2, #res)
end

for word in text:gmatch("%S+") do
	table.insert(randomized_split, word)
end

local function shuffle_list()
	for i = 1, #randomized_split, 1 do
		_ = i
		local idx1 = math.random(#randomized_split)
		local tempo = randomized_split[idx1]
		local idx2 = math.random(#randomized_split)
		randomized_split[idx1] = randomized_split[idx2]
		randomized_split[idx2] = tempo
	end
end

shuffle_list()
