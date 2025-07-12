hs.hotkey.bind({ "control" }, "i", function()
  local appName = "WezTerm"
  local app = hs.application.get(appName)

  if app == nil or not app:isFrontmost() then
    hs.application.launchOrFocus(appName)
  else
    app:hide()
  end
end)
