
local function install_github()
    shell.run("pastebin run p8PJVxC4")
end

local function download_self()
    shell.run("github clone MnMaxon/cc_scripts -b main")
end

local function setup()
    if pcall(install_github())
    then
        print("Installed github")
    else
        print("Failed to install github - I hope you have it installed already!")
    end
    download_self()
end

setup()