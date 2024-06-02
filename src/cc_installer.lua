
local function install_github()
    shell.run("pastebin run p8PJVxC4")
end

local function download_self()
    shell.run("github clone MnMaxon/cc_scripts -b main")
end

local function setup()
    print("Installing github")
    local ok, err = pcall(install_github)
    if ok then print("Installed github")
    else print("Failed to install github - I hope you have it installed already!")
    end
    print("Downloading self")
    download_self()
    fs.copy("cc_scripts/src/cc_installer.lua", "cc_installer.lua")
end

setup()