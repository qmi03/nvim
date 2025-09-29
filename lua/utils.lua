local fn = vim.fn

return {
  -- Check if an executable exists in PATH
  executable = function(name)
    if fn.executable(name) > 0 then
      return true
    end
    return false
  end,

  -- Check if the current directory is inside a Python project
  -- by looking for common Python project files
  is_in_a_python_project = function()
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
  end,

  -- Find Python executable and check if it's from conda/mamba/pixi
  -- Returns: { path = string, is_conda_buddies = boolean } or nil
  check_python_executable = function()
    local result = fn.system("which python"):gsub("%s+$", "")

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
  end,

  -- Check whether a feature exists in Nvim
  -- @param feat: string - the feature name, like nvim-0.7 or unix
  -- @return: boolean
  has = function(feat)
    if fn.has(feat) == 1 then
      return true
    end
    return false
  end,

  -- Create a directory if it does not exist
  may_create_dir = function(dir)
    local res = fn.isdirectory(dir)
    if res == 0 then
      fn.mkdir(dir, "p")
    end
  end,

  -- Generate random integers in the range [low, high], inclusive
  -- Adapted from https://stackoverflow.com/a/12739441/6064933
  -- @param low: number - the lower value for this range
  -- @param high: number - the upper value for this range
  rand_int = function(low, high)
    math.randomseed(os.time())
    return math.random(low, high)
  end,

  -- Select a random element from a sequence/list
  -- @param seq: table - the sequence to choose an element from
  rand_element = function(seq)
    local idx = math.random(1, #seq)
    return seq[idx]
  end,
}
