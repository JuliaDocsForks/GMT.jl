"""
	sample1d(cmd0::String="", arg1=[], kwargs...)

Resample 1-D table data using splines

Full option list at [`sample1d`](http://gmt.soest.hawaii.edu/doc/latest/sample1d.html)

Parameters
----------

- **A** : **resamp** : -- Str --        Flags = f|p|m|r|R

    For track resampling (if -T…unit is set) we can select how this is to be performed.
    [`-A`](http://gmt.soest.hawaii.edu/doc/latest/sample1d.html#a)
- **F** : **interp_type** : -- Str --   Flags = l|a|c|n[+1|+2]

    Choose from l (Linear), a (Akima spline), c (natural cubic spline), and n (no interpolation:
    nearest point) [Default is Akima].
    [`-F`](http://gmt.soest.hawaii.edu/doc/latest/sample1d.html#f)
- **N** : **time_col** : -- Int --      Flags = t_col

    Indicates which column contains the independent variable (time). The left-most column
    is # 0, the right-most is # (n_cols - 1). [Default is 0].
    [`-N`](http://gmt.soest.hawaii.edu/doc/latest/sample1d.html#n)
- **T** : **equi_space** : -- List or Str --     Flags = [min/max/]inc[+a|n]] or file|list

    Evaluate the best-fit regression model at the equidistant points implied by the arguments.
    [`-T`](http://gmt.soest.hawaii.edu/doc/latest/sample1d.html#t)
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
function sample1d(cmd0::String="", arg1=[]; kwargs...)

	length(kwargs) == 0 && occursin(" -", cmd0) && return monolitic("sample1d", cmd0, arg1)	# Speedy mode

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

	cmd = add_opt(cmd, 'A', d, [:A :resamp])
	cmd = add_opt(cmd, 'F', d, [:F :interp_type])
	cmd = add_opt(cmd, 'N', d, [:N :time_col])
	cmd = add_opt(cmd, 'T', d, [:T :equi_space])

	cmd, got_fname, arg1 = find_data(d, cmd0, cmd, 1, arg1)
	return common_grd(d, cmd, got_fname, 1, "sample1d", arg1)		# Finish build cmd and run it
end

# ---------------------------------------------------------------------------------------------------
sample1d(arg1=[], cmd0::String=""; kw...) = sample1d(cmd0, arg1; kw...)