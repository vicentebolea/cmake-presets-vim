" vim : foldmethod=manual :

" DetectCMakePreset {{{
func! DetectCMakePreset()
  if ! filereadable("CMakeUserPresets.json")
    return 0
  endif

  let preset_file_content = readfile("CMakeUserPresets.json")
  if empty(preset_file_content)
    return 0
  endif
  let preset_file_json = js_decode(join(preset_file_content))
  if empty(preset_file_json)
    return 0
  endif
  let raw_binary_dir = preset_file_json.configurePresets[0].binaryDir
  let binary_dir = substitute(raw_binary_dir, "${sourceDir}", getcwd(), "")

  execute ":set makeprg=cmake\\ --build\\ " . binary_dir
  return 1
endfunc
" }}}

" MakeCMakeProj {{{
func! CMakePresetConfigure(preset_name = "default")
  execute "!cmake --preset " . a:preset_name
endfunc
" }}}

call DetectCMakePreset()
command -nargs=? Configure :call CMakePresetConfigure(<args>)
