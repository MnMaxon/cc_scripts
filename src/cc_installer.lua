local function install_github()
    shell.run("pastebin run p8PJVxC4")
end

local function download_self()
    --https://github.com/eric-wieser/computercraft-github
    shell.run("github clone MnMaxon/cc_scripts -b main")
end
local function download_basalt()
    --https://basalt.madefor.cc/#/home/download
    shell.run("wget run https://basalt.madefor.cc/install.lua release latest.lua")
end

local function setup()
    print("Downloading self")
    download_self()
    --    Save installer to root
    fs.delete("cc_installer.lua")
    fs.copy("cc_scripts/src/cc_installer.lua", "cc_installer.lua")
    fs.delete("basalt_test.lua")
    fs.copy("cc_scripts/src/basalt_test.lua", "basalt_test.lua")
    fs.copy("cc_scripts/src/utils.lua", "utils.lua")

    print("Installing github")
    local ok, err = pcall(install_github)
    if ok then
        print("Installed github")
    else
        print("Failed to install github - I hope you have it installed already!")
    end

    print("Downloading basalt")
    download_basalt()
end

setup()