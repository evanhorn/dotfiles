# Import output colors
library(colorout)

# Define graphics position and dimensions
grDevices::X11.options(width = 4.5, height = 4, ypos = 0,
                       xpos = 1000, pointsize = 10)

# Use 'w3m' for R doc navigation
if (interactive() && Sys.info()[["sysname"]] == "Linux" && Sys.getenv("DISPLAY") == "") {
    if (Sys.getenv("TMUX") != "")
        options(browser = function(u) system(paste0("tmux new-window 'w3m ", u, "'")))
    else if (Sys.getenv("NVIMR_TMPDIR") != "")
        options(browser = function(u) .C("nvimcom_msg_to_nvim",
                                         paste0('StartTxtBrowser("w3m", "', u, '")')))
}
