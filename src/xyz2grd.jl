"""
	xyz2grd(cmd0::String="", arg1=[]; kwargs...)

Convert data table to a grid file. 

Full option list at [`xyz2grd`](http://gmt.soest.hawaii.edu/doc/latest/xyz2grd.html)

Parameters
----------

- **I** : **inc** : -- Str or Number --     Flags = xinc[unit][+e|n][/yinc[unit][+e|n]]

    *x_inc* [and optionally *y_inc*] is the grid spacing.
    [`-I`](http://gmt.soest.hawaii.edu/doc/latest/xyz2grd.html#i)
- $(GMT.opt_R)
- **A** : **multiple_nodes** : -- Str --      Flags = [d|f|l|m|n|r|S|s|u|z]

    By default we will calculate mean values if multiple entries fall on the same node.
    Use A to change this behavior.
    [`-A`](http://gmt.soest.hawaii.edu/doc/latest/xyz2grd.html#a)
- **D** : **header** : -- Str --  Flags = [+xxname][+yyname][+zzname][+sscale][+ooffset][+ninvalid][+ttitle][+rremark]

    Output edges
    [`-D`](http://gmt.soest.hawaii.edu/doc/latest/xyz2grd.html#d)
- **G** : **outgrid** : -- Str --

    Output grid file name. Note that this is optional and to be used only when saving
    the result directly on disk. Otherwise, just use the G = grdclip(....) form.
    [`-G`](http://gmt.soest.hawaii.edu/doc/latest/xyz2grd.html#g)
- $(GMT.opt_J)
- **S** : **swap** : -- Str or [] --        Flags = [zfile]

    Swap the byte-order of the input only. No grid file is produced.
    [`-S`](http://gmt.soest.hawaii.edu/doc/latest/xyz2grd.html#s)
- $(GMT.opt_V)
- **Z** : **flags** : -- Str --

    Read a 1-column table. This assumes that all the nodes are present and sorted according to specified ordering convention contained in. ``flags``.
    [`-Z`](http://gmt.soest.hawaii.edu/doc/latest/grd2xyz.html#z)
- $(GMT.opt_bi)
- $(GMT.opt_di)
- $(GMT.opt_e)
- $(GMT.opt_f)
- $(GMT.opt_h)
- $(GMT.opt_i)
- $(GMT.opt_r)
- $(GMT.opt_swap_xy)
"""
function xyz2grd(cmd0::String="", arg1=[]; kwargs...)

	length(kwargs) == 0 && return monolitic("xyz2grd", cmd0, arg1)	# Speedy mode

	d = KW(kwargs)
	cmd, = parse_R("", d)
	cmd, = parse_J(cmd, d)
	cmd  = parse_V_params(cmd, d)
	cmd, = parse_bi(cmd, d)
	cmd, = parse_di(cmd, d)
	cmd, = parse_e(cmd, d)
	cmd, = parse_f(cmd, d)
	cmd, = parse_h(cmd, d)
	cmd, = parse_i(cmd, d)
	cmd, = parse_r(cmd, d)
	cmd, = parse_swap_xy(cmd, d)

	cmd = add_opt(cmd, 'A', d, [:A :multiple_nodes])
	cmd = add_opt(cmd, 'D', d, [:D :header])
    cmd = add_opt(cmd, 'G', d, [:G :outgrid])
	cmd = add_opt(cmd, 'I', d, [:I :inc])
	cmd = add_opt(cmd, 'S', d, [:S :swap])
	cmd = add_opt(cmd, 'Z', d, [:Z :flags])

	cmd, got_fname, arg1 = find_data(d, cmd0, cmd, 1, arg1)
	return common_grd(d, cmd, got_fname, 1, "xyz2grd", arg1)		# Finish build cmd and run it
end

# ---------------------------------------------------------------------------------------------------
xyz2grd(arg1::Array, cmd0::String=""; kw...) = xyz2grd(cmd0, arg1; kw...)