local fn = vim.fn

local M = {}

function M.executable(name)
	if fn.executable(name) > 0 then
		return true
	end

	return false
end

function M.is_in_a_python_project()
	-- Check for common Python project files
	local python_project_files = {
		"setup.py",
		"requirements.txt",
		".venv",
		"Pipfile",
		"pyproject.toml",
		"tox.ini",
	}
	for _, file in ipairs(python_project_files) do
		if fn.glob(file) ~= "" then
			return true
		end
	end
	return false
end

function M.check_python_executable()
	local result = fn.system("which python"):gsub("%s+$", "") -- Trim trailing whitespace
	if not result or result == "" then
		return nil
	end

	local conda_buddies = { "mamba", "conda", "pixi" }

	for _, buddy in ipairs(conda_buddies) do
		if result:find(buddy) then
			return { path = result, is_conda_buddies = true }
		end
	end

	return { path = result, is_conda_buddies = false }
end

--- check whether a feature exists in Nvim
--- @feat: string
---   the feature name, like `nvim-0.7` or `unix`.
--- return: bool
M.has = function(feat)
	if fn.has(feat) == 1 then
		return true
	end

	return false
end

--- Create a dir if it does not exist
function M.may_create_dir(dir)
	local res = fn.isdirectory(dir)

	if res == 0 then
		fn.mkdir(dir, "p")
	end
end

--- Generate random integers in the range [Low, High], inclusive,
--- adapted from https://stackoverflow.com/a/12739441/6064933
--- @low: the lower value for this range
--- @high: the upper value for this range
function M.rand_int(low, high)
	-- Use lua to generate random int, see also: https://stackoverflow.com/a/20157671/6064933
	math.randomseed(os.time())

	return math.random(low, high)
end

--- Select a random element from a sequence/list.
--- @seq: the sequence to choose an element
function M.rand_element(seq)
	local idx = M.rand_int(1, #seq)

	return seq[idx]
end

function M.add_pack(name)
	local status, error = pcall(vim.cmd, "packadd " .. name)

	return status
end

return M
