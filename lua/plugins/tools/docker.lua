return {
    -- Dev container support for Docker development
    {
      "https://codeberg.org/esensar/nvim-dev-container",
      cmd = {
        "DevcontainerBuild",
        "DevcontainerImageRun", 
        "DevcontainerBuildAndRun",
        "DevcontainerBuildRunAndAttach",
        "DevcontainerComposeUp",
        "DevcontainerComposeDown",
        "DevcontainerComposeRm",
        "DevcontainerStartAuto",
        "DevcontainerStartAutoAndAttach",
        "DevcontainerAttachAuto",
        "DevcontainerStopAuto",
        "DevcontainerStopAll",
        "DevcontainerRemoveAll",
        "DevcontainerLogs",
        "DevcontainerOpenNearestConfig",
        "DevcontainerEditNearestConfig",
      },
      config = function()
        require("devcontainer").setup()
      end,
    },
  }