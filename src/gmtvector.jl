"""
	gmtvector(cmd0::String="", arg1=[], kwargs...)

Time domain filtering of 1-D data tables.

Full option list at [`gmtvector`](http://gmt.soest.hawaii.edu/doc/latest/gmtvector.html)

Parameters
----------

- **A** : **single_vec** : -- Str --   Flags = m[conf]|vector

    Specify a single, primary vector instead of reading tables.
    [`-A`](http://gmt.soest.hawaii.edu/doc/latest/gmtvector.html#a)
- **C** : **cartesian** : -- Str or [] --        Flags = [i|o]

    Select Cartesian coordinates on input and output.
    [`-C`](http://gmt.soest.hawaii.edu/doc/latest/gmtvector.html#c)
- **E** : **geod2geoc** : -- Bool or [] --

    Convert input geographic coordinates from geodetic to geocentric and output geographic
    coordinates from geocentric to geodetic.
    [`-E`](http://gmt.soest.hawaii.edu/doc/latest/gmtvector.html#e)
- **N** : **normalize** : -- Bool or [] --

    Normalize the resultant vectors prior to reporting the output.
    [`-N`](http://gmt.soest.hawaii.edu/doc/latest/gmtvector.html#n)
- **S** : **secondary_vec** : -- Str or List --    Flags = [vector]

    Specify a single, secondary vector in the same format as the first vector.
    [`-S`](http://gmt.soest.hawaii.edu/doc/latest/gmtvector.html#s)
- **T** : **transform** : -- List or Str --     Flags = a|d|D|paz|s|r[arg|R|x]

    Specify the vector transformation of interest.
    [`-T`](http://gmt.soest.hawaii.edu/doc/latest/gmtvector.html#t)
- $(GMT.opt_V)
- $(GMT.opt_write)
- $(GMT.opt_append)
- $(GMT.opt_b)
- $(GMT.opt_d)
- $(GMT.opt_e)
- $(GMT.opt_f)
- $(GMT.opt_g)
- $(GMT.opt_h)
- $(GMT.opt_i)
- $(GMT.opt_o)
- $(GMT.opt_swap_xy)
"""
function gmtvector(cmd0::String="", arg1=[]; kwargs...)

	length(kwargs) == 0 && return monolitic("gmtvector", cmd0, arg1)	# Speedy mode

	d = KW(kwargs)

	cmd = parse_V_params("", d)
	cmd, = parse_b(cmd, d)
	cmd, = parse_d(cmd, d)
	cmd, = parse_e(cmd, d)
	cmd, = parse_f(cmd, d)
	cmd, = parse_g(cmd, d)
	cmd, = parse_h(cmd, d)
	cmd, = parse_i(cmd, d)
	cmd, = parse_o(cmd, d)
	cmd, = parse_swap_xy(cmd, d)

	cmd = add_opt(cmd, 'A', d, [:A :single_vec])
	cmd = add_opt(cmd, 'C', d, [:C :cartesian])
	cmd = add_opt(cmd, 'E', d, [:E :geod2geoc])
	cmd = add_opt(cmd, 'N', d, [:N :normalize])
	cmd = add_opt(cmd, 'S', d, [:S :secondary_vec])
	cmd = add_opt(cmd, 'T', d, [:T :transform])

	cmd, got_fname, arg1 = find_data(d, cmd0, cmd, 1, arg1)
	return common_grd(d, cmd, got_fname, 1, "gmtvector", arg1)		# Finish build cmd and run it
end

# ---------------------------------------------------------------------------------------------------
gmtvector(arg1=[], cmd0::String=""; kw...) = gmtvector(cmd0, arg1; kw...)