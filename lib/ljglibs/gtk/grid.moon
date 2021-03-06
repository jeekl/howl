-- Copyright 2014-2015 The Howl Developers
-- License: MIT (see LICENSE.md at the top-level directory of the distribution)

ffi = require 'ffi'
jit = require 'jit'
require 'ljglibs.cdefs.gtk'
core = require 'ljglibs.core'
gobject = require 'ljglibs.gobject'
require 'ljglibs.gtk.container'

gc_ptr, ref_ptr = gobject.gc_ptr, gobject.ref_ptr
C, ffi_cast = ffi.C, ffi.cast
widget_t = ffi.typeof 'GtkWidget *'
to_w = (o) -> ffi_cast widget_t, o

jit.off true, true

core.define 'GtkGrid < GtkContainer', {
  properties: {
    column_homogeneous: 'gboolean'
    row_homogeneous: 'gboolean'
    column_spacing: 'gint'
    row_spacing: 'gint'
    baseline_row: 'gint'
  }

  child_properties: {
    top_attach: 'gint'
    left_attach: 'gint'
    height: 'gint'
    width: 'gint'
  }

  new: -> gc_ptr C.gtk_grid_new!

  attach: (child, left, top, width, height) =>
    C.gtk_grid_attach @, to_w(child), left, top, width, height

  attach_next_to: (child, sibling, side, width, height) =>
    C.gtk_grid_attach_next_to @, to_w(child), to_w(sibling), side, width, height

  get_child_at: (left, top) => ref_ptr C.gtk_grid_get_child_at @, left, top
  insert_row: (position) => C.gtk_grid_insert_row @, position
  insert_column: (position) => C.gtk_grid_insert_column @, position
  remove_row: (position) => C.gtk_grid_remove_row @, position
  remove_column: (position) => C.gtk_grid_remove_column @, position
  insert_next_to: (sibling, side) => C.gtk_grid_insert_next_to @, to_w(sibling), side

}, (spec, ...) -> spec.new ...
