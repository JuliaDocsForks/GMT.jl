"""
	mapproject(cmd0::String="", arg1=[], kwargs...)

Forward and inverse map transformations, datum conversions and geodesy.

Full option list at [`mapproject`](http://gmt.soest.hawaii.edu/doc/latest/mapproject.html)

Parameters
----------

- $(GMT.opt_R)
- $(GMT.opt_J)

- **A** : **origin** : -- Str --    Flags = b|B|f|F|o|O[lon0/lat0][+v]

    Calculate azimuth along track or to the optional fixed point set with lon0/lat0.
    [`-A`](http://gmt.soest.hawaii.edu/doc/latest/mapproject.html#a)
- **C** : **center** : -- Str or list or [] --    Flags = [dx/dy]

    Set center of projected coordinates to be at map projection center [Default is lower left corner].
    [`-C`](http://gmt.soest.hawaii.edu/doc/latest/mapproject.html#c)
- **D** : **override_units** : -- Str --    Flags = c|i|p

    Temporarily override PROJ_LENGTH_UNIT and use c (cm), i (inch), or p (points) instead.
    [`-D`](http://gmt.soest.hawaii.edu/doc/latest/mapproject.html#d)
- **E** : **geod2ecef** : -- Str or [] --    Flags = [datum]

    Convert from geodetic (lon, lat, height) to Earth Centered Earth Fixed (ECEF) (x,y,z) coordinates.
    [`-E`](http://gmt.soest.hawaii.edu/doc/latest/mapproject.html#e)
- **F** : **one2one** : -- Str or [] --    Flags = [unit]

    Force 1:1 scaling, i.e., output (or input, see I) data are in actual projected meters.
    [`-F`](http://gmt.soest.hawaii.edu/doc/latest/mapproject.html#f)
- **G** : **track_distances** : -- Str or List --    Flags = [lon0/lat0][+a][+i][+u[+|-]unit][+v]

    Calculate distances along track or to the optional fixed point set with G="lon0/lat0".
    [`-G`](http://gmt.soest.hawaii.edu/doc/latest/mapproject.html#g)
- **L** : **dist2line** : -- Str --    Flags = line.xy[+u[+|-]unit][+p]

    Determine the shortest distance from the input data points to the line(s) given in the
    ASCII multisegment file line.xy.
    [`-L`](http://gmt.soest.hawaii.edu/doc/latest/mapproject.html#l)
- **N** : **geod2aux** : -- Str or [] --       Flags = [a|c|g|m]

    Convert from geodetic latitudes to one of four different auxiliary latitudes (longitudes are unaffected).
    [`-N`](http://gmt.soest.hawaii.edu/doc/latest/mapproject.html#n)
- **Q** : **list** : -- Str or [] --           Flags = [d|e]

    List all projection parameters. To only list datums, use Q=:d, to only list ellipsoids, use Q=:e.
    [`-Q`](http://gmt.soest.hawaii.edu/doc/latest/mapproject.html#q)
- **S** : **supress** : -- Bool or [] --

    Suppress points that fall outside the region.
    [`-S`](http://gmt.soest.hawaii.edu/doc/latest/mapproject.html#s)
- **T** : **change_datum** : -- Str --    Flags = [h]from[/to]

    Coordinate conversions between datums from and to using the standard Molodensky transformation.
    [`-T`](http://gmt.soest.hawaii.edu/doc/latest/mapproject.html#t)
- **W** : **map_size** : -- Str or [] --    Flags = [w|h]

    Prints map width and height on standard output. No input files are read.
    [`-W`](http://gmt.soest.hawaii.edu/doc/latest/mapproject.html#w)
- **Z** : **travel_times** : -- Str or Number --    Flags = [speed][+a][+i][+f][+tepoch]

    Calculate travel times along track as specified with -G.
    [`-Z`](http://gmt.soest.hawaii.edu/doc/latest/mapproject.html#z)

- $(GMT.opt_V)
- $(GMT.opt_b)
- $(GMT.opt_d)
- $(GMT.opt_e)
- $(GMT.opt_f)
- $(GMT.opt_g)
- $(GMT.opt_h)
- $(GMT.opt_i)
- $(GMT.opt_o)
- $(GMT.opt_p)
- $(GMT.opt_s)
- $(GMT.opt_swap_xy)
"""
function mapproject(cmd0::String="", arg1=[]; kwargs...)

	length(kwargs) == 0 && return monolitic("mapproject", cmd0, arg1)	# Speedy mode

	d = KW(kwargs)

	cmd, = parse_R("", d)
	cmd, = parse_J("", d)
	cmd = parse_V_params(cmd, d)
	cmd, = parse_b(cmd, d)
	cmd, = parse_d(cmd, d)
	cmd, = parse_e(cmd, d)
	cmd, = parse_f(cmd, d)
	cmd, = parse_g(cmd, d)
	cmd, = parse_h(cmd, d)
	cmd, = parse_i(cmd, d)
	cmd, = parse_o(cmd, d)
	cmd, = parse_p(cmd, d)
	cmd, = parse_s(cmd, d)
	cmd, = parse_swap_xy(cmd, d)

	cmd = add_opt(cmd, 'A', d, [:A :azim])
	cmd = add_opt(cmd, 'C', d, [:C :center])
	cmd = add_opt(cmd, 'D', d, [:D :override_units])
	cmd = add_opt(cmd, 'E', d, [:E :geod2ecef])
	cmd = add_opt(cmd, 'F', d, [:F :one2one])
	cmd = add_opt(cmd, 'G', d, [:G :track_distances])
	cmd = add_opt(cmd, 'I', d, [:I :inverse])
	cmd = add_opt(cmd, 'L', d, [:L :dist2line])
	cmd = add_opt(cmd, 'N', d, [:N :geod2aux])
	cmd = add_opt(cmd, 'Q', d, [:Q :list])
	cmd = add_opt(cmd, 'S', d, [:S :supress])
	cmd = add_opt(cmd, 'T', d, [:T :change_datum])
	cmd = add_opt(cmd, 'W', d, [:W :map_size])
	cmd = add_opt(cmd, 'Z', d, [:Z :travel_times])

	cmd, got_fname, arg1 = find_data(d, cmd0, cmd, 1, arg1)
	return common_grd(d, cmd, got_fname, 1, "mapproject", arg1)		# Finish build cmd and run it
end

# ---------------------------------------------------------------------------------------------------
mapproject(arg1=[], cmd0::String=""; kw...) = mapproject(cmd0, arg1; kw...)