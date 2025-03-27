" Source the plugin
source plugin/cmake-presets-vim.vim

" Test script for cmake-presets-vim
cd test/cmake-project

" Check if preset is detected
let detected = DetectCMakePreset()
if detected != 1
  echo "FAILED: Preset detection failed"
  cquit 1
endif

" Check if makeprg was set correctly
if &makeprg !~ "cmake --build .*build-user"
  echo "FAILED: makeprg not set correctly"
  echo "Current makeprg: " . &makeprg
  cquit 2
endif

echo "SUCCESS: All tests passed"
quit
