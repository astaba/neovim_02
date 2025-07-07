local enabled = require("config.grimoire")

return {
  "nvzone/showkeys",
  enabled = enabled("showkeys"),
  cmd = "ShowkeysToggle",
  opts = {
    timeout = 2,
    maxkeys = 5
  },
}
