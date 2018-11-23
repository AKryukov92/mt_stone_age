local subjects_of_rubble = {}
subjects_of_rubble["default:cobble"] = true

--After use don't work. It is called after "digging"
--On use don't woek. It isn't called at all
--It should be moved to on_punch of stone
-- local function rubble_stone_on_use(itemstack, user, node, digparams)
	-- if node.node == nil then
		-- return
	-- end
	-- minetest.log("Rubble stone used on " .. node.name)
	
	-- -- If used on default:stone, rubble:rubble_block_X
	-- if subjects_of_rubble[node.name] then
		-- -- Drop rubble:rubble_stone as item nearby
		-- minetest.add_item(user:get_pos(), "rubble:rubble_stone")
	-- end
	-- -- Replace this node with default:stone_rubble_1
	-- -- 
	-- -- Check adjacent nodes by faces.
	-- -- If adj_node has no adjacent connections to other nodes of same type
	-- -- then remove adj_node and drop it as item
-- end


minetest.register_tool("rubble:rubble_stone", {
	description = "Rubble stone",
	inventory_image = "rubble_stone.png",
	--on_use = rubble_stone_on_use,
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			--cracky={times={[2]=2.00, [3]=1.20}, uses=10, maxlevel=1}
		},
		damage_groups = {fleshy=2},
	},
})