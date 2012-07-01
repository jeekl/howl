import signal from vilu

vilu.ui.Editor.define_indicator 'vi', 'bottom_left'

state = bundle_load 'state.moon'

maps = {
  command: bundle_load 'command_map.moon', state
  insert: bundle_load 'insert_map.moon', state
  visual: bundle_load 'visual_map.moon', state
}

state.init maps, 'command'
signal.connect 'editor-focused', (editor) -> state.change_mode editor, state.mode

info = {
  name: 'vi',
  author: 'Copyright 2012 Nils Nordman <nino at nordman.org>',
  description: 'VI bundle',
  license: 'MIT',
}

return :info, :maps