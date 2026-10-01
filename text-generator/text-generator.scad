/*
    OpenSCAD 3D Text Generator — Nightly v2
    ----------------------------------------
    Requires an OpenSCAD Development Snapshot / Nightly with:
      - textmetrics()
      - fontmetrics()

    Main improvements over the original:
      * Real text bounding boxes via textmetrics()
      * Real multi-line layout (up to 5 Customizer-friendly lines)
      * Functional left/center/right line alignment
      * Optional true mm-based character tracking (no text(spacing!=1))
      * Automatic line spacing from fontmetrics().interline
      * Base sizing/placement based on actual rendered glyph extents
      * Auto rounded rectangular sign and automatically positioned stand
      * Separate engraving depth, safety floor and through-cut option
      * Optional chamfer on engraved text as well as embossed text
      * Correct upright placement on Z=0 using measured geometry
      * Diagnostics for requested/resolved font and model dimensions

    Units: millimetres unless otherwise stated.
*/

/* [Tekst] */
// Første tekstlinje
Tekst = "3D PRINT";
// Ekstra linjer. Tom streng = linjen ignoreres.
Linje_2 = "";
Linje_3 = "";
Linje_4 = "";
Linje_5 = "";

// Skrifttypens familienavn, som vist i OpenSCAD Font List
Font_Navn = "Impact";
// Skrifttype-stil
Font_Stil = "Regular"; // ["Regular", "Bold", "Italic", "Bold Italic"]
// Nominel fontstørrelse
Tekst_Stoerrelse = 30; // [5:1:200]
// Dybde/højde på embossed eller fritstående tekst
Tekst_Dybde = 5; // [0.5:0.5:50]

// Ekstra afstand MELLEM tegn i mm. 0 bruger fontens normale shaping/kerning.
// Når værdien er forskellig fra 0, placeres glyffer individuelt for forudsigelig fysisk tracking.
Bogstav_Afstand_mm = 0; // [-2:0.1:10]

// Baseline-afstand mellem linjer som faktor af fontens designede interline.
Linje_Afstand = 1.0; // [0.5:0.05:3]

// Justering af linjer inden for den bredeste tekstlinje
Justering = "center"; // ["left", "center", "right"]

// Sprog/script sendes videre til OpenSCADs tekst-shaping
Sprog = "en";
Script = "latin";

/* [Base & Bagplade] */
// 0: Ingen, 1: Boble/outline, 2: Konveks hull, 3: Rektangulært skilt, 4: Stand/plint under teksten
Base_Type = 2; // [0, 1, 2, 3, 4]

// 0: Embossed, 1: Engraved
Print_Mode = 0; // [0, 1]

// Margin omkring tekst for base type 1/2 og ved auto-dimensionering
Base_Margin = 6; // [0:0.5:50]
// Basens tykkelse
Base_Dybde = 3; // [0.5:0.5:50]

/* [Rektangulært skilt - Type 3] */
// Automatisk størrelse efter tekstens faktiske bounding box
Rektangel_Auto = true;
// Manuelle dimensioner bruges når Rektangel_Auto = false
Manuel_Base_Bredde = 150; // [10:1:400]
Manuel_Base_Hoejde = 50; // [10:1:300]
// Vertikal forskydning af rektanglet
Manuel_Base_Y_Forskydning = 0; // [-100:1:100]
// Radius på skiltets hjørner
Base_Hjoerne_Radius = 3; // [0:0.5:30]

/* [Stand / plint - Type 4] */
// Automatisk bredde efter teksten
Stand_Auto_Bredde = true;
// Bruges som bredde hvis Stand_Auto_Bredde = false
Stand_Bredde = 150; // [10:1:400]
// Plintens højde i modellens 2D-plan
Stand_Hoejde = 12; // [2:0.5:100]
// Hvor meget plinten overlapper tekstens nederste del for sikker union
Stand_Overlap = 2.0; // [0.2:0.2:20]
// Ekstra Y-forskydning af plinten
Stand_Y_Forskydning = 0; // [-50:0.5:50]
// Afrunding på plinten
Stand_Hjoerne_Radius = 2; // [0:0.5:20]

/* [Embossed Bevel] */
// Top-chamfer på embossed/fritstående tekst. 0 = fra.
Bevel_Tykkelse = 0.8; // [0:0.1:5]
// Antal stepped offset-lag
Bevel_Trin = 4; // [1:1:16]

/* [Engraving] */
// Faktisk graveringsdybde. Uafhængig af Tekst_Dybde.
Graverings_Dybde = 1.2; // [0.1:0.1:20]
// false = behold minimum bundtykkelse, true = skær helt igennem basen
Gravering_Gennem = false;
// Sikker bundtykkelse når Gravering_Gennem = false
Minimum_Bundtykkelse = 0.8; // [0:0.1:10]
// Chamfer omkring graveringsåbningen. 0 = lodrette kanter.
Gravering_Bevel = 0.4; // [0:0.1:5]
Gravering_Bevel_Trin = 3; // [1:1:16]

/* [Effekter & Orientering] */
// Falsk italic via shear i grader
Shear_Vinkel = 0; // [-45:1:45]
// 0 = fladt, 1 = stående med nederste målte kant præcist på Z=0
Orientering = 1; // [0, 1]

/* [Kvalitet & System] */
// Kurveopløsning for tekst og afrundinger
Kurve_Oploesning = 64; // [12:4:160]
// Lille overlap/tolerance mod coplanar/non-manifold geometri
Epsilon = 0.02; // [0.005:0.005:0.1]
// Vis diagnostiske echo()-linjer i konsollen
Diagnostik = true;

$fn = Kurve_Oploesning;

// -----------------------------------------------------------------------------
// NIGHTLY METRICS & HJÆLPEFUNKTIONER
// -----------------------------------------------------------------------------

_Fuld_Font = str(Font_Navn, ":style=", Font_Stil);
_Linjer_Raa = [for (s = [Tekst, Linje_2, Linje_3, Linje_4, Linje_5]) if (s != "") s];
// Sørger for defineret geometri/metrics selv hvis alle tekstfelter tømmes.
_Linjer = len(_Linjer_Raa) > 0 ? _Linjer_Raa : [" "];
_FontMetrics = fontmetrics(size = Tekst_Stoerrelse, font = _Fuld_Font);

function _tm(s) = textmetrics(
    text = s,
    size = Tekst_Stoerrelse,
    font = _Fuld_Font,
    halign = "left",
    valign = "baseline",
    spacing = 1,
    direction = "ltr",
    language = Sprog,
    script = Script
);

// Position af tegn nr. i ved ægte fysisk tracking.
// Hvert tegn placeres efter forrige tegns advance + Bogstav_Afstand_mm.
function _glyph_x(s, i) =
    i <= 0 ? 0 :
    _glyph_x(s, i - 1) + _tm(s[i - 1]).advance.x + Bogstav_Afstand_mm;

function _glyph_bbox(s, i) =
    let(t = _tm(s[i]), x = _glyph_x(s, i))
    [
        x + t.position.x,
        t.position.y,
        x + t.position.x + t.size.x,
        t.position.y + t.size.y
    ];

// Tight ink-bounding-box for én linje: [xmin, ymin, xmax, ymax]
function _line_bbox(s) =
    Bogstav_Afstand_mm == 0
    ? let(t = _tm(s))
      [t.position.x, t.position.y,
       t.position.x + t.size.x, t.position.y + t.size.y]
    : len(s) == 0
      ? [0, 0, 0, 0]
      : [
          min([for (i = [0 : len(s) - 1]) _glyph_bbox(s, i)[0]]),
          min([for (i = [0 : len(s) - 1]) _glyph_bbox(s, i)[1]]),
          max([for (i = [0 : len(s) - 1]) _glyph_bbox(s, i)[2]]),
          max([for (i = [0 : len(s) - 1]) _glyph_bbox(s, i)[3]])
        ];

function _line_width(s) = let(b = _line_bbox(s)) b[2] - b[0];
function _line_step() = _FontMetrics.interline * Linje_Afstand;
function _block_width() = max([for (s = _Linjer) _line_width(s)]);

function _raw_line_y(i) = -i * _line_step();
function _raw_block_ymin() = min([
    for (i = [0 : len(_Linjer) - 1])
        _line_bbox(_Linjer[i])[1] + _raw_line_y(i)
]);
function _raw_block_ymax() = max([
    for (i = [0 : len(_Linjer) - 1])
        _line_bbox(_Linjer[i])[3] + _raw_line_y(i)
]);
function _block_y_shift() = -(_raw_block_ymin() + _raw_block_ymax()) / 2;

// Placér hver linje inden for bredeste linjes centrerede blok.
function _line_x_shift(s) =
    let(b = _line_bbox(s), bw = _block_width())
    Justering == "left"  ? -bw / 2 - b[0] :
    Justering == "right" ?  bw / 2 - b[2] :
                            -(b[0] + b[2]) / 2;

function _placed_line_bbox(i) =
    let(
        s = _Linjer[i],
        b = _line_bbox(s),
        dx = _line_x_shift(s),
        dy = _raw_line_y(i) + _block_y_shift()
    )
    [b[0] + dx, b[1] + dy, b[2] + dx, b[3] + dy];

// Bounding box efter shear. Y ændres ikke af denne shear-transform.
function _sheared_line_bbox(i) =
    let(
        b = _placed_line_bbox(i),
        k = tan(Shear_Vinkel),
        xs = [
            b[0] + k * b[1],
            b[0] + k * b[3],
            b[2] + k * b[1],
            b[2] + k * b[3]
        ]
    )
    [min(xs), b[1], max(xs), b[3]];

function _text_bbox() = [
    min([for (i = [0 : len(_Linjer) - 1]) _sheared_line_bbox(i)[0]]),
    min([for (i = [0 : len(_Linjer) - 1]) _sheared_line_bbox(i)[1]]),
    max([for (i = [0 : len(_Linjer) - 1]) _sheared_line_bbox(i)[2]]),
    max([for (i = [0 : len(_Linjer) - 1]) _sheared_line_bbox(i)[3]])
];

function _text_width()  = let(b = _text_bbox()) b[2] - b[0];
function _text_height() = let(b = _text_bbox()) b[3] - b[1];

function _rect_width() = Rektangel_Auto
    ? _text_width() + 2 * Base_Margin
    : Manuel_Base_Bredde;
function _rect_height() = Rektangel_Auto
    ? _text_height() + 2 * Base_Margin
    : Manuel_Base_Hoejde;

function _stand_width() = Stand_Auto_Bredde
    ? _text_width() + 2 * Base_Margin
    : Stand_Bredde;
function _stand_top() = _text_bbox()[1] + Stand_Overlap + Stand_Y_Forskydning;
function _stand_center_y() = _stand_top() - Stand_Hoejde / 2;

// Approksimeret/sikker 2D-bbox for basen.
function _base_bbox() =
    let(tb = _text_bbox())
    Base_Type == 1 || Base_Type == 2
    ? [tb[0] - Base_Margin, tb[1] - Base_Margin,
       tb[2] + Base_Margin, tb[3] + Base_Margin]
    : Base_Type == 3
      ? [-_rect_width()/2,
         Manuel_Base_Y_Forskydning - _rect_height()/2,
          _rect_width()/2,
         Manuel_Base_Y_Forskydning + _rect_height()/2]
      : Base_Type == 4
        ? [-_stand_width()/2,
           _stand_top() - Stand_Hoejde,
            _stand_width()/2,
           _stand_top()]
        : tb;

function _scene_ymin() =
    Base_Type == 0
    ? _text_bbox()[1]
    : Print_Mode == 0
      ? min(_base_bbox()[1], _text_bbox()[1])
      : _base_bbox()[1];

function _eff_text_bevel() = min(max(Bevel_Tykkelse, 0), max(Tekst_Dybde - Epsilon, 0));
function _max_safe_engrave() = max(Base_Dybde - Minimum_Bundtykkelse, Epsilon);
function _eff_engrave_depth() = Gravering_Gennem
    ? Base_Dybde + 2 * Epsilon
    : min(Graverings_Dybde, _max_safe_engrave());
function _eff_engrave_bevel() = min(max(Gravering_Bevel, 0), _eff_engrave_depth());

// -----------------------------------------------------------------------------
// 2D TEKST
// -----------------------------------------------------------------------------

module shear_transform(vinkel) {
    multmatrix([
        [1, tan(vinkel), 0, 0],
        [0, 1,            0, 0],
        [0, 0,            1, 0],
        [0, 0,            0, 1]
    ]) children();
}

module _draw_line(s) {
    if (Bogstav_Afstand_mm == 0) {
        // Bevarer fontens normale HarfBuzz shaping, kerning og ligaturer.
        text(
            text = s,
            size = Tekst_Stoerrelse,
            font = _Fuld_Font,
            halign = "left",
            valign = "baseline",
            spacing = 1,
            direction = "ltr",
            language = Sprog,
            script = Script
        );
    } else {
        // Forudsigelig ekstra fysisk tracking i mm.
        // Tradeoff: tegn shaper ikke længere som én samlet streng.
        for (i = [0 : len(s) - 1]) {
            translate([_glyph_x(s, i), 0])
            text(
                text = s[i],
                size = Tekst_Stoerrelse,
                font = _Fuld_Font,
                halign = "left",
                valign = "baseline",
                spacing = 1,
                direction = "ltr",
                language = Sprog,
                script = Script
            );
        }
    }
}

module draw_2d_text() {
    shear_transform(Shear_Vinkel) {
        for (i = [0 : len(_Linjer) - 1]) {
            s = _Linjer[i];
            translate([
                _line_x_shift(s),
                _raw_line_y(i) + _block_y_shift()
            ]) _draw_line(s);
        }
    }
}

// -----------------------------------------------------------------------------
// 3D TEKST / EMBOSS BEVEL
// -----------------------------------------------------------------------------

module draw_3d_text() {
    b = _eff_text_bevel();

    if (b > Epsilon && Bevel_Trin > 0) {
        body_h = max(Epsilon, Tekst_Dybde - b);
        step_h = b / Bevel_Trin;

        // Hovedkrop
        linear_extrude(height = body_h + Epsilon, convexity = 10)
            draw_2d_text();

        // Stepped top-chamfer: konstant lateral/vertikal ratio ~1:1.
        for (i = [0 : Bevel_Trin - 1]) {
            d = (i + 1) * b / Bevel_Trin;
            translate([0, 0, body_h + i * step_h])
            linear_extrude(height = step_h + Epsilon, convexity = 10)
                offset(delta = -d)
                    draw_2d_text();
        }
    } else {
        linear_extrude(height = Tekst_Dybde, convexity = 10)
            draw_2d_text();
    }
}

// -----------------------------------------------------------------------------
// BASE
// -----------------------------------------------------------------------------

module rounded_rect_2d(w, h, r) {
    rr = min(max(r, 0), max(min(w, h) / 2 - Epsilon, 0));
    if (rr > Epsilon) {
        offset(r = rr)
            square([max(w - 2*rr, Epsilon), max(h - 2*rr, Epsilon)], center = true);
    } else {
        square([w, h], center = true);
    }
}

module draw_2d_base() {
    if (Base_Type == 1) {
        // Boble/outline følger den faktiske tekstgeometri.
        offset(r = Base_Margin)
            draw_2d_text();
    }
    else if (Base_Type == 2) {
        // Stram konveks plade rundt om alle tegn/linjer.
        offset(r = Base_Margin)
            hull()
                draw_2d_text();
    }
    else if (Base_Type == 3) {
        translate([0, Manuel_Base_Y_Forskydning])
            rounded_rect_2d(_rect_width(), _rect_height(), Base_Hjoerne_Radius);
    }
    else if (Base_Type == 4) {
        // Plintens top ligger ved tekstens FAKTISKE nederste ink-kant + overlap.
        translate([0, _stand_center_y()])
            rounded_rect_2d(_stand_width(), Stand_Hoejde, Stand_Hjoerne_Radius);
    }
}

// -----------------------------------------------------------------------------
// ENGRAVING CUTTER
// -----------------------------------------------------------------------------

module engraving_cutter() {
    depth = _eff_engrave_depth();
    bevel = _eff_engrave_bevel();
    bottom_z = Gravering_Gennem ? -Epsilon : Base_Dybde - depth;

    // Nominel tekstprofil gennem hele den valgte dybde.
    translate([0, 0, bottom_z - Epsilon])
        linear_extrude(height = depth + 2*Epsilon, convexity = 10)
            draw_2d_text();

    // Ekstra udvidelse nær overfladen giver en chamfer/countersink-effekt.
    if (bevel > Epsilon && Gravering_Bevel_Trin > 0) {
        step_h = bevel / Gravering_Bevel_Trin;
        for (i = [0 : Gravering_Bevel_Trin - 1]) {
            d = (i + 1) * bevel / Gravering_Bevel_Trin;
            translate([0, 0, Base_Dybde - bevel + i * step_h])
                linear_extrude(height = step_h + Epsilon, convexity = 10)
                    offset(delta = d)
                        draw_2d_text();
        }
    }
}

// -----------------------------------------------------------------------------
// ASSEMBLY
// -----------------------------------------------------------------------------

module assemble_scene() {
    if (Base_Type == 0) {
        // Engraving giver ingen mening uden base; vi genererer derfor ren tekst.
        draw_3d_text();
    }
    else if (Print_Mode == 0) {
        union() {
            linear_extrude(height = Base_Dybde, convexity = 10)
                draw_2d_base();

            // Minimal overlap gør union robust uden synlig geometrisk ændring.
            translate([0, 0, Base_Dybde - Epsilon])
                draw_3d_text();
        }
    }
    else {
        difference() {
            linear_extrude(height = Base_Dybde, convexity = 10)
                draw_2d_base();
            engraving_cutter();
        }
    }
}

// Korrekt placering ved stående print:
// Efter rotate([90,0,0]) bliver oprindelig Y til ny Z.
// Derfor flyttes modellen med -scene_ymin efter rotationen.
module apply_orientation() {
    if (Orientering == 1) {
        translate([0, 0, -_scene_ymin()])
            rotate([90, 0, 0])
                children();
    } else {
        children();
    }
}

module diagnostics() {
    if (Diagnostik) {
        echo("--- 3D TEXT GENERATOR / NIGHTLY v2 ---");
        echo(Requested_Font = _Fuld_Font);
        echo(Resolved_Font_Family = _FontMetrics.font.family);
        echo(Resolved_Font_Style = _FontMetrics.font.style);
        echo(Active_Lines = _Linjer);
        echo(Text_BBox_mm = _text_bbox());
        echo(Text_Size_mm = [_text_width(), _text_height()]);
        if (Base_Type != 0)
            echo(Base_BBox_mm = _base_bbox());
        if (Bogstav_Afstand_mm != 0)
            echo("NOTE: mm-tracking placerer tegn individuelt; ligaturer og par-kerning fra den samlede streng bruges derfor ikke.");
        if (Bevel_Tykkelse > _eff_text_bevel() + Epsilon)
            echo("NOTE: Bevel_Tykkelse er automatisk begrænset af Tekst_Dybde.");
        if (!Gravering_Gennem && Graverings_Dybde > _eff_engrave_depth() + Epsilon)
            echo("NOTE: Graverings_Dybde er automatisk reduceret for at bevare Minimum_Bundtykkelse.");
        if (Base_Type == 0 && Print_Mode == 1)
            echo("NOTE: Print_Mode=Engraved ignoreres når Base_Type=0.");
    }
}

// -----------------------------------------------------------------------------
// MAIN
// -----------------------------------------------------------------------------

diagnostics();
apply_orientation()
    assemble_scene();
