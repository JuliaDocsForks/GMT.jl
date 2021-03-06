"""
	grdedit(cmd0::String="", arg1=[], kwargs...)

Reads the header information in a binary 2-D grid file and replaces the information with
values provided on the command line.

Full option list at [`grdedit`](http://gmt.soest.hawaii.edu/doc/latest/grdedit.html)

Parameters
----------

- **A** : **adjust** : -- Bool --

    If necessary, adjust the file’s x_inc, y_inc to be compatible with its domain.
    [`-A`](http://gmt.soest.hawaii.edu/doc/latest/grdedit.html#a)
- **C** : **adjust** : -- Bool --

    Clear the command history from the grid header.
    [`-C`](http://gmt.soest.hawaii.edu/doc/latest/grdedit.html#c)
- **D** : **header** : -- Str --    Flags = [+xxname][+yyname][+zzname][+sscale][+ooffset][+ninvalid][+ttitle][+rremark

    Change these header parameters.
    [`-D`](http://gmt.soest.hawaii.edu/doc/latest/grdedit.html#d)
- **E** : **header** : -- Str --    Flags = [a|h|l|r|t|v]

    Transform the grid in one of six ways and (for l|r|t) interchange the x and y information
    [`-E`](http://gmt.soest.hawaii.edu/doc/latest/grdedit.html#e)
- **G** : **outgrid** : -- Str --

    Output grid file name. Note that this is optional and to be used only when saving
    the result directly on disk. Otherwise, just use the G = grdedit(....) form.
    [`-G`](http://gmt.soest.hawaii.edu/doc/latest/grdedit.html#g)
- $(GMT.opt_J)
- **N** : **replace** : -- Str or Mx3 array --

    Read the ASCII (or binary) file table and replace the corresponding nodal values in the
    grid with these x,y,z values. Alternatively, provide a Mx3 matrix with values to be changed. 
    [`-N`](http://gmt.soest.hawaii.edu/doc/latest/grdedit.html#n)
- $(GMT.opt_R)
- **S** : **wrap** : -- Bool --

    For global, geographical grids only. Grid values will be shifted longitudinally according to
    the new borders given in ``limits`` (R option).
    [`-S`](http://gmt.soest.hawaii.edu/doc/latest/grdedit.html#s)
- **T** : **toggle** : -- Bool --

    Make necessary changes in the header to convert a gridline-registered grid to a pixel-registered
    grid, or vice-versa.
    [`-T`](http://gmt.soest.hawaii.edu/doc/latest/grdedit.html#t)
- $(GMT.opt_V)
- $(GMT.opt_bi)
- $(GMT.opt_di)
- $(GMT.opt_e)
- $(GMT.opt_f)
- $(GMT.opt_swap_xy)
"""
function grdedit(cmd0::String="", arg1=[]; kwargs...)

	length(kwargs) == 0 && return monolitic("grdedit", cmd0, arg1)	# Speedy mode

	d = KW(kwargs)

	cmd, = parse_R("", d)
	cmd, = parse_J(cmd, d)
	cmd = parse_V_params(cmd, d)
	cmd, = parse_bi(cmd, d)
	cmd, = parse_di(cmd, d)
	cmd, = parse_e(cmd, d)
	cmd, = parse_f(cmd, d)
	cmd, = parse_swap_xy(cmd, d)

	cmd = add_opt(cmd, 'A', d, [:A :adjust])
	cmd = add_opt(cmd, 'C', d, [:C :clear_history])
	cmd = add_opt(cmd, 'D', d, [:D :header])
	cmd = add_opt(cmd, 'E', d, [:E :flip])
	cmd = add_opt(cmd, 'G', d, [:G :outgrid])
	cmd = add_opt(cmd, 'N', d, [:N :replace])
	cmd = add_opt(cmd, 'S', d, [:S :wrap])
	cmd = add_opt(cmd, 'T', d, [:T :toggle])

	cmd, got_fname, arg1 = find_data(d, cmd0, cmd, 1, arg1)
	return common_grd(d, cmd, got_fname, 1, "grdedit", arg1)		# Finish build cmd and run it
end

# ---------------------------------------------------------------------------------------------------
grdedit(arg1=[], cmd0::String=""; kw...) = grdedit(cmd0, arg1; kw...)