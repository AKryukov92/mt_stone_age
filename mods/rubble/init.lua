local subjects_of_rubble = {}
subjects_of_rubble["default:cobble"] = true
subjects_of_rubble["default:stone"] = true

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

-- On right-click if player points nothing, then rubble should be thrown. It creates projectile
-- On contact, projectile tries to break stone, changes rubble node size or create rubble node
-- If contact is vertical wall, then it should create falling rubble node
-- Rubble nodes changes like pile of individual rubbles
function rubble_stone_throw(itemstack, user, pointed_thing)
	if pointed_thing.type == "nothing" then
		minetest.log("Throwing rubble")
		local pos = user:get_pos()
		pos.x = pos.x + 1
		local dir = user:get_look_dir()
		local projectile = minetest.add_entity(pos, "rubble:thrown_stone")
		projectile:setvelocity({ x = dir.x * 10, y = dir.y * 10, z = dir.z * 10 })
		return ""
	end
end

local function is_normal_node(ndef)
    return ndef.walkable == true
       and ndef.drowning == 0
       and ndef.damage_per_second <= 0
       and ndef.groups.disable_suffocation ~= 1
       and ndef.drawtype == "normal"
end

minetest.register_entity("rubble:thrown_stone",{
    lifetime = 10,
	on_step = function(self, dtime)
		self.lifetime = self.lifetime - dtime
		if self.lifetime < 0 then
			self.object:remove()
			return
		end
		local pos = self.object:getpos()
		local dir = vector.normalize(self.object:getvelocity())
		local node = minetest.get_node_or_nil(pos)
		local ndef = minetest.registered_nodes[node.name]
		if is_normal_node(ndef) then
			minetest.log("Stuck at " .. node.name)
			minetest.add_item(pos, "rubble:rubble_stone")
			if subjects_of_rubble[node.name] then
				hit_stone(pos, node)
			end
			self.object:remove()
		end
	end
})

minetest.register_tool("rubble:rubble_stone", {
	description = "Rubble stone",
	inventory_image = "rubble_stone.png",
	--on_use = rubble_stone_on_use,
	on_secondary_use = rubble_stone_throw,
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			--cracky={times={[2]=2.00, [3]=1.20}, uses=10, maxlevel=1}
		},
		damage_groups = {fleshy=2},
	},
})