module GMT

using Printf

# Need to know what GMT version is available or if none at all to warn users on how to
# install GMT.
try
	# Due to a likely Julia bug next command fails when this file called with 'using'
	#ver_s = @capture_out run(`gmt --version`);
	#@show(length(ver_s))			# Prints 0 length

	# So resort to write result to file on disk and read from it
	write("gmtversion__.txt", read(`gmt --version`))
	global const GMTver = Meta.parse(read("gmtversion__.txt", String)[1:3])
	rm("gmtversion__.txt")
	global foundGMT = true
catch
	global foundGMT = false
	global const GMTver = 5.0		# Don't want to raise an error in libgmt_h.jl due to a missing var
end

#const GMTver = 6.0
const FMT = "ps"

export
	GMTver, FMT, gmt,
	bar, bar!,
	basemap, basemap!, blockmean, blockmedian, blockmode, coast, coast!, colorbar, colorbar!, contour, 
	contour!, filter1d, filter2d, fitcircle, gmt2kml,  gmtconnect, gmtconvert, gmtinfo, gmtregress, 
	gmtread, gmtselect, gmtsimplify, gmtspatial, gmtvector, gmtwrite, gmtwich, 
	grd2cpt, grd2kml, grd2xyz, grdblend, grdclip, grdcontour,
	grdcontour!, grdcut, grdedit, grdfft, grdfilter, grdgradient, grdhisteq, grdimage, grdimage!, grdinfo,
	grdlandmask, grdpaste, grdproject, grdsample, grdtrack, grdtrend, grdview, grdview!, grdvolume,
	grid_type, histogram, histogram!, image, image!, imshow, imshow!, kml2gmt, logo, logo!, makecpt,
	mapproject, nearneighbor, plot, plot!, plot3d, plot3d!, project,
	pscontour, pscontour!, psconvert, psbasemap, psbasemap!, psclip, psclip!, pscoast, pscoast!, 
	pshistogram, pshistogram!, psimage, psimage!, psmask, psmask!, psrose, psrose!, psscale, psscale!, 
	pssolar, pssolar!, psternary, psternary!, pstext, pstext!, pswiggle, pswiggle!, psxy, psxy!, psxyz, 
	psxyz!, rose, rose!, sample1d, scatter, scatter!, scatter3, scatter3!, solar, solar!, spectrum1d,
	sphdistance, sphinterpolate, sphtriangulate,
	surface, ternary, ternary!, text, text!, text_record, trend1d, trend2d, triangulate, splitxyz,
	wiggle, wiggle!, xy, xy!, xyz2grd

include("common_docs.jl")
include("libgmt_h.jl")
include("libgmt.jl")
include("gmt_main.jl")
include("common_options.jl")
include("blocks.jl")
include("filter1d.jl")
include("fitcircle.jl")
include("gmt2kml.jl")
include("gmtconnect.jl")
include("gmtconvert.jl")
include("gmtinfo.jl")
include("gmtlogo.jl")
include("gmtreadwrite.jl")
include("gmtset.jl")
include("gmtselect.jl")
include("gmtsimplify.jl")
include("gmtspatial.jl")
include("gmtregress.jl")
include("gmtvector.jl")
include("grd2cpt.jl")
include("grd2kml.jl")
include("grd2xyz.jl")
include("grdblend.jl")
include("grdclip.jl")
include("grdcut.jl")
include("grdedit.jl")
include("grdcontour.jl")
include("grdfft.jl")
include("grdfilter.jl")
include("grdhisteq.jl")
include("grdinfo.jl")
include("grdimage.jl")
include("grdgradient.jl")
include("grdlandmask.jl")
include("grdpaste.jl")
include("grdproject.jl")
include("grdsample.jl")
include("grdtrack.jl")
include("grdtrend.jl")
include("grdview.jl")
include("grdvolume.jl")
include("imshow.jl")
include("kml2gmt.jl")
include("makecpt.jl")
include("mapproject.jl")
include("nearneighbor.jl")
include("project.jl")
include("psbasemap.jl")
include("pscoast.jl")
include("pscontour.jl")
include("psconvert.jl")
include("pshistogram.jl")
include("psimage.jl")
include("psscale.jl")
include("psrose.jl")
include("pssolar.jl")
include("pstext.jl")
include("psxy.jl")
include("pswiggle.jl")
include("plot.jl")
include("plot3d.jl")
include("sample1d.jl")
include("spectrum1d.jl")
include("sphdistance.jl")
include("sphinterpolate.jl")
include("sphtriangulate.jl")
include("splitxyz.jl")
include("surface.jl")
include("triangulate.jl")
include("trend1d.jl")
include("trend2d.jl")
include("xyz2grd.jl")

if (!foundGMT)
	println("\n\nYou don't seem to have GMT installed and I don't currently install it automatically,")
	println("so you will have to do it yourself. Please follow instructions bellow but please note")
	println("that since GMT is migrating to Github (https://github.com/GenericMappingTools/gmt),")
	println("some of the links may change in a near future.\n\n")
	if (Sys.iswindows() && Sys.WORD_SIZE == 64)
		println("1) Download and install the official version at (the '..._win64.exe':")
		println("\t\t https://gmt.soest.hawaii.edu/projects/gmt/wiki/Download")
		println("\n2) Or even better, download and install the GMT6dev version at:")
		println("\t\t http://w3.ualg.pt/~jluis/downloads/gmt.html")
	elseif (Sys.iswindows() && Sys.WORD_SIZE == 32)
		println("Download and install the official version at (the '..._win32.exe':")
		println("\t\t https://gmt.soest.hawaii.edu/projects/gmt/wiki/Download")
	else
		println("https://gmt.soest.hawaii.edu/projects/gmt/wiki/BuildingGMT")
	end
end

end # module
