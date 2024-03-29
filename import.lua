require "lsqlite3"
require "lglib"

local MIMETYPES_DEFAULT_SQL = {
        "insert into mimetype (extension, mimetype) values ('.obd', 'application/x-msbinder');\n",
        "insert into mimetype (extension, mimetype) values ('.obj', 'application/octet-stream');\n",
        "insert into mimetype (extension, mimetype) values ('.silo', 'model/mesh');\n",
        "insert into mimetype (extension, mimetype) values ('.pml', 'application/vnd.ctc-posml');\n",
        "insert into mimetype (extension, mimetype) values ('.gam', 'chemical/x-gamess-input');\n",
        "insert into mimetype (extension, mimetype) values ('.iso', 'application/x-iso9660-image');\n",
        "insert into mimetype (extension, mimetype) values ('.rl', 'application/resource-lists+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.ras', 'image/x-cmu-raster');\n",
        "insert into mimetype (extension, mimetype) values ('.rar', 'application/rar');\n",
        "insert into mimetype (extension, mimetype) values ('.embl', 'chemical/x-embl-dl-nucleotide');\n",
        "insert into mimetype (extension, mimetype) values ('.mrc', 'application/marc');\n",
        "insert into mimetype (extension, mimetype) values ('.sdkd', 'application/vnd.solent.sdkm+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.bcpio', 'application/x-bcpio');\n",
        "insert into mimetype (extension, mimetype) values ('.sdkm', 'application/vnd.solent.sdkm+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.list3820', 'application/vnd.ibm.modcap');\n",
        "insert into mimetype (extension, mimetype) values ('.ecelp7470', 'audio/vnd.nuera.ecelp7470');\n",
        "insert into mimetype (extension, mimetype) values ('.ist', 'chemical/x-isostar');\n",
        "insert into mimetype (extension, mimetype) values ('.bz', 'application/x-bzip');\n",
        "insert into mimetype (extension, mimetype) values ('.bmp', 'image/x-ms-bmp');\n",
        "insert into mimetype (extension, mimetype) values ('.gen', 'chemical/x-genbank');\n",
        "insert into mimetype (extension, mimetype) values ('.jisp', 'application/vnd.jisp');\n",
        "insert into mimetype (extension, mimetype) values ('.bmi', 'application/vnd.bmi');\n",
        "insert into mimetype (extension, mimetype) values ('.tcl', 'text/x-tcl');\n",
        "insert into mimetype (extension, mimetype) values ('.dvi', 'application/x-dvi');\n",
        "insert into mimetype (extension, mimetype) values ('.aif', 'audio/x-aiff');\n",
        "insert into mimetype (extension, mimetype) values ('.rd', 'chemical/x-mdl-rdfile');\n",
        "insert into mimetype (extension, mimetype) values ('.gjf', 'chemical/x-gaussian-input');\n",
        "insert into mimetype (extension, mimetype) values ('.hpid', 'application/vnd.hp-hpid');\n",
        "insert into mimetype (extension, mimetype) values ('.ott', 'application/vnd.oasis.opendocument.text-template');\n",
        "insert into mimetype (extension, mimetype) values ('.rss', 'application/rss+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.ots', 'application/vnd.oasis.opendocument.spreadsheet-template');\n",
        "insert into mimetype (extension, mimetype) values ('.cst', 'application/vnd.commonspace');\n",
        "insert into mimetype (extension, mimetype) values ('.p10', 'application/pkcs10');\n",
        "insert into mimetype (extension, mimetype) values ('.csv', 'text/comma-separated-values');\n",
        "insert into mimetype (extension, mimetype) values ('.p12', 'application/x-pkcs12');\n",
        "insert into mimetype (extension, mimetype) values ('.csp', 'application/vnd.commonspace');\n",
        "insert into mimetype (extension, mimetype) values ('.sus', 'application/vnd.sus-calendar');\n",
        "insert into mimetype (extension, mimetype) values ('.css', 'text/css');\n",
        "insert into mimetype (extension, mimetype) values ('.csm', 'chemical/x-csml');\n",
        "insert into mimetype (extension, mimetype) values ('.otg', 'application/vnd.oasis.opendocument.graphics-template');\n",
        "insert into mimetype (extension, mimetype) values ('.otf', 'application/vnd.oasis.opendocument.formula-template');\n",
        "insert into mimetype (extension, mimetype) values ('.csh', 'text/x-csh');\n",
        "insert into mimetype (extension, mimetype) values ('.otc', 'application/vnd.oasis.opendocument.chart-template');\n",
        "insert into mimetype (extension, mimetype) values ('.otm', 'application/vnd.oasis.opendocument.text-master');\n",
        "insert into mimetype (extension, mimetype) values ('.csf', 'chemical/x-cache-csf');\n",
        "insert into mimetype (extension, mimetype) values ('.clkp', 'application/vnd.crick.clicker.palette');\n",
        "insert into mimetype (extension, mimetype) values ('.pdf', 'application/pdf');\n",
        "insert into mimetype (extension, mimetype) values ('.bdm', 'application/vnd.syncml.dm+wbxml');\n",
        "insert into mimetype (extension, mimetype) values ('.pm', 'text/x-perl');\n",
        "insert into mimetype (extension, mimetype) values ('.pl', 'text/x-perl');\n",
        "insert into mimetype (extension, mimetype) values ('.atomsvc', 'application/atomsvc+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.pk', 'application/x-tex-pk');\n",
        "insert into mimetype (extension, mimetype) values ('.chm', 'chemical/x-chemdraw');\n",
        "insert into mimetype (extension, mimetype) values ('.djv', 'image/vnd.djvu');\n",
        "insert into mimetype (extension, mimetype) values ('.hta', 'application/hta');\n",
        "insert into mimetype (extension, mimetype) values ('.py', 'text/x-python');\n",
        "insert into mimetype (extension, mimetype) values ('.mopcrt', 'chemical/x-mopac-input');\n",
        "insert into mimetype (extension, mimetype) values ('.xml', 'application/xml');\n",
        "insert into mimetype (extension, mimetype) values ('.umj', 'application/vnd.umajin');\n",
        "insert into mimetype (extension, mimetype) values ('.htm', 'text/html');\n",
        "insert into mimetype (extension, mimetype) values ('.m2a', 'audio/mpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.fig', 'application/x-xfig');\n",
        "insert into mimetype (extension, mimetype) values ('.sig', 'application/pgp-signature');\n",
        "insert into mimetype (extension, mimetype) values ('.sid', 'audio/prs.sid');\n",
        "insert into mimetype (extension, mimetype) values ('.cab', 'application/vnd.ms-cab-compressed');\n",
        "insert into mimetype (extension, mimetype) values ('.tsv', 'text/tab-separated-values');\n",
        "insert into mimetype (extension, mimetype) values ('.so', 'application/octet-stream');\n",
        "insert into mimetype (extension, mimetype) values ('.ltx', 'text/x-tex');\n",
        "insert into mimetype (extension, mimetype) values ('.tsp', 'application/dsptype');\n",
        "insert into mimetype (extension, mimetype) values ('.ltf', 'application/vnd.frogans.ltf');\n",
        "insert into mimetype (extension, mimetype) values ('.wbs', 'application/vnd.criticaltools.wbs+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.prc', 'application/vnd.palm');\n",
        "insert into mimetype (extension, mimetype) values ('.pre', 'application/vnd.lotus-freelance');\n",
        "insert into mimetype (extension, mimetype) values ('.prf', 'application/pics-rules');\n",
        "insert into mimetype (extension, mimetype) values ('.oprc', 'application/vnd.palm');\n",
        "insert into mimetype (extension, mimetype) values ('.c3d', 'chemical/x-chem3d');\n",
        "insert into mimetype (extension, mimetype) values ('.dd2', 'application/vnd.oma.dd2+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.cat', 'application/vnd.ms-pki.seccat');\n",
        "insert into mimetype (extension, mimetype) values ('.dms', 'application/x-dms');\n",
        "insert into mimetype (extension, mimetype) values ('.xla', 'application/vnd.ms-excel');\n",
        "insert into mimetype (extension, mimetype) values ('.fti', 'application/vnd.anser-web-funds-transfer-initiation');\n",
        "insert into mimetype (extension, mimetype) values ('.ief', 'image/ief');\n",
        "insert into mimetype (extension, mimetype) values ('.mp4s', 'application/mp4');\n",
        "insert into mimetype (extension, mimetype) values ('.qwt', 'application/vnd.quark.quarkxpress');\n",
        "insert into mimetype (extension, mimetype) values ('.c4d', 'application/vnd.clonk.c4group');\n",
        "insert into mimetype (extension, mimetype) values ('.c4g', 'application/vnd.clonk.c4group');\n",
        "insert into mimetype (extension, mimetype) values ('.c4f', 'application/vnd.clonk.c4group');\n",
        "insert into mimetype (extension, mimetype) values ('.texinfo', 'application/x-texinfo');\n",
        "insert into mimetype (extension, mimetype) values ('.mp4a', 'audio/mp4');\n",
        "insert into mimetype (extension, mimetype) values ('.dmg', 'application/x-apple-diskimage');\n",
        "insert into mimetype (extension, mimetype) values ('.c4p', 'application/vnd.clonk.c4group');\n",
        "insert into mimetype (extension, mimetype) values ('.c4u', 'application/vnd.clonk.c4group');\n",
        "insert into mimetype (extension, mimetype) values ('.vis', 'application/vnd.visionary');\n",
        "insert into mimetype (extension, mimetype) values ('.viv', 'video/vnd.vivo');\n",
        "insert into mimetype (extension, mimetype) values ('.listafp', 'application/vnd.ibm.modcap');\n",
        "insert into mimetype (extension, mimetype) values ('.ddd', 'application/vnd.fujixerox.ddd');\n",
        "insert into mimetype (extension, mimetype) values ('.tmo', 'application/vnd.tmobile-livetv');\n",
        "insert into mimetype (extension, mimetype) values ('.ext', 'application/vnd.novadigm.ext');\n",
        "insert into mimetype (extension, mimetype) values ('.csml', 'chemical/x-csml');\n",
        "insert into mimetype (extension, mimetype) values ('.mus', 'application/vnd.musician');\n",
        "insert into mimetype (extension, mimetype) values ('.exe', 'application/x-msdos-program');\n",
        "insert into mimetype (extension, mimetype) values ('.xpw', 'application/vnd.intercon.formnet');\n",
        "insert into mimetype (extension, mimetype) values ('.wsc', 'text/scriptlet');\n",
        "insert into mimetype (extension, mimetype) values ('.xpr', 'application/vnd.is-xpr');\n",
        "insert into mimetype (extension, mimetype) values ('.xps', 'application/vnd.ms-xpsdocument');\n",
        "insert into mimetype (extension, mimetype) values ('.dsc', 'text/prs.lines.tag');\n",
        "insert into mimetype (extension, mimetype) values ('.xpx', 'application/vnd.intercon.formnet');\n",
        "insert into mimetype (extension, mimetype) values ('.mscml', 'application/mediaservercontrol+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.rep', 'application/vnd.businessobjects');\n",
        "insert into mimetype (extension, mimetype) values ('.xpm', 'image/x-xpixmap');\n",
        "insert into mimetype (extension, mimetype) values ('.mpeg', 'video/mpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.mxf', 'application/mxf');\n",
        "insert into mimetype (extension, mimetype) values ('.spq', 'application/scvp-vp-request');\n",
        "insert into mimetype (extension, mimetype) values ('.spp', 'application/scvp-vp-response');\n",
        "insert into mimetype (extension, mimetype) values ('.ami', 'application/vnd.amiga.ami');\n",
        "insert into mimetype (extension, mimetype) values ('.fm', 'application/x-maker');\n",
        "insert into mimetype (extension, mimetype) values ('.ram', 'audio/x-pn-realaudio');\n",
        "insert into mimetype (extension, mimetype) values ('.sgml', 'text/sgml');\n",
        "insert into mimetype (extension, mimetype) values ('.spf', 'application/vnd.yamaha.smaf-phrase');\n",
        "insert into mimetype (extension, mimetype) values ('.cil', 'application/vnd.ms-artgalry');\n",
        "insert into mimetype (extension, mimetype) values ('.spc', 'chemical/x-galactic-spc');\n",
        "insert into mimetype (extension, mimetype) values ('.spl', 'application/x-futuresplash');\n",
        "insert into mimetype (extension, mimetype) values ('.bat', 'application/x-msdos-program');\n",
        "insert into mimetype (extension, mimetype) values ('.clkx', 'application/vnd.crick.clicker');\n",
        "insert into mimetype (extension, mimetype) values ('.portpkg', 'application/vnd.macports.portpkg');\n",
        "insert into mimetype (extension, mimetype) values ('.emb', 'chemical/x-embl-dl-nucleotide');\n",
        "insert into mimetype (extension, mimetype) values ('.eml', 'message/rfc822');\n",
        "insert into mimetype (extension, mimetype) values ('.cbin', 'chemical/x-cactvs-binary');\n",
        "insert into mimetype (extension, mimetype) values ('.diff', 'text/plain');\n",
        "insert into mimetype (extension, mimetype) values ('.gac', 'application/vnd.groove-account');\n",
        "insert into mimetype (extension, mimetype) values ('.cww', 'application/prs.cww');\n",
        "insert into mimetype (extension, mimetype) values ('.gal', 'chemical/x-gaussian-log');\n",
        "insert into mimetype (extension, mimetype) values ('.efif', 'application/vnd.picsel');\n",
        "insert into mimetype (extension, mimetype) values ('.isp', 'application/x-internet-signup');\n",
        "insert into mimetype (extension, mimetype) values ('.gjc', 'chemical/x-gaussian-input');\n",
        "insert into mimetype (extension, mimetype) values ('.wad', 'application/x-doom');\n",
        "insert into mimetype (extension, mimetype) values ('.saf', 'application/vnd.yamaha.smaf-audio');\n",
        "insert into mimetype (extension, mimetype) values ('.txf', 'application/vnd.mobius.txf');\n",
        "insert into mimetype (extension, mimetype) values ('.utz', 'application/vnd.uiq.theme');\n",
        "insert into mimetype (extension, mimetype) values ('.txd', 'application/vnd.genomatix.tuxedo');\n",
        "insert into mimetype (extension, mimetype) values ('.m2v', 'video/mpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.art', 'image/x-jg');\n",
        "insert into mimetype (extension, mimetype) values ('.tk', 'text/x-tcl');\n",
        "insert into mimetype (extension, mimetype) values ('.wav', 'audio/x-wav');\n",
        "insert into mimetype (extension, mimetype) values ('.rsd', 'application/rsd+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.xbm', 'image/x-xbitmap');\n",
        "insert into mimetype (extension, mimetype) values ('.txt', 'text/plain');\n",
        "insert into mimetype (extension, mimetype) values ('.jlt', 'application/vnd.hp-jlyt');\n",
        "insert into mimetype (extension, mimetype) values ('.xbd', 'application/vnd.fujixerox.docuworks.binder');\n",
        "insert into mimetype (extension, mimetype) values ('.wax', 'audio/x-ms-wax');\n",
        "insert into mimetype (extension, mimetype) values ('.mlp', 'application/vnd.dolby.mlp');\n",
        "insert into mimetype (extension, mimetype) values ('.sc', 'application/vnd.ibm.secure-container');\n",
        "insert into mimetype (extension, mimetype) values ('.twd', 'application/vnd.simtech-mindmapper');\n",
        "insert into mimetype (extension, mimetype) values ('.dna', 'application/vnd.dna');\n",
        "insert into mimetype (extension, mimetype) values ('.ts', 'text/texmacs');\n",
        "insert into mimetype (extension, mimetype) values ('.tr', 'application/x-troff');\n",
        "insert into mimetype (extension, mimetype) values ('.distz', 'application/octet-stream');\n",
        "insert into mimetype (extension, mimetype) values ('.fbdoc', 'application/x-maker');\n",
        "insert into mimetype (extension, mimetype) values ('.tm', 'text/texmacs');\n",
        "insert into mimetype (extension, mimetype) values ('.smil', 'application/smil');\n",
        "insert into mimetype (extension, mimetype) values ('.fnc', 'application/vnd.frogans.fnc');\n",
        "insert into mimetype (extension, mimetype) values ('.sh', 'text/x-sh');\n",
        "insert into mimetype (extension, mimetype) values ('.et3', 'application/vnd.eszigno3+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.xif', 'image/vnd.xiff');\n",
        "insert into mimetype (extension, mimetype) values ('.daf', 'application/vnd.mobius.daf');\n",
        "insert into mimetype (extension, mimetype) values ('.ez2', 'application/vnd.ezpix-album');\n",
        "insert into mimetype (extension, mimetype) values ('.old', 'application/x-trash');\n",
        "insert into mimetype (extension, mimetype) values ('.cer', 'chemical/x-cerius');\n",
        "insert into mimetype (extension, mimetype) values ('.smf', 'application/vnd.stardivision.math');\n",
        "insert into mimetype (extension, mimetype) values ('.ufd', 'application/vnd.ufdl');\n",
        "insert into mimetype (extension, mimetype) values ('.cef', 'chemical/x-cxf');\n",
        "insert into mimetype (extension, mimetype) values ('.smi', 'application/smil');\n",
        "insert into mimetype (extension, mimetype) values ('.bsd', 'chemical/x-crossfire');\n",
        "insert into mimetype (extension, mimetype) values ('.ctab', 'chemical/x-cactvs-binary');\n",
        "insert into mimetype (extension, mimetype) values ('.inp', 'chemical/x-gamess-input');\n",
        "insert into mimetype (extension, mimetype) values ('.sfs', 'application/vnd.spotfire.sfs');\n",
        "insert into mimetype (extension, mimetype) values ('.ecma', 'application/ecmascript');\n",
        "insert into mimetype (extension, mimetype) values ('.etx', 'text/x-setext');\n",
        "insert into mimetype (extension, mimetype) values ('.iges', 'model/iges');\n",
        "insert into mimetype (extension, mimetype) values ('.dxr', 'application/x-director');\n",
        "insert into mimetype (extension, mimetype) values ('.dxp', 'application/vnd.spotfire.dxp');\n",
        "insert into mimetype (extension, mimetype) values ('.png', 'image/png');\n",
        "insert into mimetype (extension, mimetype) values ('.mhtml', 'message/rfc822');\n",
        "insert into mimetype (extension, mimetype) values ('.tar', 'application/x-tar');\n",
        "insert into mimetype (extension, mimetype) values ('.pnm', 'image/x-portable-anymap');\n",
        "insert into mimetype (extension, mimetype) values ('.taz', 'application/x-gtar');\n",
        "insert into mimetype (extension, mimetype) values ('.pnt', 'image/x-macpaint');\n",
        "insert into mimetype (extension, mimetype) values ('.mqy', 'application/vnd.mobius.mqy');\n",
        "insert into mimetype (extension, mimetype) values ('.dxf', 'image/vnd.dxf');\n",
        "insert into mimetype (extension, mimetype) values ('.rnc', 'application/relax-ng-compact-syntax');\n",
        "insert into mimetype (extension, mimetype) values ('.tao', 'application/vnd.tao.intent-module-archive');\n",
        "insert into mimetype (extension, mimetype) values ('.323', 'text/h323');\n",
        "insert into mimetype (extension, mimetype) values ('.wvx', 'video/x-ms-wvx');\n",
        "insert into mimetype (extension, mimetype) values ('.gdl', 'model/vnd.gdl');\n",
        "insert into mimetype (extension, mimetype) values ('.hpgl', 'application/vnd.hp-hpgl');\n",
        "insert into mimetype (extension, mimetype) values ('.bak', 'application/x-trash');\n",
        "insert into mimetype (extension, mimetype) values ('.jng', 'image/x-jng');\n",
        "insert into mimetype (extension, mimetype) values ('.chrt', 'application/x-kchart');\n",
        "insert into mimetype (extension, mimetype) values ('.ecelp9600', 'audio/vnd.nuera.ecelp9600');\n",
        "insert into mimetype (extension, mimetype) values ('.wbxml', 'application/vnd.wap.wbxml');\n",
        "insert into mimetype (extension, mimetype) values ('.wsdl', 'application/wsdl+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.dwg', 'image/vnd.dwg');\n",
        "insert into mimetype (extension, mimetype) values ('.dwf', 'model/vnd.dwf');\n",
        "insert into mimetype (extension, mimetype) values ('.jmz', 'application/x-jmol');\n",
        "insert into mimetype (extension, mimetype) values ('.fg5', 'application/vnd.fujitsu.oasysgp');\n",
        "insert into mimetype (extension, mimetype) values ('.oza', 'application/x-oz-application');\n",
        "insert into mimetype (extension, mimetype) values ('.cc', 'text/x-c++src');\n",
        "insert into mimetype (extension, mimetype) values ('.cu', 'application/cu-seeme');\n",
        "insert into mimetype (extension, mimetype) values ('.rxn', 'chemical/x-mdl-rxnfile');\n",
        "insert into mimetype (extension, mimetype) values ('.ei6', 'application/vnd.pg.osasli');\n",
        "insert into mimetype (extension, mimetype) values ('.sty', 'text/x-tex');\n",
        "insert into mimetype (extension, mimetype) values ('.rpm', 'application/x-redhat-package-manager');\n",
        "insert into mimetype (extension, mimetype) values ('.mcd', 'application/vnd.mcd');\n",
        "insert into mimetype (extension, mimetype) values ('.nnd', 'application/vnd.noblenet-directory');\n",
        "insert into mimetype (extension, mimetype) values ('.nlu', 'application/vnd.neurolanguage.nlu');\n",
        "insert into mimetype (extension, mimetype) values ('.str', 'application/vnd.pg.format');\n",
        "insert into mimetype (extension, mimetype) values ('.stw', 'application/vnd.sun.xml.writer.template');\n",
        "insert into mimetype (extension, mimetype) values ('.mjp2', 'video/mj2');\n",
        "insert into mimetype (extension, mimetype) values ('.xhvml', 'application/xv+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.stk', 'application/hyperstudio');\n",
        "insert into mimetype (extension, mimetype) values ('.crl', 'application/x-pkcs7-crl');\n",
        "insert into mimetype (extension, mimetype) values ('.semd', 'application/vnd.semd');\n",
        "insert into mimetype (extension, mimetype) values ('.nnw', 'application/vnd.noblenet-web');\n",
        "insert into mimetype (extension, mimetype) values ('.semf', 'application/vnd.semf');\n",
        "insert into mimetype (extension, mimetype) values ('.stc', 'application/vnd.sun.xml.calc.template');\n",
        "insert into mimetype (extension, mimetype) values ('.crd', 'application/x-mscardfile');\n",
        "insert into mimetype (extension, mimetype) values ('.std', 'application/vnd.sun.xml.draw.template');\n",
        "insert into mimetype (extension, mimetype) values ('.m1v', 'video/mpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.stf', 'application/vnd.wt.stf');\n",
        "insert into mimetype (extension, mimetype) values ('.icz', 'text/calendar');\n",
        "insert into mimetype (extension, mimetype) values ('.mime', 'message/rfc822');\n",
        "insert into mimetype (extension, mimetype) values ('.hin', 'chemical/x-hin');\n",
        "insert into mimetype (extension, mimetype) values ('.avi', 'video/x-msvideo');\n",
        "insert into mimetype (extension, mimetype) values ('.fgd', 'application/x-director');\n",
        "insert into mimetype (extension, mimetype) values ('.istr', 'chemical/x-isostar');\n",
        "insert into mimetype (extension, mimetype) values ('.cascii', 'chemical/x-cactvs-binary');\n",
        "insert into mimetype (extension, mimetype) values ('.qfx', 'application/vnd.intu.qfx');\n",
        "insert into mimetype (extension, mimetype) values ('.wdb', 'application/vnd.ms-works');\n",
        "insert into mimetype (extension, mimetype) values ('.cla', 'application/vnd.claymore');\n",
        "insert into mimetype (extension, mimetype) values ('.pwn', 'application/vnd.3m.post-it-notes');\n",
        "insert into mimetype (extension, mimetype) values ('.hxx', 'text/x-c++hdr');\n",
        "insert into mimetype (extension, mimetype) values ('.wml', 'text/vnd.wap.wml');\n",
        "insert into mimetype (extension, mimetype) values ('.mht', 'message/rfc822');\n",
        "insert into mimetype (extension, mimetype) values ('.wma', 'audio/x-ms-wma');\n",
        "insert into mimetype (extension, mimetype) values ('.wmf', 'application/x-msmetafile');\n",
        "insert into mimetype (extension, mimetype) values ('.wmd', 'application/x-ms-wmd');\n",
        "insert into mimetype (extension, mimetype) values ('.wmz', 'application/x-ms-wmz');\n",
        "insert into mimetype (extension, mimetype) values ('.clp', 'application/x-msclip');\n",
        "insert into mimetype (extension, mimetype) values ('.wmx', 'video/x-ms-wmx');\n",
        "insert into mimetype (extension, mimetype) values ('.gamin', 'chemical/x-gamess-input');\n",
        "insert into mimetype (extension, mimetype) values ('.pwz', 'application/vnd.ms-powerpoint');\n",
        "insert into mimetype (extension, mimetype) values ('.hpp', 'text/x-c++hdr');\n",
        "insert into mimetype (extension, mimetype) values ('.mc1', 'application/vnd.medcalcdata');\n",
        "insert into mimetype (extension, mimetype) values ('.m13', 'application/x-msmediaview');\n",
        "insert into mimetype (extension, mimetype) values ('.m14', 'application/x-msmediaview');\n",
        "insert into mimetype (extension, mimetype) values ('.dist', 'application/octet-stream');\n",
        "insert into mimetype (extension, mimetype) values ('.nml', 'application/vnd.enliven');\n",
        "insert into mimetype (extension, mimetype) values ('.kpt', 'application/x-kpresenter');\n",
        "insert into mimetype (extension, mimetype) values ('.kpr', 'application/x-kpresenter');\n",
        "insert into mimetype (extension, mimetype) values ('.src', 'application/x-wais-source');\n",
        "insert into mimetype (extension, mimetype) values ('.sik', 'application/x-trash');\n",
        "insert into mimetype (extension, mimetype) values ('.oa2', 'application/vnd.fujitsu.oasys2');\n",
        "insert into mimetype (extension, mimetype) values ('.oa3', 'application/vnd.fujitsu.oasys3');\n",
        "insert into mimetype (extension, mimetype) values ('.gtar', 'application/x-gtar');\n",
        "insert into mimetype (extension, mimetype) values ('.p7m', 'application/pkcs7-mime');\n",
        "insert into mimetype (extension, mimetype) values ('.nws', 'message/rfc822');\n",
        "insert into mimetype (extension, mimetype) values ('.deb', 'application/x-debian-package');\n",
        "insert into mimetype (extension, mimetype) values ('.p7c', 'application/pkcs7-mime');\n",
        "insert into mimetype (extension, mimetype) values ('.p7b', 'application/x-pkcs7-certificates');\n",
        "insert into mimetype (extension, mimetype) values ('.book', 'application/x-maker');\n",
        "insert into mimetype (extension, mimetype) values ('.def', 'text/plain');\n",
        "insert into mimetype (extension, mimetype) values ('.mts', 'model/vnd.mts');\n",
        "insert into mimetype (extension, mimetype) values ('.cls', 'text/x-tex');\n",
        "insert into mimetype (extension, mimetype) values ('.nwc', 'application/x-nwc');\n",
        "insert into mimetype (extension, mimetype) values ('.bpk', 'application/octet-stream');\n",
        "insert into mimetype (extension, mimetype) values ('.ez', 'application/andrew-inset');\n",
        "insert into mimetype (extension, mimetype) values ('.der', 'application/x-x509-ca-cert');\n",
        "insert into mimetype (extension, mimetype) values ('.p7s', 'application/pkcs7-signature');\n",
        "insert into mimetype (extension, mimetype) values ('.p7r', 'application/x-pkcs7-certreqresp');\n",
        "insert into mimetype (extension, mimetype) values ('.pntg', 'image/x-macpaint');\n",
        "insert into mimetype (extension, mimetype) values ('.eps', 'application/postscript');\n",
        "insert into mimetype (extension, mimetype) values ('.xul', 'application/vnd.mozilla.xul+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.ace', 'application/x-ace-compressed');\n",
        "insert into mimetype (extension, mimetype) values ('.hh', 'text/x-c++hdr');\n",
        "insert into mimetype (extension, mimetype) values ('.cdr', 'image/x-coreldraw');\n",
        "insert into mimetype (extension, mimetype) values ('.pdb', 'chemical/x-pdb');\n",
        "insert into mimetype (extension, mimetype) values ('.dfac', 'application/vnd.dreamfactory');\n",
        "insert into mimetype (extension, mimetype) values ('.hs', 'text/x-haskell');\n",
        "insert into mimetype (extension, mimetype) values ('.acu', 'application/vnd.acucobol');\n",
        "insert into mimetype (extension, mimetype) values ('.wmlsc', 'application/vnd.wap.wmlscriptc');\n",
        "insert into mimetype (extension, mimetype) values ('.oas', 'application/vnd.fujitsu.oasys');\n",
        "insert into mimetype (extension, mimetype) values ('.c++', 'text/x-c++src');\n",
        "insert into mimetype (extension, mimetype) values ('.tex', 'text/x-tex');\n",
        "insert into mimetype (extension, mimetype) values ('.wri', 'application/x-mswrite');\n",
        "insert into mimetype (extension, mimetype) values ('.ica', 'application/x-ica');\n",
        "insert into mimetype (extension, mimetype) values ('.irp', 'application/vnd.irepository.package+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.wrl', 'x-world/x-vrml');\n",
        "insert into mimetype (extension, mimetype) values ('.oti', 'application/vnd.oasis.opendocument.image-template');\n",
        "insert into mimetype (extension, mimetype) values ('.ssf', 'application/vnd.epson.ssf');\n",
        "insert into mimetype (extension, mimetype) values ('.sitx', 'application/x-stuffitx');\n",
        "insert into mimetype (extension, mimetype) values ('.oth', 'application/vnd.oasis.opendocument.text-web');\n",
        "insert into mimetype (extension, mimetype) values ('.xpi', 'application/x-xpinstall');\n",
        "insert into mimetype (extension, mimetype) values ('.rtx', 'text/richtext');\n",
        "insert into mimetype (extension, mimetype) values ('.moc', 'text/x-moc');\n",
        "insert into mimetype (extension, mimetype) values ('.irm', 'application/vnd.ibm.rights-management');\n",
        "insert into mimetype (extension, mimetype) values ('.cdf', 'application/x-cdf');\n",
        "insert into mimetype (extension, mimetype) values ('.joda', 'application/vnd.joost.joda-archive');\n",
        "insert into mimetype (extension, mimetype) values ('.rpst', 'application/vnd.nokia.radio-preset');\n",
        "insert into mimetype (extension, mimetype) values ('.gsm', 'audio/x-gsm');\n",
        "insert into mimetype (extension, mimetype) values ('.fdf', 'application/vnd.fdf');\n",
        "insert into mimetype (extension, mimetype) values ('.elc', 'application/octet-stream');\n",
        "insert into mimetype (extension, mimetype) values ('.man', 'application/x-troff-man');\n",
        "insert into mimetype (extension, mimetype) values ('.rpss', 'application/vnd.nokia.radio-presets');\n",
        "insert into mimetype (extension, mimetype) values ('.pac', 'application/x-ns-proxy-autoconfig');\n",
        "insert into mimetype (extension, mimetype) values ('.flac', 'application/x-flac');\n",
        "insert into mimetype (extension, mimetype) values ('.hps', 'application/vnd.hp-hps');\n",
        "insert into mimetype (extension, mimetype) values ('.mfm', 'application/vnd.mfmp');\n",
        "insert into mimetype (extension, mimetype) values ('.pas', 'text/x-pascal');\n",
        "insert into mimetype (extension, mimetype) values ('.pat', 'image/x-coreldrawpattern');\n",
        "insert into mimetype (extension, mimetype) values ('.fbs', 'image/vnd.fastbidsheet');\n",
        "insert into mimetype (extension, mimetype) values ('.gim', 'application/vnd.groove-identity-message');\n",
        "insert into mimetype (extension, mimetype) values ('.kfo', 'application/vnd.kde.kformula');\n",
        "insert into mimetype (extension, mimetype) values ('.moo', 'chemical/x-mopac-out');\n",
        "insert into mimetype (extension, mimetype) values ('.mol', 'chemical/x-mdl-molfile');\n",
        "insert into mimetype (extension, mimetype) values ('.ims', 'application/vnd.ms-ims');\n",
        "insert into mimetype (extension, mimetype) values ('.gif', 'image/gif');\n",
        "insert into mimetype (extension, mimetype) values ('.lrm', 'application/vnd.ms-lrm');\n",
        "insert into mimetype (extension, mimetype) values ('.cdkey', 'application/vnd.mediastation.cdkey');\n",
        "insert into mimetype (extension, mimetype) values ('.atomcat', 'application/atomcat+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.les', 'application/vnd.hhe.lesson-player');\n",
        "insert into mimetype (extension, mimetype) values ('.shtml', 'text/html');\n",
        "insert into mimetype (extension, mimetype) values ('.djvu', 'image/vnd.djvu');\n",
        "insert into mimetype (extension, mimetype) values ('.rtf', 'text/rtf');\n",
        "insert into mimetype (extension, mimetype) values ('.fchk', 'chemical/x-gaussian-checkpoint');\n",
        "insert into mimetype (extension, mimetype) values ('.mop', 'chemical/x-mopac-input');\n",
        "insert into mimetype (extension, mimetype) values ('.mov', 'video/quicktime');\n",
        "insert into mimetype (extension, mimetype) values ('.xcf', 'application/x-xcf');\n",
        "insert into mimetype (extension, mimetype) values ('.twds', 'application/vnd.simtech-mindmapper');\n",
        "insert into mimetype (extension, mimetype) values ('.movie', 'video/x-sgi-movie');\n",
        "insert into mimetype (extension, mimetype) values ('.uls', 'text/iuls');\n",
        "insert into mimetype (extension, mimetype) values ('.qt', 'video/quicktime');\n",
        "insert into mimetype (extension, mimetype) values ('.pyc', 'application/x-python-code');\n",
        "insert into mimetype (extension, mimetype) values ('.sv4cpio', 'application/x-sv4cpio');\n",
        "insert into mimetype (extension, mimetype) values ('.rms', 'application/vnd.jcp.javame.midlet-rms');\n",
        "insert into mimetype (extension, mimetype) values ('.com', 'application/x-msdos-program');\n",
        "insert into mimetype (extension, mimetype) values ('.cac', 'chemical/x-cache');\n",
        "insert into mimetype (extension, mimetype) values ('.mathml', 'application/mathml+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.key', 'application/pgp-keys');\n",
        "insert into mimetype (extension, mimetype) values ('.psp', 'text/x-psp');\n",
        "insert into mimetype (extension, mimetype) values ('.wiz', 'application/msword');\n",
        "insert into mimetype (extension, mimetype) values ('.vcd', 'application/x-cdlink');\n",
        "insert into mimetype (extension, mimetype) values ('.vcg', 'application/vnd.groove-vcard');\n",
        "insert into mimetype (extension, mimetype) values ('.vcf', 'text/x-vcard');\n",
        "insert into mimetype (extension, mimetype) values ('.json', 'application/json');\n",
        "insert into mimetype (extension, mimetype) values ('.shf', 'application/shf+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.cdbcmsg', 'application/vnd.contact.cmsg');\n",
        "insert into mimetype (extension, mimetype) values ('.tpt', 'application/vnd.trid.tpt');\n",
        "insert into mimetype (extension, mimetype) values ('.psb', 'application/vnd.3gpp.pic-bw-small');\n",
        "insert into mimetype (extension, mimetype) values ('.vxml', 'application/voicexml+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.tpl', 'application/vnd.groove-tool-template');\n",
        "insert into mimetype (extension, mimetype) values ('.htke', 'application/vnd.kenameaapp');\n",
        "insert into mimetype (extension, mimetype) values ('.vcx', 'application/vnd.vcx');\n",
        "insert into mimetype (extension, mimetype) values ('.xhtml', 'application/xhtml+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.midi', 'audio/midi');\n",
        "insert into mimetype (extension, mimetype) values ('.tiff', 'image/tiff');\n",
        "insert into mimetype (extension, mimetype) values ('.odg', 'application/vnd.oasis.opendocument.graphics');\n",
        "insert into mimetype (extension, mimetype) values ('.texi', 'application/x-texinfo');\n",
        "insert into mimetype (extension, mimetype) values ('.oda', 'application/oda');\n",
        "insert into mimetype (extension, mimetype) values ('.ustar', 'application/x-ustar');\n",
        "insert into mimetype (extension, mimetype) values ('.ssml', 'application/ssml+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.odb', 'application/vnd.oasis.opendocument.database');\n",
        "insert into mimetype (extension, mimetype) values ('.odm', 'application/vnd.oasis.opendocument.text-master');\n",
        "insert into mimetype (extension, mimetype) values ('.xvm', 'application/xv+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.see', 'application/vnd.seemail');\n",
        "insert into mimetype (extension, mimetype) values ('.odi', 'application/vnd.oasis.opendocument.image');\n",
        "insert into mimetype (extension, mimetype) values ('.mpkg', 'application/vnd.apple.installer+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.odt', 'application/vnd.oasis.opendocument.text');\n",
        "insert into mimetype (extension, mimetype) values ('.3g2', 'video/3gpp2');\n",
        "insert into mimetype (extension, mimetype) values ('.odp', 'application/vnd.oasis.opendocument.presentation');\n",
        "insert into mimetype (extension, mimetype) values ('.ods', 'application/vnd.oasis.opendocument.spreadsheet');\n",
        "insert into mimetype (extension, mimetype) values ('.stl', 'application/vnd.ms-pki.stl');\n",
        "insert into mimetype (extension, mimetype) values ('.msi', 'application/x-msi');\n",
        "insert into mimetype (extension, mimetype) values ('.ser', 'application/java-serialized-object');\n",
        "insert into mimetype (extension, mimetype) values ('.text', 'text/plain');\n",
        "insert into mimetype (extension, mimetype) values ('.ros', 'chemical/x-rosdal');\n",
        "insert into mimetype (extension, mimetype) values ('.mpn', 'application/vnd.mophun.application');\n",
        "insert into mimetype (extension, mimetype) values ('.mpm', 'application/vnd.blueice.multipass');\n",
        "insert into mimetype (extension, mimetype) values ('.mpc', 'chemical/x-mopac-input');\n",
        "insert into mimetype (extension, mimetype) values ('.mpa', 'video/mpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.mpg', 'video/mpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.mng', 'video/x-mng');\n",
        "insert into mimetype (extension, mimetype) values ('.mpe', 'video/mpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.jdx', 'chemical/x-jcamp-dx');\n",
        "insert into mimetype (extension, mimetype) values ('.mpy', 'application/vnd.ibm.minipay');\n",
        "insert into mimetype (extension, mimetype) values ('.pot', 'text/plain');\n",
        "insert into mimetype (extension, mimetype) values ('.ps', 'application/postscript');\n",
        "insert into mimetype (extension, mimetype) values ('.g3', 'image/g3fax');\n",
        "insert into mimetype (extension, mimetype) values ('.mpp', 'application/vnd.ms-project');\n",
        "insert into mimetype (extension, mimetype) values ('.xspf', 'application/xspf+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.nsf', 'application/vnd.lotus-notes');\n",
        "insert into mimetype (extension, mimetype) values ('.wmlc', 'application/vnd.wap.wmlc');\n",
        "insert into mimetype (extension, mimetype) values ('.dpg', 'application/vnd.dpgraph');\n",
        "insert into mimetype (extension, mimetype) values ('.nb', 'application/mathematica');\n",
        "insert into mimetype (extension, mimetype) values ('.wmls', 'text/vnd.wap.wmlscript');\n",
        "insert into mimetype (extension, mimetype) values ('.mmod', 'chemical/x-macromodel-input');\n",
        "insert into mimetype (extension, mimetype) values ('.kon', 'application/vnd.kde.kontour');\n",
        "insert into mimetype (extension, mimetype) values ('.karbon', 'application/vnd.kde.karbon');\n",
        "insert into mimetype (extension, mimetype) values ('.prt', 'chemical/x-ncbi-asn1-ascii');\n",
        "insert into mimetype (extension, mimetype) values ('.sw', 'chemical/x-swissprot');\n",
        "insert into mimetype (extension, mimetype) values ('.alc', 'chemical/x-alchemy');\n",
        "insert into mimetype (extension, mimetype) values ('.gf', 'application/x-tex-gf');\n",
        "insert into mimetype (extension, mimetype) values ('.pfx', 'application/x-pkcs12');\n",
        "insert into mimetype (extension, mimetype) values ('.m4a', 'audio/mpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.jnlp', 'application/x-java-jnlp-file');\n",
        "insert into mimetype (extension, mimetype) values ('.gl', 'video/gl');\n",
        "insert into mimetype (extension, mimetype) values ('.ivp', 'application/vnd.immervision-ivp');\n",
        "insert into mimetype (extension, mimetype) values ('.ivu', 'application/vnd.immervision-ivu');\n",
        "insert into mimetype (extension, mimetype) values ('.pfr', 'application/font-tdpfr');\n",
        "insert into mimetype (extension, mimetype) values ('.mcif', 'chemical/x-mmcif');\n",
        "insert into mimetype (extension, mimetype) values ('.m4v', 'video/mp4');\n",
        "insert into mimetype (extension, mimetype) values ('.m4u', 'video/vnd.mpegurl');\n",
        "insert into mimetype (extension, mimetype) values ('.swf', 'application/x-shockwave-flash');\n",
        "insert into mimetype (extension, mimetype) values ('.m4p', 'audio/mp4a-latm');\n",
        "insert into mimetype (extension, mimetype) values ('.mp3', 'audio/mpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.mp2', 'audio/mpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.pfa', 'application/x-font');\n",
        "insert into mimetype (extension, mimetype) values ('.pfb', 'application/x-font');\n",
        "insert into mimetype (extension, mimetype) values ('.mp4', 'video/mp4');\n",
        "insert into mimetype (extension, mimetype) values ('.cxf', 'chemical/x-cxf');\n",
        "insert into mimetype (extension, mimetype) values ('.hvp', 'application/vnd.yamaha.hv-voice');\n",
        "insert into mimetype (extension, mimetype) values ('.rm', 'audio/x-pn-realaudio');\n",
        "insert into mimetype (extension, mimetype) values ('.hvs', 'application/vnd.yamaha.hv-script');\n",
        "insert into mimetype (extension, mimetype) values ('.scpt', 'application/octet-stream');\n",
        "insert into mimetype (extension, mimetype) values ('.ra', 'audio/x-realaudio');\n",
        "insert into mimetype (extension, mimetype) values ('.sbml', 'application/sbml+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.gsf', 'application/x-font');\n",
        "insert into mimetype (extension, mimetype) values ('.hvd', 'application/vnd.yamaha.hv-dic');\n",
        "insert into mimetype (extension, mimetype) values ('.cmdf', 'chemical/x-cmdf');\n",
        "insert into mimetype (extension, mimetype) values ('.wcm', 'application/vnd.ms-works');\n",
        "insert into mimetype (extension, mimetype) values ('.sxd', 'application/vnd.sun.xml.draw');\n",
        "insert into mimetype (extension, mimetype) values ('.rs', 'application/rls-services+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.rq', 'application/sparql-query');\n",
        "insert into mimetype (extension, mimetype) values ('.sxg', 'application/vnd.sun.xml.writer.global');\n",
        "insert into mimetype (extension, mimetype) values ('.xop', 'application/xop+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.skd', 'application/x-koan');\n",
        "insert into mimetype (extension, mimetype) values ('.sis', 'application/vnd.symbian.install');\n",
        "insert into mimetype (extension, mimetype) values ('.h263', 'video/h263');\n",
        "insert into mimetype (extension, mimetype) values ('.skm', 'application/x-koan');\n",
        "insert into mimetype (extension, mimetype) values ('.h261', 'video/h261');\n",
        "insert into mimetype (extension, mimetype) values ('.h264', 'video/h264');\n",
        "insert into mimetype (extension, mimetype) values ('.skt', 'application/x-koan');\n",
        "insert into mimetype (extension, mimetype) values ('.plf', 'application/vnd.pocketlearn');\n",
        "insert into mimetype (extension, mimetype) values ('.skp', 'application/x-koan');\n",
        "insert into mimetype (extension, mimetype) values ('.ufdl', 'application/vnd.ufdl');\n",
        "insert into mimetype (extension, mimetype) values ('.for', 'text/x-fortran');\n",
        "insert into mimetype (extension, mimetype) values ('.lvp', 'audio/vnd.lucent.voice');\n",
        "insert into mimetype (extension, mimetype) values ('.hqx', 'application/mac-binhex40');\n",
        "insert into mimetype (extension, mimetype) values ('.swfl', 'application/x-shockwave-flash');\n",
        "insert into mimetype (extension, mimetype) values ('.ksp', 'application/x-kspread');\n",
        "insert into mimetype (extension, mimetype) values ('.sit', 'application/x-stuffit');\n",
        "insert into mimetype (extension, mimetype) values ('.doc', 'application/msword');\n",
        "insert into mimetype (extension, mimetype) values ('.uu', 'text/x-uuencode');\n",
        "insert into mimetype (extension, mimetype) values ('.shar', 'application/x-shar');\n",
        "insert into mimetype (extension, mimetype) values ('.ptid', 'application/vnd.pvi.ptid1');\n",
        "insert into mimetype (extension, mimetype) values ('.ksh', 'text/plain');\n",
        "insert into mimetype (extension, mimetype) values ('.ccxml', 'application/ccxml+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.dot', 'application/msword');\n",
        "insert into mimetype (extension, mimetype) values ('.cdy', 'application/vnd.cinderella');\n",
        "insert into mimetype (extension, mimetype) values ('.cdx', 'chemical/x-cdx');\n",
        "insert into mimetype (extension, mimetype) values ('.slt', 'application/vnd.epson.salt');\n",
        "insert into mimetype (extension, mimetype) values ('.fvt', 'video/vnd.fvt');\n",
        "insert into mimetype (extension, mimetype) values ('.vor', 'application/vnd.stardivision.writer');\n",
        "insert into mimetype (extension, mimetype) values ('.ics', 'text/calendar');\n",
        "insert into mimetype (extension, mimetype) values ('.o', 'application/x-object');\n",
        "insert into mimetype (extension, mimetype) values ('.cdt', 'image/x-coreldrawtemplate');\n",
        "insert into mimetype (extension, mimetype) values ('.ktr', 'application/vnd.kahootz');\n",
        "insert into mimetype (extension, mimetype) values ('.qps', 'application/vnd.publishare-delta-tree');\n",
        "insert into mimetype (extension, mimetype) values ('.ico', 'image/x-icon');\n",
        "insert into mimetype (extension, mimetype) values ('.sti', 'application/vnd.sun.xml.impress.template');\n",
        "insert into mimetype (extension, mimetype) values ('.uoml', 'application/vnd.uoml+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.ktz', 'application/vnd.kahootz');\n",
        "insert into mimetype (extension, mimetype) values ('.ice', 'x-conference/x-cooltalk');\n",
        "insert into mimetype (extension, mimetype) values ('.wbmp', 'image/vnd.wap.wbmp');\n",
        "insert into mimetype (extension, mimetype) values ('.in', 'text/plain');\n",
        "insert into mimetype (extension, mimetype) values ('.edm', 'application/vnd.novadigm.edm');\n",
        "insert into mimetype (extension, mimetype) values ('.mp4v', 'video/mp4');\n",
        "insert into mimetype (extension, mimetype) values ('.grv', 'application/vnd.groove-injector');\n",
        "insert into mimetype (extension, mimetype) values ('.list', 'text/plain');\n",
        "insert into mimetype (extension, mimetype) values ('.esf', 'application/vnd.epson.esf');\n",
        "insert into mimetype (extension, mimetype) values ('.abw', 'application/x-abiword');\n",
        "insert into mimetype (extension, mimetype) values ('.wspolicy', 'application/wspolicy+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.mpga', 'audio/mpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.pki', 'application/pkixcmp');\n",
        "insert into mimetype (extension, mimetype) values ('.hdf', 'application/x-hdf');\n",
        "insert into mimetype (extension, mimetype) values ('.davmount', 'application/davmount+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.xpdl', 'application/xml');\n",
        "insert into mimetype (extension, mimetype) values ('.pkg', 'application/octet-stream');\n",
        "insert into mimetype (extension, mimetype) values ('.zaz', 'application/vnd.zzazz.deck+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.wqd', 'application/vnd.wqd');\n",
        "insert into mimetype (extension, mimetype) values ('.log', 'text/plain');\n",
        "insert into mimetype (extension, mimetype) values ('.cxx', 'text/x-c++src');\n",
        "insert into mimetype (extension, mimetype) values ('.srx', 'application/sparql-results+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.box', 'application/vnd.previewsystems.box');\n",
        "insert into mimetype (extension, mimetype) values ('.boz', 'application/x-bzip2');\n",
        "insert into mimetype (extension, mimetype) values ('.vcs', 'text/x-vcalendar');\n",
        "insert into mimetype (extension, mimetype) values ('.oxt', 'application/vnd.openofficeorg.extension');\n",
        "insert into mimetype (extension, mimetype) values ('.pbd', 'application/vnd.powerbuilder6');\n",
        "insert into mimetype (extension, mimetype) values ('.bh2', 'application/vnd.fujitsu.oasysprs');\n",
        "insert into mimetype (extension, mimetype) values ('.h++', 'text/x-c++hdr');\n",
        "insert into mimetype (extension, mimetype) values ('.mpg4', 'video/mp4');\n",
        "insert into mimetype (extension, mimetype) values ('.psd', 'image/x-photoshop');\n",
        "insert into mimetype (extension, mimetype) values ('.gcd', 'text/x-pcs-gcd');\n",
        "insert into mimetype (extension, mimetype) values ('.pbm', 'image/x-portable-bitmap');\n",
        "insert into mimetype (extension, mimetype) values ('.gcf', 'application/x-graphing-calculator');\n",
        "insert into mimetype (extension, mimetype) values ('.es3', 'application/vnd.eszigno3+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.qbo', 'application/vnd.intu.qbo');\n",
        "insert into mimetype (extension, mimetype) values ('.vrml', 'x-world/x-vrml');\n",
        "insert into mimetype (extension, mimetype) values ('.msty', 'application/vnd.muvee.style');\n",
        "insert into mimetype (extension, mimetype) values ('.dtd', 'application/xml-dtd');\n",
        "insert into mimetype (extension, mimetype) values ('.gcg', 'chemical/x-gcg8-sequence');\n",
        "insert into mimetype (extension, mimetype) values ('.pclxl', 'application/vnd.hp-pclxl');\n",
        "insert into mimetype (extension, mimetype) values ('.xdp', 'application/vnd.adobe.xdp+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.apr', 'application/vnd.lotus-approach');\n",
        "insert into mimetype (extension, mimetype) values ('.mbk', 'application/vnd.mobius.mbk');\n",
        "insert into mimetype (extension, mimetype) values ('.cdxml', 'application/vnd.chemdraw+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.wpl', 'application/vnd.ms-wpl');\n",
        "insert into mimetype (extension, mimetype) values ('.kar', 'audio/midi');\n",
        "insert into mimetype (extension, mimetype) values ('.org', 'application/vnd.lotus-organizer');\n",
        "insert into mimetype (extension, mimetype) values ('.xslt', 'application/xslt+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.aiff', 'audio/x-aiff');\n",
        "insert into mimetype (extension, mimetype) values ('.vrm', 'x-world/x-vrml');\n",
        "insert into mimetype (extension, mimetype) values ('.aifc', 'audio/x-aiff');\n",
        "insert into mimetype (extension, mimetype) values ('.xdm', 'application/vnd.syncml.dm+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.gqf', 'application/vnd.grafeq');\n",
        "insert into mimetype (extension, mimetype) values ('.crt', 'application/x-x509-ca-cert');\n",
        "insert into mimetype (extension, mimetype) values ('.flx', 'text/vnd.fmi.flexstor');\n",
        "insert into mimetype (extension, mimetype) values ('.fly', 'text/vnd.fly');\n",
        "insert into mimetype (extension, mimetype) values ('.kne', 'application/vnd.kinar');\n",
        "insert into mimetype (extension, mimetype) values ('.edx', 'application/vnd.novadigm.edx');\n",
        "insert into mimetype (extension, mimetype) values ('.flv', 'video/x-flv');\n",
        "insert into mimetype (extension, mimetype) values ('.flw', 'application/vnd.kde.kivio');\n",
        "insert into mimetype (extension, mimetype) values ('.html', 'text/html');\n",
        "insert into mimetype (extension, mimetype) values ('.susp', 'application/vnd.sus-calendar');\n",
        "insert into mimetype (extension, mimetype) values ('.ez3', 'application/vnd.ezpix-package');\n",
        "insert into mimetype (extension, mimetype) values ('.knp', 'application/vnd.kinar');\n",
        "insert into mimetype (extension, mimetype) values ('.gqs', 'application/vnd.grafeq');\n",
        "insert into mimetype (extension, mimetype) values ('.hbci', 'application/vnd.hbci');\n",
        "insert into mimetype (extension, mimetype) values ('.ins', 'application/x-internet-signup');\n",
        "insert into mimetype (extension, mimetype) values ('.pkipath', 'application/pkix-pkipath');\n",
        "insert into mimetype (extension, mimetype) values ('.lzx', 'application/x-lzx');\n",
        "insert into mimetype (extension, mimetype) values ('.odc', 'application/vnd.oasis.opendocument.chart');\n",
        "insert into mimetype (extension, mimetype) values ('.nns', 'application/vnd.noblenet-sealer');\n",
        "insert into mimetype (extension, mimetype) values ('.ppt', 'application/vnd.ms-powerpoint');\n",
        "insert into mimetype (extension, mimetype) values ('.zmt', 'chemical/x-mopac-input');\n",
        "insert into mimetype (extension, mimetype) values ('.pps', 'application/vnd.ms-powerpoint');\n",
        "insert into mimetype (extension, mimetype) values ('.ppm', 'image/x-portable-pixmap');\n",
        "insert into mimetype (extension, mimetype) values ('.lzh', 'application/x-lzh');\n",
        "insert into mimetype (extension, mimetype) values ('.latex', 'application/x-latex');\n",
        "insert into mimetype (extension, mimetype) values ('.ppd', 'application/vnd.cups-ppd');\n",
        "insert into mimetype (extension, mimetype) values ('.cgm', 'image/cgm');\n",
        "insert into mimetype (extension, mimetype) values ('.ppa', 'application/vnd.ms-powerpoint');\n",
        "insert into mimetype (extension, mimetype) values ('.fpx', 'image/vnd.fpx');\n",
        "insert into mimetype (extension, mimetype) values ('.igl', 'application/vnd.igloader');\n",
        "insert into mimetype (extension, mimetype) values ('.mbox', 'application/mbox');\n",
        "insert into mimetype (extension, mimetype) values ('.frm', 'application/x-maker');\n",
        "insert into mimetype (extension, mimetype) values ('.kwt', 'application/x-kword');\n",
        "insert into mimetype (extension, mimetype) values ('.dcr', 'application/x-director');\n",
        "insert into mimetype (extension, mimetype) values ('.mp2a', 'audio/mpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.igx', 'application/vnd.micrografx.igx');\n",
        "insert into mimetype (extension, mimetype) values ('.kwd', 'application/x-kword');\n",
        "insert into mimetype (extension, mimetype) values ('.igs', 'model/iges');\n",
        "insert into mimetype (extension, mimetype) values ('.xdw', 'application/vnd.fujixerox.docuworks');\n",
        "insert into mimetype (extension, mimetype) values ('.qti', 'image/x-quicktime');\n",
        "insert into mimetype (extension, mimetype) values ('.jad', 'text/vnd.sun.j2me.app-descriptor');\n",
        "insert into mimetype (extension, mimetype) values ('.mwf', 'application/vnd.mfer');\n",
        "insert into mimetype (extension, mimetype) values ('.qtl', 'application/x-quicktimeplayer');\n",
        "insert into mimetype (extension, mimetype) values ('.npx', 'image/vnd.net-fpx');\n",
        "insert into mimetype (extension, mimetype) values ('.jam', 'application/vnd.jam');\n",
        "insert into mimetype (extension, mimetype) values ('.rlc', 'image/vnd.fujixerox.edmics-rlc');\n",
        "insert into mimetype (extension, mimetype) values ('.svgz', 'image/svg+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.bz2', 'application/x-bzip2');\n",
        "insert into mimetype (extension, mimetype) values ('.jar', 'application/java-archive');\n",
        "insert into mimetype (extension, mimetype) values ('.fch', 'chemical/x-gaussian-checkpoint');\n",
        "insert into mimetype (extension, mimetype) values ('.ogg', 'application/ogg');\n",
        "insert into mimetype (extension, mimetype) values ('.afp', 'application/vnd.ibm.modcap');\n",
        "insert into mimetype (extension, mimetype) values ('.f90', 'text/x-fortran');\n",
        "insert into mimetype (extension, mimetype) values ('.ms', 'application/x-troff-ms');\n",
        "insert into mimetype (extension, mimetype) values ('.rgb', 'image/x-rgb');\n",
        "insert into mimetype (extension, mimetype) values ('.mxl', 'application/vnd.recordare.musicxml');\n",
        "insert into mimetype (extension, mimetype) values ('.mxs', 'application/vnd.triscape.mxs');\n",
        "insert into mimetype (extension, mimetype) values ('.gram', 'application/srgs');\n",
        "insert into mimetype (extension, mimetype) values ('.me', 'application/x-troff-me');\n",
        "insert into mimetype (extension, mimetype) values ('.mb', 'application/mathematica');\n",
        "insert into mimetype (extension, mimetype) values ('.mxu', 'video/vnd.mpegurl');\n",
        "insert into mimetype (extension, mimetype) values ('.ma', 'application/mathematica');\n",
        "insert into mimetype (extension, mimetype) values ('.qam', 'application/vnd.epson.quickanime');\n",
        "insert into mimetype (extension, mimetype) values ('.mm', 'application/x-freemind');\n",
        "insert into mimetype (extension, mimetype) values ('.dl', 'video/dl');\n",
        "insert into mimetype (extension, mimetype) values ('.mesh', 'model/mesh');\n",
        "insert into mimetype (extension, mimetype) values ('.pgp', 'application/pgp-signature');\n",
        "insert into mimetype (extension, mimetype) values ('.pgn', 'application/x-chess-pgn');\n",
        "insert into mimetype (extension, mimetype) values ('.pgm', 'image/x-portable-graymap');\n",
        "insert into mimetype (extension, mimetype) values ('.xyz', 'chemical/x-xyz');\n",
        "insert into mimetype (extension, mimetype) values ('.svg', 'image/svg+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.svd', 'application/vnd.svd');\n",
        "insert into mimetype (extension, mimetype) values ('.atom', 'application/atom+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.dp', 'application/vnd.osgi.dp');\n",
        "insert into mimetype (extension, mimetype) values ('.roff', 'application/x-troff');\n",
        "insert into mimetype (extension, mimetype) values ('.unityweb', 'application/vnd.unity');\n",
        "insert into mimetype (extension, mimetype) values ('.123', 'application/vnd.lotus-1-2-3');\n",
        "insert into mimetype (extension, mimetype) values ('.dv', 'video/dv');\n",
        "insert into mimetype (extension, mimetype) values ('.cub', 'chemical/x-gaussian-cube');\n",
        "insert into mimetype (extension, mimetype) values ('.eol', 'audio/vnd.digital-winds');\n",
        "insert into mimetype (extension, mimetype) values ('.frame', 'application/x-maker');\n",
        "insert into mimetype (extension, mimetype) values ('.qtif', 'image/x-quicktime');\n",
        "insert into mimetype (extension, mimetype) values ('.eot', 'application/vnd.ms-fontobject');\n",
        "insert into mimetype (extension, mimetype) values ('.gau', 'chemical/x-gaussian-input');\n",
        "insert into mimetype (extension, mimetype) values ('.mac', 'image/x-macpaint');\n",
        "insert into mimetype (extension, mimetype) values ('.dat', 'chemical/x-mopac-input');\n",
        "insert into mimetype (extension, mimetype) values ('.mag', 'application/vnd.ecowin.chart');\n",
        "insert into mimetype (extension, mimetype) values ('.lsf', 'video/x-la-asf');\n",
        "insert into mimetype (extension, mimetype) values ('.iif', 'application/vnd.shana.informed.interchange');\n",
        "insert into mimetype (extension, mimetype) values ('.atx', 'application/vnd.antix.game-component');\n",
        "insert into mimetype (extension, mimetype) values ('.mmf', 'application/vnd.smaf');\n",
        "insert into mimetype (extension, mimetype) values ('.mny', 'application/x-msmoney');\n",
        "insert into mimetype (extension, mimetype) values ('.iii', 'application/x-iphone');\n",
        "insert into mimetype (extension, mimetype) values ('.pyo', 'application/x-python-code');\n",
        "insert into mimetype (extension, mimetype) values ('.ghf', 'application/vnd.groove-help');\n",
        "insert into mimetype (extension, mimetype) values ('.cpio', 'application/x-cpio');\n",
        "insert into mimetype (extension, mimetype) values ('.rdf', 'application/rdf+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.setreg', 'application/set-registration-initiation');\n",
        "insert into mimetype (extension, mimetype) values ('.atc', 'application/vnd.acucorp');\n",
        "insert into mimetype (extension, mimetype) values ('.lsx', 'video/x-la-asf');\n",
        "insert into mimetype (extension, mimetype) values ('.ecelp4800', 'audio/vnd.nuera.ecelp4800');\n",
        "insert into mimetype (extension, mimetype) values ('.sema', 'application/vnd.sema');\n",
        "insert into mimetype (extension, mimetype) values ('.val', 'chemical/x-ncbi-asn1-binary');\n",
        "insert into mimetype (extension, mimetype) values ('.dll', 'application/x-msdos-program');\n",
        "insert into mimetype (extension, mimetype) values ('.sd2', 'audio/x-sd2');\n",
        "insert into mimetype (extension, mimetype) values ('.rif', 'application/reginfo+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.sct', 'text/scriptlet');\n",
        "insert into mimetype (extension, mimetype) values ('.scq', 'application/scvp-cv-request');\n",
        "insert into mimetype (extension, mimetype) values ('.scs', 'application/scvp-cv-response');\n",
        "insert into mimetype (extension, mimetype) values ('.scm', 'application/vnd.lotus-screencam');\n",
        "insert into mimetype (extension, mimetype) values ('.xfdl', 'application/vnd.xfdl');\n",
        "insert into mimetype (extension, mimetype) values ('.scd', 'application/x-msschedule');\n",
        "insert into mimetype (extension, mimetype) values ('.xfdf', 'application/vnd.adobe.xfdf');\n",
        "insert into mimetype (extension, mimetype) values ('.xwd', 'image/x-xwindowdump');\n",
        "insert into mimetype (extension, mimetype) values ('.mif', 'application/x-mif');\n",
        "insert into mimetype (extension, mimetype) values ('.sda', 'application/vnd.stardivision.draw');\n",
        "insert into mimetype (extension, mimetype) values ('.sdc', 'application/vnd.stardivision.calc');\n",
        "insert into mimetype (extension, mimetype) values ('.sdd', 'application/vnd.stardivision.impress');\n",
        "insert into mimetype (extension, mimetype) values ('.sdf', 'chemical/x-mdl-sdfile');\n",
        "insert into mimetype (extension, mimetype) values ('.js', 'application/x-javascript');\n",
        "insert into mimetype (extension, mimetype) values ('.sdp', 'application/vnd.stardivision.impress');\n",
        "insert into mimetype (extension, mimetype) values ('.sdw', 'application/vnd.stardivision.writer');\n",
        "insert into mimetype (extension, mimetype) values ('.plb', 'application/vnd.3gpp.pic-bw-large');\n",
        "insert into mimetype (extension, mimetype) values ('.plc', 'application/vnd.mobius.plc');\n",
        "insert into mimetype (extension, mimetype) values ('.ipk', 'application/vnd.shana.informed.package');\n",
        "insert into mimetype (extension, mimetype) values ('.%', 'application/x-trash');\n",
        "insert into mimetype (extension, mimetype) values ('.3dml', 'text/vnd.in3d.3dml');\n",
        "insert into mimetype (extension, mimetype) values ('.qxt', 'application/vnd.quark.quarkxpress');\n",
        "insert into mimetype (extension, mimetype) values ('.n-gage', 'application/vnd.nokia.n-gage.symbian.install');\n",
        "insert into mimetype (extension, mimetype) values ('.wtb', 'application/vnd.webturbo');\n",
        "insert into mimetype (extension, mimetype) values ('.msf', 'application/vnd.epson.msf');\n",
        "insert into mimetype (extension, mimetype) values ('.pls', 'audio/x-scpls');\n",
        "insert into mimetype (extension, mimetype) values ('.flo', 'application/vnd.micrografx.flo');\n",
        "insert into mimetype (extension, mimetype) values ('.tgf', 'chemical/x-mdl-tgf');\n",
        "insert into mimetype (extension, mimetype) values ('.tgz', 'application/x-gtar');\n",
        "insert into mimetype (extension, mimetype) values ('.gz', 'application/x-gzip');\n",
        "insert into mimetype (extension, mimetype) values ('.lhs', 'text/x-literate-haskell');\n",
        "insert into mimetype (extension, mimetype) values ('.msl', 'application/vnd.mobius.msl');\n",
        "insert into mimetype (extension, mimetype) values ('.qxd', 'application/vnd.quark.quarkxpress');\n",
        "insert into mimetype (extension, mimetype) values ('.qxb', 'application/vnd.quark.quarkxpress');\n",
        "insert into mimetype (extension, mimetype) values ('.msh', 'model/mesh');\n",
        "insert into mimetype (extension, mimetype) values ('.fli', 'video/fli');\n",
        "insert into mimetype (extension, mimetype) values ('.lha', 'application/x-lha');\n",
        "insert into mimetype (extension, mimetype) values ('.cpa', 'chemical/x-compass');\n",
        "insert into mimetype (extension, mimetype) values ('.au', 'audio/basic');\n",
        "insert into mimetype (extension, mimetype) values ('.pcl', 'application/vnd.hp-pcl');\n",
        "insert into mimetype (extension, mimetype) values ('.cpt', 'image/x-corelphotopaint');\n",
        "insert into mimetype (extension, mimetype) values ('.jpg', 'image/jpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.mdb', 'application/msaccess');\n",
        "insert into mimetype (extension, mimetype) values ('.pct', 'image/x-pict');\n",
        "insert into mimetype (extension, mimetype) values ('.jpm', 'video/jpm');\n",
        "insert into mimetype (extension, mimetype) values ('.mpega', 'audio/mpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.pcx', 'image/pcx');\n",
        "insert into mimetype (extension, mimetype) values ('.mdi', 'image/vnd.ms-modi');\n",
        "insert into mimetype (extension, mimetype) values ('.zip', 'application/zip');\n",
        "insert into mimetype (extension, mimetype) values ('.xtel', 'chemical/x-xtel');\n",
        "insert into mimetype (extension, mimetype) values ('.vss', 'application/vnd.visio');\n",
        "insert into mimetype (extension, mimetype) values ('.m3u', 'audio/x-mpegurl');\n",
        "insert into mimetype (extension, mimetype) values ('.clkk', 'application/vnd.crick.clicker.keyboard');\n",
        "insert into mimetype (extension, mimetype) values ('.vst', 'application/vnd.visio');\n",
        "insert into mimetype (extension, mimetype) values ('.vsw', 'application/vnd.visio');\n",
        "insert into mimetype (extension, mimetype) values ('.class', 'application/java-vm');\n",
        "insert into mimetype (extension, mimetype) values ('.torrent', 'application/x-bittorrent');\n",
        "insert into mimetype (extension, mimetype) values ('.hlp', 'application/winhlp');\n",
        "insert into mimetype (extension, mimetype) values ('.mj2', 'video/mj2');\n",
        "insert into mimetype (extension, mimetype) values ('.m3a', 'audio/mpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.asc', 'text/plain');\n",
        "insert into mimetype (extension, mimetype) values ('.qxl', 'application/vnd.quark.quarkxpress');\n",
        "insert into mimetype (extension, mimetype) values ('.asf', 'video/x-ms-asf');\n",
        "insert into mimetype (extension, mimetype) values ('.vsd', 'application/vnd.visio');\n",
        "insert into mimetype (extension, mimetype) values ('.vsf', 'application/vnd.vsf');\n",
        "insert into mimetype (extension, mimetype) values ('.clkw', 'application/vnd.crick.clicker.wordbank');\n",
        "insert into mimetype (extension, mimetype) values ('.xo', 'application/vnd.olpc-sugar');\n",
        "insert into mimetype (extension, mimetype) values ('.clkt', 'application/vnd.crick.clicker.template');\n",
        "insert into mimetype (extension, mimetype) values ('.asn', 'chemical/x-ncbi-asn1-spec');\n",
        "insert into mimetype (extension, mimetype) values ('.aso', 'chemical/x-ncbi-asn1-binary');\n",
        "insert into mimetype (extension, mimetype) values ('.mmr', 'image/vnd.fujixerox.edmics-mmr');\n",
        "insert into mimetype (extension, mimetype) values ('.asm', 'text/x-asm');\n",
        "insert into mimetype (extension, mimetype) values ('.uri', 'text/uri-list');\n",
        "insert into mimetype (extension, mimetype) values ('.jp2', 'image/jp2');\n",
        "insert into mimetype (extension, mimetype) values ('.xlm', 'application/vnd.ms-excel');\n",
        "insert into mimetype (extension, mimetype) values ('.xlb', 'application/vnd.ms-excel');\n",
        "insert into mimetype (extension, mimetype) values ('.xlc', 'application/vnd.ms-excel');\n",
        "insert into mimetype (extension, mimetype) values ('.tcap', 'application/vnd.3gpp2.tcap');\n",
        "insert into mimetype (extension, mimetype) values ('.sd', 'chemical/x-mdl-sdfile');\n",
        "insert into mimetype (extension, mimetype) values ('.cif', 'chemical/x-cif');\n",
        "insert into mimetype (extension, mimetype) values ('.wz', 'application/x-wingz');\n",
        "insert into mimetype (extension, mimetype) values ('.xls', 'application/vnd.ms-excel');\n",
        "insert into mimetype (extension, mimetype) values ('.cii', 'application/vnd.anser-web-certificate-issue-initiation');\n",
        "insert into mimetype (extension, mimetype) values ('.xlw', 'application/vnd.ms-excel');\n",
        "insert into mimetype (extension, mimetype) values ('.xlt', 'application/vnd.ms-excel');\n",
        "insert into mimetype (extension, mimetype) values ('.fb', 'application/x-maker');\n",
        "insert into mimetype (extension, mimetype) values ('.3gp', 'video/3gpp');\n",
        "insert into mimetype (extension, mimetype) values ('.wks', 'application/vnd.ms-works');\n",
        "insert into mimetype (extension, mimetype) values ('.wmv', 'video/x-ms-wmv');\n",
        "insert into mimetype (extension, mimetype) values ('.gtw', 'model/vnd.gtw');\n",
        "insert into mimetype (extension, mimetype) values ('.dx', 'chemical/x-jcamp-dx');\n",
        "insert into mimetype (extension, mimetype) values ('.gtm', 'application/vnd.groove-tool-message');\n",
        "insert into mimetype (extension, mimetype) values ('.trm', 'application/x-msterminal');\n",
        "insert into mimetype (extension, mimetype) values ('.kin', 'chemical/x-kinemage');\n",
        "insert into mimetype (extension, mimetype) values ('.urls', 'text/uri-list');\n",
        "insert into mimetype (extension, mimetype) values ('.kil', 'application/x-killustrator');\n",
        "insert into mimetype (extension, mimetype) values ('.pub', 'application/x-mspublisher');\n",
        "insert into mimetype (extension, mimetype) values ('.imp', 'application/vnd.accpac.simply.imp');\n",
        "insert into mimetype (extension, mimetype) values ('.lwp', 'application/vnd.lotus-wordpro');\n",
        "insert into mimetype (extension, mimetype) values ('.odf', 'application/vnd.oasis.opendocument.formula');\n",
        "insert into mimetype (extension, mimetype) values ('.tra', 'application/vnd.trueapp');\n",
        "insert into mimetype (extension, mimetype) values ('.fsc', 'application/vnd.fsc.weblaunch');\n",
        "insert into mimetype (extension, mimetype) values ('.ifm', 'application/vnd.shana.informed.formdata');\n",
        "insert into mimetype (extension, mimetype) values ('.mpt', 'application/vnd.ms-project');\n",
        "insert into mimetype (extension, mimetype) values ('.sgf', 'application/x-go-sgf');\n",
        "insert into mimetype (extension, mimetype) values ('.ifb', 'text/calendar');\n",
        "insert into mimetype (extension, mimetype) values ('.sgl', 'application/vnd.stardivision.writer-global');\n",
        "insert into mimetype (extension, mimetype) values ('.sgm', 'text/sgml');\n",
        "insert into mimetype (extension, mimetype) values ('.lbd', 'application/vnd.llamagraphics.life-balance.desktop');\n",
        "insert into mimetype (extension, mimetype) values ('.lbe', 'application/vnd.llamagraphics.life-balance.exchange+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.maker', 'application/x-maker');\n",
        "insert into mimetype (extension, mimetype) values ('.fst', 'image/vnd.fst');\n",
        "insert into mimetype (extension, mimetype) values ('.mcm', 'chemical/x-macmolecule');\n",
        "insert into mimetype (extension, mimetype) values ('.tif', 'image/tiff');\n",
        "insert into mimetype (extension, mimetype) values ('.otp', 'application/vnd.oasis.opendocument.presentation-template');\n",
        "insert into mimetype (extension, mimetype) values ('.pcf', 'application/x-font');\n",
        "insert into mimetype (extension, mimetype) values ('.rmi', 'audio/midi');\n",
        "insert into mimetype (extension, mimetype) values ('.wp5', 'application/wordperfect5.1');\n",
        "insert into mimetype (extension, mimetype) values ('.f77', 'text/x-fortran');\n",
        "insert into mimetype (extension, mimetype) values ('.pic', 'image/x-pict');\n",
        "insert into mimetype (extension, mimetype) values ('.cache', 'chemical/x-cache');\n",
        "insert into mimetype (extension, mimetype) values ('.mvb', 'chemical/x-mopac-vib');\n",
        "insert into mimetype (extension, mimetype) values ('.qwd', 'application/vnd.quark.quarkxpress');\n",
        "insert into mimetype (extension, mimetype) values ('.ngdat', 'application/vnd.nokia.n-gage.data');\n",
        "insert into mimetype (extension, mimetype) values ('.rmp', 'audio/x-pn-realaudio-plugin');\n",
        "insert into mimetype (extension, mimetype) values ('.wk', 'application/x-123');\n",
        "insert into mimetype (extension, mimetype) values ('.acutc', 'application/vnd.acucorp');\n",
        "insert into mimetype (extension, mimetype) values ('.xsm', 'application/vnd.syncml+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.xsl', 'application/xml');\n",
        "insert into mimetype (extension, mimetype) values ('.sxw', 'application/vnd.sun.xml.writer');\n",
        "insert into mimetype (extension, mimetype) values ('.spot', 'text/vnd.in3d.spot');\n",
        "insert into mimetype (extension, mimetype) values ('.nc', 'application/x-netcdf');\n",
        "insert into mimetype (extension, mimetype) values ('.fzs', 'application/vnd.fuzzysheet');\n",
        "insert into mimetype (extension, mimetype) values ('.sxm', 'application/vnd.sun.xml.math');\n",
        "insert into mimetype (extension, mimetype) values ('.mseq', 'application/vnd.mseq');\n",
        "insert into mimetype (extension, mimetype) values ('.sxi', 'application/vnd.sun.xml.impress');\n",
        "insert into mimetype (extension, mimetype) values ('.bib', 'text/x-bibtex');\n",
        "insert into mimetype (extension, mimetype) values ('.aep', 'application/vnd.audiograph');\n",
        "insert into mimetype (extension, mimetype) values ('.bin', 'application/octet-stream');\n",
        "insert into mimetype (extension, mimetype) values ('.rdz', 'application/vnd.data-vision.rdz');\n",
        "insert into mimetype (extension, mimetype) values ('.pcf.Z', 'application/x-font');\n",
        "insert into mimetype (extension, mimetype) values ('.uris', 'text/uri-list');\n",
        "insert into mimetype (extension, mimetype) values ('.sxc', 'application/vnd.sun.xml.calc');\n",
        "insert into mimetype (extension, mimetype) values ('.h', 'text/x-chdr');\n",
        "insert into mimetype (extension, mimetype) values ('.wps', 'application/vnd.ms-works');\n",
        "insert into mimetype (extension, mimetype) values ('.itp', 'application/vnd.shana.informed.formtemplate');\n",
        "insert into mimetype (extension, mimetype) values ('.jpe', 'image/jpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.a', 'application/octet-stream');\n",
        "insert into mimetype (extension, mimetype) values ('.b', 'chemical/x-molconn-Z');\n",
        "insert into mimetype (extension, mimetype) values ('.c', 'text/x-csrc');\n",
        "insert into mimetype (extension, mimetype) values ('.rcprofile', 'application/vnd.ipunplugged.rcprofile');\n",
        "insert into mimetype (extension, mimetype) values ('.udeb', 'application/x-debian-package');\n",
        "insert into mimetype (extension, mimetype) values ('.f', 'text/x-fortran');\n",
        "insert into mimetype (extension, mimetype) values ('.fe_launch', 'application/vnd.denovo.fcselayout-link');\n",
        "insert into mimetype (extension, mimetype) values ('.vtu', 'model/vnd.vtu');\n",
        "insert into mimetype (extension, mimetype) values ('.wpd', 'application/wordperfect');\n",
        "insert into mimetype (extension, mimetype) values ('.~', 'application/x-trash');\n",
        "insert into mimetype (extension, mimetype) values ('.mxml', 'application/xv+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.p', 'text/x-pascal');\n",
        "insert into mimetype (extension, mimetype) values ('.s', 'text/x-asm');\n",
        "insert into mimetype (extension, mimetype) values ('.t', 'application/x-troff');\n",
        "insert into mimetype (extension, mimetype) values ('.ai', 'application/postscript');\n",
        "insert into mimetype (extension, mimetype) values ('.cpp', 'text/x-c++src');\n",
        "insert into mimetype (extension, mimetype) values ('.xenc', 'application/xenc+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.btif', 'image/prs.btif');\n",
        "insert into mimetype (extension, mimetype) values ('.gnumeric', 'application/x-gnumeric');\n",
        "insert into mimetype (extension, mimetype) values ('.kia', 'application/vnd.kidspiration');\n",
        "insert into mimetype (extension, mimetype) values ('.conf', 'text/plain');\n",
        "insert into mimetype (extension, mimetype) values ('.xvml', 'application/xv+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.x3d', 'application/vnd.hzn-3d-crossword');\n",
        "insert into mimetype (extension, mimetype) values ('.mol2', 'chemical/x-mol2');\n",
        "insert into mimetype (extension, mimetype) values ('.ctx', 'chemical/x-ctx');\n",
        "insert into mimetype (extension, mimetype) values ('.xar', 'application/vnd.xara');\n",
        "insert into mimetype (extension, mimetype) values ('.ent', 'chemical/x-pdb');\n",
        "insert into mimetype (extension, mimetype) values ('.zmm', 'application/vnd.handheld-entertainment+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.sv4crc', 'application/x-sv4crc');\n",
        "insert into mimetype (extension, mimetype) values ('.cmc', 'application/vnd.cosmocaller');\n",
        "insert into mimetype (extension, mimetype) values ('.cml', 'chemical/x-cml');\n",
        "insert into mimetype (extension, mimetype) values ('.pvb', 'application/vnd.3gpp.pic-bw-var');\n",
        "insert into mimetype (extension, mimetype) values ('.jpeg', 'image/jpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.mgz', 'application/vnd.proteus.magazine');\n",
        "insert into mimetype (extension, mimetype) values ('.mid', 'audio/midi');\n",
        "insert into mimetype (extension, mimetype) values ('.cmp', 'application/vnd.yellowriver-custom-menu');\n",
        "insert into mimetype (extension, mimetype) values ('.chat', 'application/x-chat');\n",
        "insert into mimetype (extension, mimetype) values ('.cmx', 'image/x-cmx');\n",
        "insert into mimetype (extension, mimetype) values ('.mml', 'text/mathml');\n",
        "insert into mimetype (extension, mimetype) values ('.kml', 'application/vnd.google-earth.kml+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.dump', 'application/octet-stream');\n",
        "insert into mimetype (extension, mimetype) values ('.gph', 'application/vnd.flographit');\n",
        "insert into mimetype (extension, mimetype) values ('.xht', 'application/xhtml+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.dif', 'video/dv');\n",
        "insert into mimetype (extension, mimetype) values ('.grxml', 'application/srgs+xml');\n",
        "insert into mimetype (extension, mimetype) values ('.dic', 'text/x-c');\n",
        "insert into mimetype (extension, mimetype) values ('.kmz', 'application/vnd.google-earth.kmz');\n",
        "insert into mimetype (extension, mimetype) values ('.gpt', 'chemical/x-mopac-graph');\n",
        "insert into mimetype (extension, mimetype) values ('.wm', 'video/x-ms-wm');\n",
        "insert into mimetype (extension, mimetype) values ('.dis', 'application/vnd.mobius.dis');\n",
        "insert into mimetype (extension, mimetype) values ('.dir', 'application/x-director');\n",
        "insert into mimetype (extension, mimetype) values ('.curl', 'application/vnd.curl');\n",
        "insert into mimetype (extension, mimetype) values ('.setpay', 'application/set-payment-initiation');\n",
        "insert into mimetype (extension, mimetype) values ('.cod', 'application/vnd.rim.cod');\n",
        "insert into mimetype (extension, mimetype) values ('.vmd', 'chemical/x-vmd');\n",
        "insert into mimetype (extension, mimetype) values ('.jpgm', 'video/jpm');\n",
        "insert into mimetype (extension, mimetype) values ('.snd', 'audio/basic');\n",
        "insert into mimetype (extension, mimetype) values ('.mmd', 'chemical/x-macromodel-input');\n",
        "insert into mimetype (extension, mimetype) values ('.pict', 'image/pict');\n",
        "insert into mimetype (extension, mimetype) values ('.jpgv', 'video/jpeg');\n",
        "insert into mimetype (extension, mimetype) values ('.ftc', 'application/vnd.fluxtime.clip');\n",
        "insert into mimetype (extension, mimetype) values ('.pqa', 'application/vnd.palm');\n",
        "insert into mimetype (extension, mimetype) values ('.java', 'text/x-java');\n",
        "insert into mimetype (extension, mimetype) values ('.apk', 'application/vnd.android.package-archive');\n",
        "insert into mimetype (extension, mimetype) values ('.vms', 'chemical/x-vamas-iso14976');\n",
        "insert into mimetype (extension, mimetype) values ('.asx', 'video/x-ms-asf');\n",
    }


local CONFIG_SCHEMA = "BEGIN TRANSACTION;"..
        "DROP TABLE IF EXISTS server;\n" ..
        "DROP TABLE IF EXISTS host;\n" ..
        "DROP TABLE IF EXISTS handler;\n" ..
        "DROP TABLE IF EXISTS proxy;\n" ..
        "DROP TABLE IF EXISTS route;\n" ..
        "DROP TABLE IF EXISTS statistic;\n" ..
        "DROP TABLE IF EXISTS mimetype;\n" ..
        "DROP TABLE IF EXISTS setting;\n" ..
        "DROP TABLE IF EXISTS directory;\n" ..
        "\n" ..
        "CREATE TABLE server (id INTEGER PRIMARY KEY,\n" ..
        "    uuid TEXT,\n" ..
        "    access_log TEXT,\n" ..
        "    error_log TEXT,\n" ..
        "    chroot TEXT DEFAULT '/var/www',\n" ..
        "    pid_file TEXT,\n" ..
        "    default_host TEXT,\n" ..
        "    name TEXT DEFAULT '',\n" ..
        "    bind_addr TEXT DEFAULT \"0.0.0.0\",\n" ..
        "    port INTEGER,\n" ..
        "    use_ssl INTEGER default 0);\n" ..
        "\n" ..
        "CREATE TABLE host (id INTEGER PRIMARY KEY, \n" ..
        "    server_id INTEGER,\n" ..
        "    maintenance BOOLEAN DEFAULT 0,\n" ..
        "    name TEXT,\n" ..
        "    matching TEXT);\n" ..
        "\n" ..
        "CREATE TABLE handler (id INTEGER PRIMARY KEY,\n" ..
        "    send_spec TEXT, \n" ..
        "    send_ident TEXT,\n" ..
        "    recv_spec TEXT,\n" ..
        "    recv_ident TEXT,\n" ..
        "   raw_payload INTEGER DEFAULT 0,\n" ..
        "   protocol TEXT DEFAULT 'json');\n" ..
        "\n" ..
        "CREATE TABLE proxy (id INTEGER PRIMARY KEY,\n" ..
        "    addr TEXT,\n" ..
        "    port INTEGER);\n" ..
        "\n" ..
        "CREATE TABLE directory (id INTEGER PRIMARY KEY," ..
        "   base TEXT," ..
        "   index_file TEXT," ..
        "   default_ctype TEXT," ..
        "   cache_ttl INTEGER DEFAULT 0);" ..
        "\n" ..
        "CREATE TABLE route (id INTEGER PRIMARY KEY,\n" ..
        "    path TEXT,\n" ..
        "    reversed BOOLEAN DEFAULT 0,\n" ..
        "    host_id INTEGER,\n" ..
        "    target_id INTEGER,\n" ..
        "    target_type TEXT);\n" ..
        "\n" ..
        "CREATE TABLE setting (id INTEGER PRIMARY KEY, key TEXT, value TEXT);\n" ..
        "\n" ..
        "CREATE TABLE statistic (id SERIAL, \n" ..
        "    other_type TEXT,\n" ..
        "    other_id INTEGER,\n" ..
        "    name text,\n" ..
        "    sum REAL,\n" ..
        "    sumsq REAL,\n" ..
        "    n INTEGER,\n" ..
        "    min REAL,\n" ..
        "    max REAL,\n" ..
        "    mean REAL,\n" ..
        "    sd REAL,\n" ..
        "    primary key (other_type, other_id, name));\n" ..
        "\n" ..
        "CREATE TABLE mimetype (id INTEGER PRIMARY KEY, mimetype TEXT, extension TEXT);\n" ..
        "\n" ..
        "CREATE TABLE IF NOT EXISTS log(id INTEGER PRIMARY KEY,\n" ..
        "    who TEXT,\n" ..
        "    what TEXT,\n" ..
        "    location TEXT,\n" ..
        "    happened_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\n" ..
        "    how TEXT,\n" ..
        "    why TEXT);\n" ..
        "END TRANSACTION"


local SERVER_SQL = "INSERT INTO server (uuid, access_log, error_log, pid_file, chroot, default_host, name, bind_addr, port, use_ssl) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', %d, %d);";
local HOST_SQL = "INSERT INTO host (server_id, name, matching) VALUES (%d, '%s', '%s');";
local SETTING_SQL = "INSERT INTO setting (key, value) VALUES ('%s', '%s');";
local MIMETYPE_SQL = "DELETE from mimetype where extension='%s'; INSERT INTO mimetype (extension, mimetype) VALUES ('%s', '%s');";

local DIR_SQL = "INSERT INTO directory (base, index_file, default_ctype) VALUES ('%s', '%s', '%s');";
local DIR_CACHE_TTL_SQL = "UPDATE directory SET cache_ttl=%d WHERE id=last_insert_rowid();";

local PROXY_SQL = "INSERT INTO proxy (addr, port) VALUES ('%s', %d);";

local HANDLER_SQL = "INSERT INTO handler (send_spec, send_ident, recv_spec, recv_ident) VALUES ('%s', '%s', '%s', '%s');";

local ROUTE_SQL = "INSERT INTO route (path, host_id, target_id, target_type) VALUES ('%s', %d, %d, '%s');";

local HANDLER_RAW_SQL = "UPDATE handler SET raw_payload=1 WHERE id=last_insert_rowid();";
local HANDLER_PROTOCOL_SQL = "UPDATE handler SET protocol='%s' WHERE id=last_insert_rowid();";


local hid = -1 ; --host id
local sid = -1 ;--server id

function sql_insert_and_last_id(db,insertStr, name)
    db:exec(insertStr);
    local flag, t = pcall(db:rows("SELECT MAX(id) from ".. name ..";"));
    if flag then 
        return t[1];
    else
        return -1;
    end
end

function load_server(server,db)
    local bind_addr     = server["bind_addr"] or "0.0.0.0";
    local uuid          = server["uuid"] or "";
    local access_log    = server["access_log"] or "";
    local error_log     = server["error_log"] or "";
    local chroot        = server["chroot"] or "";
    local pid_file      = server["pid_file"] or "";
    local default_host  = server["default_host"] or "";
    local name          = server["name"] or "";
    local port          = server["port"] or 6767;
    local use_ssl       = server["use_ssl"] or 0;

    print("load server [" .. name .. "]");
    local str = string.format(SERVER_SQL,uuid,access_log,error_log,pid_file,
                        chroot,default_host,name,bind_addr,port,use_ssl);
    sid = sql_insert_and_last_id(db,str,'server');

    for i,v in ipairs(server.hosts) do 
        load_host(v, db, sid);
    end
end

function load_host(host,db,sid)
    local name = host.name;
    local matching = host.matching;
    hid = sql_insert_and_last_id(db,string.format(HOST_SQL,sid,name,matching),'host');
    
    for k,v in pairs(host.routes) do
       local rc = -1;
       if v['type'] == "dir" then
           rc = load_dir(v,db);
       elseif v['type'] == "handler" then
           rc = load_handler(v,db);
       elseif v["type"] == "proxy" then 
           rc = load_proxy(v,db);
       else
           print("[ERROR]:unknown route type[" .. v['type'] .. "]");
       end

        --route
        local str = string.format(ROUTE_SQL,k,hid,rc,v['type'])
        db:exec(str);
    end

end

function load_dir(dir,db)
    local base = dir['base'] or "";
    local index_file = dir['index_file'] or '';
    local default_ctype = dir['default_ctype'] or ''

    local str = string.format(DIR_SQL,base,index_file,default_ctype);
    return sql_insert_and_last_id(db,str,'directory');
end

function load_handler(handler,db)
    local send_spec = handler["send_spec"] or "";
    local send_ident = handler["send_ident"] or "";
    local recv_spec = handler['recv_spec'] or "";
    local recv_ident = handler["recv_ident"] or '';

    local str =string.format(HANDLER_SQL,send_spec,send_ident,recv_spec,recv_ident);
    return sql_insert_and_last_id(db,str,'handler');
end

function load_proxy(proxy,db)
    local str = string.format(PROXY_SQL,proxy.addr,proxy.port);
    return sql_insert_and_last_id(db,str,'proxy');
end

function import_mimetypes(db)
    local str = "BEGIN TRANSACTION; \n"
    for i,v in ipairs(MIMETYPES_DEFAULT_SQL) do 
        str = str .. v;
    end
    str = str .. "END TRANSACTION";
    db:exec(str);
end

--function load_mimetypes(mime, db)
--    db:exec(string.format(MIMETYPE_SQL, mime.ext, mime.ext, mime.data));
--end


function load_settings(settings, db)
    for k,v in pairs(settings) do 
        db:exec(string.format(SETTING_SQL,k,v));
    end
end

function main(config,sqlite)
    local db = sqlite3.open(sqlite)
    db:exec(CONFIG_SCHEMA);
    dofile(config);
    
    for i,v in ipairs(servers) do
        load_server(v,db);     
    end

    load_settings(settings, db);


    import_mimetypes(db);
    
    db:close();
    return "load config success";
end

