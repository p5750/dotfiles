local M = {}

local cache = {}

--- Get the wt.basedir for the current working directory.
--- Returns the absolute path string (with trailing slash), or nil if not configured.
function M.get_basedir()
  local cwd = vim.fn.getcwd()
  if cache[cwd] ~= nil then
    return cache[cwd] or nil
  end

  local result = vim.fn.systemlist("git config wt.basedir")
  if vim.v.shell_error ~= 0 or #result == 0 or result[1] == "" then
    cache[cwd] = false
    return nil
  end

  -- Resolve to absolute path (handles relative paths and symlinks)
  local basedir = vim.fn.fnamemodify(result[1], ':p')
  if not basedir:match("/$") then
    basedir = basedir .. "/"
  end
  cache[cwd] = basedir
  return basedir
end

--- Filter LSP location results (with uri field) to exclude files under the worktree basedir.
function M.filter_results(results)
  if results == nil or vim.tbl_isempty(results) then
    return results
  end

  local basedir = M.get_basedir()
  if not basedir then
    return results
  end

  local uri_prefix = "file://" .. basedir
  local filtered = {}
  for _, item in ipairs(results) do
    if not vim.startswith(item.uri, uri_prefix) then
      table.insert(filtered, item)
    end
  end
  return filtered
end

--- Filter on_list items (with filename field) to exclude files under the worktree basedir.
function M.filter_items(items)
  local basedir = M.get_basedir()
  if not basedir or not items then
    return items
  end

  return vim.tbl_filter(function(item)
    return not vim.startswith(item.filename, basedir)
  end, items)
end

--- Create an on_list handler that filters worktree results.
function M.on_list(options)
  options.items = M.filter_items(options.items)
  if #options.items == 0 then
    return
  end
  if #options.items == 1 then
    vim.fn.setqflist({}, ' ', options)
    vim.cmd.cfirst()
  else
    vim.fn.setqflist({}, ' ', options)
    vim.cmd.copen()
  end
end

--- Return a Lua pattern string for telescope's file_ignore_patterns.
function M.get_ignore_pattern()
  local basedir = M.get_basedir()
  if not basedir then
    return nil
  end
  return "^" .. basedir:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1")
end

return M
