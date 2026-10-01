/*
  PARAMETRISK DEKORATIV INSEKT-GENERATOR v3
  -----------------------------------------
  For OpenSCAD (gerne Nightly, men uden eksterne biblioteker).

  Formaal:
    - 3D-print (STL / 3MF)
    - laserskaering (SVG / DXF)
    - folieskaering / vinyl
    - gravering / relief

  Nyheder i v3:
    - Flere arts-/morfologi-presets inkl. Admiral, Paafugleoje, Blue_Morpho,
      Kejserguldsmed og vandnymfe-varianter.
    - Stencil/bridge-mode til laser og folie, saa indre oeer kan forbindes.
    - Multi-layer output for separate krop/vinger/dekoration/pletter.
    - Panel-/grid-generator til batch-produktion.
    - Ornamental / Art Nouveau mode med ekstra dekorative kurver.
    - Fortsat produktionsprofiler og robust 2D/3D-output.
*/

// ============================== //
// [00 - Art / output]            //
// ============================== //

Artspreset = "Fri"; // [Fri,Monark,Admiral,Paafugleoje,Morpho,Blue_Morpho,Svalehale,Luna,Atlas,Guldsmed_Stor,Kejserguldsmed,Vandnymfe,Vandnymfe_Smal,Cikade,Mariehoene,Skarabee]
Bruger_Type = "Sommerfugl"; // [Sommerfugl,Natsvaermer,Guldsmed,Cikade,Bille,Fantasi]
Output = "3D_RELIEF"; // [2D_SILHOUET,2D_DEKORATION,2D_COMBINED,3D_FLAT,3D_RELIEF]

// Samlet vingefang. For guldsmed/cikade er det bredeste vingesaet.
Vingefang = 100; // [20:1:320]
// Samlet laengde fra hale til antennespids, omtrentligt.
Kropslaengde = 52; // [10:1:220]
// Global skalering i laengderetningen; 1.0 = naturligt preset-forhold.
Laengde_Skala = 1.00; // [0.50:0.01:2.20]

// ============================== //
// [01 - Produktionsprofil]       //
// ============================== //

Produktionsprofil = "Brugerdefineret"; // [Brugerdefineret,3D_Print_Robust,Laser_Fin,Folie_Simpel,Gravering_Relief]
Automatisk_Produktionsoptimering = true;

// ============================== //
// [02 - Symmetri / stil]         //
// ============================== //

// 0 = fuldstaendig spejlsymmetrisk. Smaa vaerdier giver organisk variation.
Asymmetri = 0.00; // [0.00:0.01:0.15]
// Giver blodere former med offset-runding.
Bloedgoering = 0.35; // [0:0.05:2]
// Minimum bredde paa tynde dekorative elementer.
Min_Feature = 0.80; // [0.20:0.05:5]
// Polygon-/kurveoploesning. Hoejere er glattere men langsommere.
Oploesning = 56; // [16:4:180]

// ============================== //
// [03 - Vinger generelt]         //
// ============================== //

Vinge_Laengde = 1.00; // [0.60:0.01:1.60]
Vinge_Bredde = 1.00; // [0.50:0.01:1.80]
// Flytter vingespids frem (+) eller tilbage (-).
Vinge_Sweep = 0.00; // [-0.50:0.01:0.50]
// 0 = buttet/oval, 1 = spids.
Vingespids = 0.45; // [0.00:0.01:1.00]
// 0 = jaevn bredde, 1 = kraftigt smallere mod spidsen.
Vinge_Taper = 0.35; // [0.00:0.01:0.90]
// Rotation af hele vingeparret.
Vinge_Vinkel = 0; // [-35:1:35]
// Indtraek mellem krop og vingens geometriske start.
Vinge_Rod_Overlap = 1.5; // [0:0.25:10]
// Indhak i forvingens bagkant naer roden.
Forvinge_Indhak = 0.00; // [0.00:0.01:1.00]
// Bagvingens boelgede/scalloped bagkant.
Bagvinge_Skalop = 0.00; // [0.00:0.01:1.00]

// ============================== //
// [04 - Sommerfugl / natsvaermer]//
// ============================== //

Forvinge_Skala = 1.00; // [0.60:0.01:1.60]
Bagvinge_Skala = 0.88; // [0.50:0.01:1.60]
Bagvinge_Forskydning = -7; // [-30:0.5:20]
Bagvinge_Runding = 0.65; // [0.00:0.01:1.00]
// 0 = ingen hale; hoejere = svalehale-/luna-lignende hale.
Vinge_Hale = 0.00; // [0.00:0.01:1.00]

// ============================== //
// [05 - Guldsmed / cikade]       //
// ============================== //

Langvinge_For_Skala = 1.00; // [0.60:0.01:1.30]
Langvinge_Bag_Skala = 0.92; // [0.60:0.01:1.30]
Langvinge_Separation = 8.0; // [2:0.5:30]
Langvinge_Rod_Bredde = 0.42; // [0.15:0.01:0.85]
Langvinge_Spids_Bredde = 0.55; // [0.15:0.01:1.00]
// Lille farvet / graferbar pterostigma-lignende markering naer spidsen.
Pterostigma = true;
Pterostigma_Skala = 1.00; // [0.40:0.05:2.50]

// ============================== //
// [06 - Krop]                    //
// ============================== //

Krop_Bredde = 7.0; // [1:0.25:30]
Bryst_Skala = 1.15; // [0.60:0.01:2.00]
Hoved_Skala = 0.90; // [0.50:0.01:2.00]
Bagkrop_Taper = 0.55; // [0.10:0.01:1.00]
Bagkrop_Segmenter = 6; // [0:1:18]
Talje = 0.15; // [0.00:0.01:0.80]

// ============================== //
// [07 - Antenner / ben]          //
// ============================== //

Antenner = true;
Antenne_Laengde = 12; // [0:0.5:50]
Antenne_Spredning = 28; // [0:1:80]
Antenne_Krumning = 0.35; // [-1.00:0.05:1.00]
Antenne_Knop = 0.0; // [0:0.1:4]
// Simpel pseudo-fjering paa antenner, nyttig til natsvaermere.
Antenne_Fjering = 0.00; // [0.00:0.05:2.00]

Ben = false;
Ben_Laengde = 10; // [2:0.5:30]
Ben_Vinkel = 35; // [5:1:80]

// ============================== //
// [08 - Vingedekoration / aarer] //
// ============================== //

Vinge_Aarer = true;
Aare_Tykkelse = 0.65; // [0.20:0.05:3]
Aare_Taethed = 5; // [1:1:14]
Tvaer_Aarer = true;
Aare_Organisk = 0.55; // [0.00:0.01:1.00]

Vinge_Pletter = true;
Plet_Antal = 2; // [0:1:6]
Plet_Skala = 1.0; // [0.3:0.05:3]
Plet_Ring = true;

// Elytra-/dækningsdekor til biller / mariehoener.
Daekvinge_Soem = true;
Daekvinge_Pletter = true;
Daekvinge_Plet_Antal = 3; // [0:1:8]

// ============================== //
// [09 - Kant / udskaeringer]     //
// ============================== //

Ydre_Kant = 0.0; // [0:0.1:5]
Udskaering = 0.0; // [0.00:0.05:1.00]
Udskaering_Margin = 3.0; // [0.5:0.25:10]

// ============================== //
// [10 - Ophaeng / montage]       //
// ============================== //

Ophaengshul = false;
Ophaengshul_Diameter = 3.2; // [1:0.1:10]
Ophaengshul_Y = 0; // [-20:0.5:20]

// ============================== //
// [11 - 3D]                      //
// ============================== //

Tykkelse = 2.4; // [0.4:0.1:12]
Relief_Hoejde = 0.70; // [0.1:0.05:5]
Relief_Haevede_Detaljer = true;

// ============================== //
// [12 - Stencil / bridges]       //
// ============================== //

Stencil_Mode = false;
// Brobredde til at forbinde indre oeer med yderkonturen.
Stencil_Bro_Bredde = 1.20; // [0.30:0.05:6]
// Antal broer pr. side, placeret radialt mod vingerne.
Stencil_Bro_Antal = 2; // [1:1:6]
// Hvor langt broer ma gaa ind i silhuetten.
Stencil_Bro_Laengde = 18; // [4:0.5:50]
// Tilfoej bro til ophaengshul / centrale huller.
Stencil_Centerbro = true;

// ============================== //
// [13 - Multi-layer output]      //
// ============================== //

Layer_Output = "Alle"; // [Alle,Vinger,Krop,Aarer,Pletter,Stencilbroer]
// Lidt overlap mellem separate lag kan vaere nyttigt til vinyl/laserregistrering.
Layer_Overlap = 0.20; // [0:0.05:2]

// ============================== //
// [14 - Panel / batch]           //
// ============================== //

Panel_Mode = false;
Panel_Kolonner = 3; // [1:1:10]
Panel_Raekker = 2; // [1:1:10]
Panel_Afstand_X = 125; // [20:1:400]
Panel_Afstand_Y = 95; // [20:1:400]
Panel_Skiftevis_Spejling = false;
Panel_Skiftevis_Rotation = 0; // [-180:5:180]

// ============================== //
// [15 - Ornamental / Art Nouveau]//
// ============================== //

Ornamental_Mode = false;
Ornamental_Styrke = 0.55; // [0.00:0.05:1.50]
Ornamental_Tykkelse = 0.70; // [0.20:0.05:4]
Ornamental_Slyng = 3; // [1:1:8]
Ornamental_Ringe = true;

// ============================== //
// [16 - Preview]                 //
// ============================== //

Vis_Centerlinje = false;

$fn = Oploesning;
EPS = 0.01;

// ------------------------------------------------------------
// Hjaelpefunktioner
// ------------------------------------------------------------
function clamp(v,a,b) = min(max(v,a),b);
function lerp(a,b,t) = a + (b-a)*t;
function v2lerp(a,b,t) = [lerp(a[0],b[0],t), lerp(a[1],b[1],t)];
function bz3(p0,p1,p2,p3,t) =
    let(u=1-t)
    [u*u*u*p0[0] + 3*u*u*t*p1[0] + 3*u*t*t*p2[0] + t*t*t*p3[0],
     u*u*u*p0[1] + 3*u*u*t*p1[1] + 3*u*t*t*p2[1] + t*t*t*p3[1]];
function bez3pts(p0,p1,p2,p3,n=16) = [for(i=[0:n]) bz3(p0,p1,p2,p3,i/n)];

function profile_min_floor() =
    Produktionsprofil=="3D_Print_Robust" ? 0.80 :
    Produktionsprofil=="Laser_Fin" ? 0.35 :
    Produktionsprofil=="Folie_Simpel" ? 0.60 :
    Produktionsprofil=="Gravering_Relief" ? 0.45 : 0;

function eff_min_feature() = max(Min_Feature, Automatisk_Produktionsoptimering ? profile_min_floor() : 0);
function eff_vein_thickness() = max(Aare_Tykkelse, eff_min_feature()*0.60);
function eff_outline() = Ydre_Kant + (Automatisk_Produktionsoptimering && Produktionsprofil=="3D_Print_Robust" ? eff_min_feature()*0.20 : 0);
function eff_cutout() = Automatisk_Produktionsoptimering && (Produktionsprofil=="3D_Print_Robust" || Produktionsprofil=="Folie_Simpel") ? min(Udskaering,0.35) : Udskaering;
function eff_veins_enabled() = Automatisk_Produktionsoptimering && Produktionsprofil=="Folie_Simpel" ? false : Vinge_Aarer;
function eff_spots_enabled() = Automatisk_Produktionsoptimering && Produktionsprofil=="Folie_Simpel" ? false : Vinge_Pletter;
function eff_crossveins() = Automatisk_Produktionsoptimering && Produktionsprofil=="Folie_Simpel" ? false : Tvaer_Aarer;
function eff_deck_spots() = Automatisk_Produktionsoptimering && Produktionsprofil=="Folie_Simpel" ? false : Daekvinge_Pletter;

function chosen_family() =
    Artspreset=="Fri" ? Bruger_Type :
    Artspreset=="Monark" ? "Sommerfugl" :
    Artspreset=="Admiral" ? "Sommerfugl" :
    Artspreset=="Paafugleoje" ? "Sommerfugl" :
    Artspreset=="Morpho" ? "Sommerfugl" :
    Artspreset=="Blue_Morpho" ? "Sommerfugl" :
    Artspreset=="Svalehale" ? "Sommerfugl" :
    Artspreset=="Luna" ? "Natsvaermer" :
    Artspreset=="Atlas" ? "Natsvaermer" :
    Artspreset=="Guldsmed_Stor" ? "Guldsmed" :
    Artspreset=="Kejserguldsmed" ? "Guldsmed" :
    Artspreset=="Vandnymfe" ? "Guldsmed" :
    Artspreset=="Vandnymfe_Smal" ? "Guldsmed" :
    Artspreset=="Cikade" ? "Cikade" :
    Artspreset=="Mariehoene" ? "Bille" :
    Artspreset=="Skarabee" ? "Bille" : Bruger_Type;

function is_butterfly() = chosen_family()=="Sommerfugl" || chosen_family()=="Natsvaermer" || chosen_family()=="Fantasi";
function is_longwing() = chosen_family()=="Guldsmed" || chosen_family()=="Cikade";
function is_beetle() = chosen_family()=="Bille";

function art_adj_forwing() =
    Artspreset=="Monark" ? 1.00 :
    Artspreset=="Admiral" ? 0.98 :
    Artspreset=="Paafugleoje" ? 1.03 :
    Artspreset=="Morpho" ? 1.08 :
    Artspreset=="Blue_Morpho" ? 1.10 :
    Artspreset=="Svalehale" ? 1.02 :
    Artspreset=="Luna" ? 0.98 :
    Artspreset=="Atlas" ? 1.12 :
    1.00;
function art_adj_hindwing() =
    Artspreset=="Monark" ? 0.92 :
    Artspreset=="Admiral" ? 0.88 :
    Artspreset=="Paafugleoje" ? 0.96 :
    Artspreset=="Morpho" ? 1.00 :
    Artspreset=="Blue_Morpho" ? 1.02 :
    Artspreset=="Svalehale" ? 0.82 :
    Artspreset=="Luna" ? 0.96 :
    Artspreset=="Atlas" ? 1.05 :
    0.88;
function art_adj_rounding() =
    Artspreset=="Morpho" ? 0.82 :
    Artspreset=="Blue_Morpho" ? 0.86 :
    Artspreset=="Paafugleoje" ? 0.78 :
    Artspreset=="Admiral" ? 0.60 :
    Artspreset=="Monark" ? 0.62 :
    Artspreset=="Svalehale" ? 0.54 :
    Artspreset=="Luna" ? 0.86 :
    Artspreset=="Atlas" ? 0.76 :
    Bagvinge_Runding;
function art_adj_tail() =
    Artspreset=="Svalehale" ? 0.52 :
    Artspreset=="Luna" ? 0.86 :
    Artspreset=="Atlas" ? 0.18 :
    Vinge_Hale;
function art_adj_tip() =
    Artspreset=="Monark" ? 0.46 :
    Artspreset=="Admiral" ? 0.55 :
    Artspreset=="Paafugleoje" ? 0.40 :
    Artspreset=="Morpho" ? 0.30 :
    Artspreset=="Blue_Morpho" ? 0.26 :
    Artspreset=="Svalehale" ? 0.64 :
    Artspreset=="Luna" ? 0.42 :
    Artspreset=="Atlas" ? 0.38 :
    Vingespids;
function art_adj_taper() =
    Artspreset=="Monark" ? 0.36 :
    Artspreset=="Admiral" ? 0.42 :
    Artspreset=="Paafugleoje" ? 0.30 :
    Artspreset=="Morpho" ? 0.22 :
    Artspreset=="Blue_Morpho" ? 0.18 :
    Artspreset=="Svalehale" ? 0.48 :
    Artspreset=="Luna" ? 0.30 :
    Artspreset=="Atlas" ? 0.24 :
    Vinge_Taper;
function art_adj_sweep() =
    Artspreset=="Monark" ? 0.04 :
    Artspreset=="Morpho" ? 0.00 :
    Artspreset=="Svalehale" ? 0.06 :
    Artspreset=="Luna" ? -0.08 :
    Artspreset=="Atlas" ? -0.04 :
    Artspreset=="Guldsmed_Stor" ? 0.02 :
    Artspreset=="Kejserguldsmed" ? 0.05 :
    Artspreset=="Vandnymfe" ? -0.06 :
    Artspreset=="Vandnymfe_Smal" ? -0.10 :
    Artspreset=="Cikade" ? 0.00 :
    Vinge_Sweep;
function art_adj_fore_notch() =
    Artspreset=="Svalehale" ? 0.42 :
    Artspreset=="Atlas" ? 0.25 :
    Forvinge_Indhak;
function art_adj_scallop() =
    Artspreset=="Morpho" ? 0.12 :
    Artspreset=="Svalehale" ? 0.34 :
    Artspreset=="Luna" ? 0.20 :
    Bagvinge_Skalop;
function art_adj_long_sep() =
    Artspreset=="Guldsmed_Stor" ? 11 :
    Artspreset=="Kejserguldsmed" ? 12 :
    Artspreset=="Vandnymfe" ? 7 :
    Artspreset=="Vandnymfe_Smal" ? 5.5 :
    Artspreset=="Cikade" ? 8 :
    Langvinge_Separation;
function art_adj_root_width() =
    Artspreset=="Guldsmed_Stor" ? 0.34 :
    Artspreset=="Kejserguldsmed" ? 0.38 :
    Artspreset=="Vandnymfe" ? 0.26 :
    Artspreset=="Vandnymfe_Smal" ? 0.20 :
    Artspreset=="Cikade" ? 0.48 :
    Langvinge_Rod_Bredde;
function art_adj_tip_width() =
    Artspreset=="Guldsmed_Stor" ? 0.46 :
    Artspreset=="Kejserguldsmed" ? 0.50 :
    Artspreset=="Vandnymfe" ? 0.34 :
    Artspreset=="Vandnymfe_Smal" ? 0.28 :
    Artspreset=="Cikade" ? 0.66 :
    Langvinge_Spids_Bredde;
function art_adj_thorax() =
    Artspreset=="Guldsmed_Stor" ? 1.25 :
    Artspreset=="Vandnymfe" ? 1.05 :
    Artspreset=="Cikade" ? 1.15 :
    Artspreset=="Mariehoene" ? 1.35 :
    Artspreset=="Skarabee" ? 1.22 :
    Bryst_Skala;
function art_adj_head() =
    Artspreset=="Guldsmed_Stor" ? 1.18 :
    Artspreset=="Vandnymfe" ? 1.06 :
    Artspreset=="Cikade" ? 1.20 :
    Artspreset=="Mariehoene" ? 0.88 :
    Artspreset=="Skarabee" ? 0.92 :
    Hoved_Skala;
function art_adj_ab_taper() =
    Artspreset=="Guldsmed_Stor" ? 0.38 :
    Artspreset=="Vandnymfe" ? 0.32 :
    Artspreset=="Cikade" ? 0.72 :
    Artspreset=="Mariehoene" ? 0.90 :
    Artspreset=="Skarabee" ? 0.74 :
    Bagkrop_Taper;
function art_adj_segments() =
    Artspreset=="Guldsmed_Stor" ? 9 :
    Artspreset=="Vandnymfe" ? 8 :
    Artspreset=="Cikade" ? 7 :
    Artspreset=="Mariehoene" ? 4 :
    Artspreset=="Skarabee" ? 5 :
    Bagkrop_Segmenter;
function art_body_w_factor() =
    Artspreset=="Mariehoene" ? 1.55 :
    Artspreset=="Skarabee" ? 1.35 :
    Artspreset=="Guldsmed_Stor" ? 0.72 :
    Artspreset=="Vandnymfe" ? 0.58 :
    Artspreset=="Cikade" ? 1.22 :
    1.00;
function art_body_len_factor() =
    Artspreset=="Guldsmed_Stor" ? 1.22 :
    Artspreset=="Vandnymfe" ? 1.14 :
    Artspreset=="Mariehoene" ? 0.70 :
    Artspreset=="Skarabee" ? 0.82 :
    1.00;
function art_ant_len() =
    Artspreset=="Luna" ? 16 :
    Artspreset=="Atlas" ? 15 :
    Artspreset=="Guldsmed_Stor" ? 5 :
    Artspreset=="Vandnymfe" ? 5 :
    Artspreset=="Cikade" ? 6 :
    Antenne_Laengde;
function art_ant_spread() =
    Artspreset=="Luna" ? 34 :
    Artspreset=="Atlas" ? 28 :
    Artspreset=="Guldsmed_Stor" ? 18 :
    Artspreset=="Vandnymfe" ? 14 :
    Artspreset=="Cikade" ? 18 :
    Antenne_Spredning;
function art_ant_fan() =
    Artspreset=="Luna" ? 1.25 :
    Artspreset=="Atlas" ? 1.00 :
    Antenne_Fjering;
function art_vein_density() =
    Artspreset=="Monark" ? 6 :
    Artspreset=="Admiral" ? 5 :
    Artspreset=="Paafugleoje" ? 5 :
    Artspreset=="Morpho" ? 5 :
    Artspreset=="Blue_Morpho" ? 5 :
    Artspreset=="Svalehale" ? 5 :
    Artspreset=="Luna" ? 4 :
    Artspreset=="Atlas" ? 4 :
    Artspreset=="Guldsmed_Stor" ? 7 :
    Artspreset=="Kejserguldsmed" ? 8 :
    Artspreset=="Vandnymfe" ? 6 :
    Artspreset=="Vandnymfe_Smal" ? 6 :
    Artspreset=="Cikade" ? 8 :
    Aare_Taethed;
function art_spot_count() =
    Artspreset=="Monark" ? 1 :
    Artspreset=="Admiral" ? 2 :
    Artspreset=="Paafugleoje" ? 3 :
    Artspreset=="Morpho" ? 0 :
    Artspreset=="Blue_Morpho" ? 0 :
    Artspreset=="Svalehale" ? 2 :
    Artspreset=="Luna" ? 2 :
    Artspreset=="Atlas" ? 1 :
    Plet_Antal;
function art_spots_default() =
    Artspreset=="Morpho" ? false :
    Artspreset=="Blue_Morpho" ? false :
    Artspreset=="Guldsmed_Stor" ? false :
    Artspreset=="Kejserguldsmed" ? false :
    Artspreset=="Vandnymfe_Smal" ? false :
    Artspreset=="Vandnymfe" ? false :
    Artspreset=="Cikade" ? false :
    is_butterfly();

function eff_body_w() = Krop_Bredde * art_body_w_factor() * (chosen_family()=="Guldsmed" ? 0.65 : chosen_family()=="Cikade" ? 1.15 : chosen_family()=="Bille" ? 1.35 : 1);
function eff_body_len() = Kropslaengde * Laengde_Skala * art_body_len_factor() * (chosen_family()=="Guldsmed" ? 1.15 : chosen_family()=="Bille" ? 0.80 : 1);
function eff_forwing_scale() = Forvinge_Skala * art_adj_forwing();
function eff_hindwing_scale() = Bagvinge_Skala * art_adj_hindwing();
function eff_hindwing_round() = clamp(Artspreset=="Fri" ? Bagvinge_Runding : art_adj_rounding(),0,1);
function eff_wing_tail() = clamp(Artspreset=="Fri" ? Vinge_Hale : art_adj_tail(),0,1);
function eff_tip() = clamp(Artspreset=="Fri" ? Vingespids : art_adj_tip(),0,1);
function eff_taper() = clamp(Artspreset=="Fri" ? Vinge_Taper : art_adj_taper(),0,0.95);
function eff_sweep() = Artspreset=="Fri" ? Vinge_Sweep : art_adj_sweep();
function eff_notch() = clamp(Artspreset=="Fri" ? Forvinge_Indhak : art_adj_fore_notch(),0,1);
function eff_scallop() = clamp(Artspreset=="Fri" ? Bagvinge_Skalop : art_adj_scallop(),0,1);
function eff_long_sep() = Artspreset=="Fri" ? Langvinge_Separation : art_adj_long_sep();
function eff_long_rootw() = Artspreset=="Fri" ? Langvinge_Rod_Bredde : art_adj_root_width();
function eff_long_tipw() = Artspreset=="Fri" ? Langvinge_Spids_Bredde : art_adj_tip_width();
function eff_thorax_scale() = Artspreset=="Fri" ? Bryst_Skala : art_adj_thorax();
function eff_head_scale() = Artspreset=="Fri" ? Hoved_Skala : art_adj_head();
function eff_ab_taper() = Artspreset=="Fri" ? Bagkrop_Taper : art_adj_ab_taper();
function eff_segments() = Artspreset=="Fri" ? Bagkrop_Segmenter : art_adj_segments();
function eff_ant_len() = Artspreset=="Fri" ? Antenne_Laengde : art_ant_len();
function eff_ant_spread() = Artspreset=="Fri" ? Antenne_Spredning : art_ant_spread();
function eff_ant_fan() = Artspreset=="Fri" ? Antenne_Fjering : art_ant_fan();
function eff_vein_density_count() = Artspreset=="Fri" ? Aare_Taethed : art_vein_density();
function eff_spot_count() = Artspreset=="Fri" ? Plet_Antal : art_spot_count();
function eff_spot_state() = eff_spots_enabled() && (Artspreset=="Fri" ? Vinge_Pletter : art_spots_default());

module stroke_polyline(pts, w=1) {
    ww=max(w,eff_min_feature());
    for(i=[0:len(pts)-2]) hull() {
        translate(pts[i]) circle(d=ww);
        translate(pts[i+1]) circle(d=ww);
    }
}

module stroke_bezier(p0,p1,p2,p3,w=1,n=14) {
    stroke_polyline(bez3pts(p0,p1,p2,p3,n),w);
}

module soft2d(r=Bloedgoering) {
    if(r>0) offset(r=r) offset(delta=-r) children();
    else children();
}

module mirrored_pair() {
    children();
    mirror([1,0,0]) children();
}

// ------------------------------------------------------------
// Vingegeometri
// ------------------------------------------------------------
module butterfly_forewing_half(scale_fac=1) {
    span = Vingefang/2 * 0.96 * Vinge_Laengde * eff_forwing_scale() * scale_fac;
    chord = Vingefang * 0.29 * Vinge_Bredde * scale_fac * (chosen_family()=="Natsvaermer" ? 0.78 : 1);
    rootx = eff_body_w()/2 - Vinge_Rod_Overlap;
    rooty = eff_body_len()*0.08;
    sweep = eff_sweep() * chord;
    tipy = rooty + chord*(0.45+sweep/chord);
    tip_round = 1-eff_tip();
    taper=eff_taper();
    notch=eff_notch();

    p0=[rootx, rooty-chord*0.28];
    p1=[rootx+span*0.22, rooty-chord*0.48];
    p2=[rootx+span*0.72, tipy-chord*(0.42-0.15*tip_round)];
    p3=[rootx+span, tipy];
    p4=[rootx+span*(0.82+0.10*tip_round), tipy+chord*(0.16+0.10*tip_round)];
    p5=[rootx+span*(0.45+0.08*taper), rooty+chord*(0.46-0.12*taper)];
    pn=[rootx+span*(0.16+0.10*notch), rooty+chord*(0.34-0.18*notch)];
    p6=[rootx, rooty+chord*0.28];

    rotate(Vinge_Vinkel)
    soft2d()
    polygon(concat(
        bez3pts(p0,p1,p2,p3,10),
        bez3pts(p3,p4,p4,p5,8),
        bez3pts(p5,pn,pn,p6,8)
    ));
}

module butterfly_hindwing_half(scale_fac=1) {
    span = Vingefang/2 * 0.72 * Vinge_Laengde * eff_hindwing_scale() * scale_fac;
    chord = Vingefang * 0.28 * Vinge_Bredde * scale_fac;
    rootx=eff_body_w()/2 - Vinge_Rod_Overlap;
    rooty=-eff_body_len()*0.04 + Bagvinge_Forskydning;
    round=eff_hindwing_round();
    tail=eff_wing_tail();
    scal=eff_scallop();

    p0=[rootx,rooty+chord*0.35];
    p1=[rootx+span*0.22,rooty+chord*0.46];
    p2=[rootx+span*0.78,rooty+chord*0.40];
    p3=[rootx+span,rooty+chord*(0.05+0.10*eff_sweep())];
    p4=[rootx+span*(0.96-0.12*round),rooty-chord*(0.28+0.20*round)];
    pd=[rootx+span*(0.68-0.08*scal),rooty-chord*(0.42+0.22*scal)];
    tailp=[rootx+span*(0.62+0.10*tail),rooty-chord*(0.45+0.50*tail)];
    p5=[rootx+span*(0.34+0.12*round),rooty-chord*(0.40+0.18*round)];
    p6=[rootx,rooty-chord*0.22];

    rotate(Vinge_Vinkel*0.45)
    soft2d()
    polygon(concat(
        bez3pts(p0,p1,p2,p3,9),
        tail>0.02 ? concat(bez3pts(p3,p4,p4,tailp,6), bez3pts(tailp,pd,p5,p6,8))
                  : concat(bez3pts(p3,p4,pd,p5,8), bez3pts(p5,p5,p6,p6,3))
    ));
}

module longwing_half(yshift=0, scale_fac=1, rear=false) {
    span=Vingefang/2 * 0.98 * Vinge_Laengde * scale_fac;
    width=Vingefang * (chosen_family()=="Cikade" ? 0.16 : 0.105) * Vinge_Bredde * (rear ? 1.06 : 1);
    rootx=eff_body_w()/2 - Vinge_Rod_Overlap;
    rooty=yshift;
    rootw=width*eff_long_rootw();
    tipw=width*eff_long_tipw();
    sweep=eff_sweep()*width*1.4;

    p0=[rootx,rooty-rootw/2];
    p1=[rootx+span*0.28,rooty-width*0.56];
    p2=[rootx+span*0.77,rooty+sweep-width*0.46];
    p3=[rootx+span,rooty+sweep-tipw*0.08];
    p4=[rootx+span,rooty+sweep+tipw*0.18];
    p5=[rootx+span*0.70,rooty+sweep+width*0.48];
    p6=[rootx+span*0.22,rooty+width*0.48];
    p7=[rootx,rooty+rootw/2];

    rotate(Vinge_Vinkel)
    soft2d()
    polygon(concat(bez3pts(p0,p1,p2,p3,10),bez3pts(p3,p4,p5,p6,8),bez3pts(p6,p6,p7,p7,3)));
}

module beetle_elytron_half() {
    span=Vingefang/2*(Artspreset=="Mariehoene" ? 0.46 : 0.53)*Vinge_Bredde;
    len=eff_body_len()*(Artspreset=="Mariehoene" ? 0.56 : 0.62);
    rootx=eff_body_w()*0.10;
    y0=-eff_body_len()*0.12;
    soft2d()
    polygon(concat(
        bez3pts([rootx,y0+len*0.48],[span*0.65,y0+len*0.55],[span,y0+len*0.20],[span,y0-len*0.08],10),
        bez3pts([span,y0-len*0.08],[span*0.95,y0-len*0.48],[span*0.42,y0-len*0.58],[rootx,y0-len*0.52],10)
    ));
}

module wings_2d() {
    if(is_butterfly()) {
        mirrored_pair() {
            butterfly_forewing_half(1 + Asymmetri);
            butterfly_hindwing_half(1 + Asymmetri*0.5);
        }
    }
    else if(is_longwing()) {
        sep=eff_long_sep();
        mirrored_pair() {
            longwing_half(+sep/2, Langvinge_For_Skala*(1+Asymmetri), false);
            longwing_half(-sep/2, Langvinge_Bag_Skala*(1+Asymmetri*0.5), true);
        }
    }
    else if(is_beetle()) {
        mirrored_pair() beetle_elytron_half();
        mirrored_pair() rotate(-8) scale([1.12,0.72]) longwing_half(-3,0.72,false);
    }
}

// ------------------------------------------------------------
// Krop, hoved, antenner, ben
// ------------------------------------------------------------
module body_core_2d() {
    L=eff_body_len();
    W=eff_body_w();
    head_y=L*0.32;
    thor_y=L*0.12;
    abdomen_y=-L*0.13;
    abdomen_len=L*0.53;

    union() {
        hull() {
            translate([0,abdomen_y+abdomen_len*0.35]) circle(d=W*(0.82-0.28*Talje));
            translate([0,abdomen_y-abdomen_len*0.48]) circle(d=W*eff_ab_taper());
        }
        translate([0,thor_y]) scale([eff_thorax_scale(),1.18]) circle(d=W);
        hull() {
            translate([0,thor_y+W*0.30]) circle(d=W*0.48);
            translate([0,head_y]) scale([eff_head_scale(),0.90*eff_head_scale()]) circle(d=W);
        }
    }
}

module antenna_half(side=1) {
    L=eff_body_len(); W=eff_body_w();
    y=L*0.37;
    antL=eff_ant_len();
    fan=eff_ant_fan();
    p0=[side*W*0.20,y];
    p1=[side*(W*0.35 + antL*0.18), y+antL*0.30];
    p2=[side*(W*0.35 + antL*(0.48+0.12*Antenne_Krumning)), y+antL*0.68];
    p3=[side*(W*0.30 + antL*sin(eff_ant_spread())), y+antL];
    stroke_bezier(p0,p1,p2,p3,eff_min_feature(),14);

    if(fan>0.02)
        for(t=[0.18:0.12:0.82]) {
            pt=bz3(p0,p1,p2,p3,t);
            dir=[side*fan*antL*(0.08+0.08*t), fan*antL*(0.01+0.01*t)];
            stroke_polyline([pt, pt+[dir[0],dir[1]]], eff_min_feature()*0.65);
            stroke_polyline([pt, pt+[dir[0],-dir[1]]], eff_min_feature()*0.65);
        }

    if(Antenne_Knop>0) translate(p3) circle(d=max(Antenne_Knop,eff_min_feature()));
}

module legs_2d() {
    if(Ben) {
        L=eff_body_len(); W=eff_body_w();
        for(yy=[-0.03,0.10,0.20])
            for(s=[-1,1]) {
                root=[s*W*0.30,L*yy];
                knee=[s*(W*0.65+Ben_Laengde*0.38),L*yy-Ben_Laengde*0.12];
                tip=[s*(W*0.65+Ben_Laengde*cos(Ben_Vinkel)),L*yy-Ben_Laengde*sin(Ben_Vinkel)];
                stroke_polyline([root,knee,tip],eff_min_feature());
            }
    }
}

module body_2d() {
    union() {
        soft2d(Bloedgoering*0.5) body_core_2d();
        if(Antenner) { antenna_half(-1); antenna_half(1); }
        legs_2d();
    }
}

// ------------------------------------------------------------
// Dekoration: aarer, pletter, kropssegmenter
// ------------------------------------------------------------
module butterfly_veins_half(fore=true) {
    span=Vingefang/2 * (fore ? 0.90*eff_forwing_scale() : 0.66*eff_hindwing_scale()) * Vinge_Laengde;
    chord=Vingefang * (fore ? 0.24 : 0.23) * Vinge_Bredde;
    root=[eff_body_w()/2, fore ? eff_body_len()*0.08 : -eff_body_len()*0.04+Bagvinge_Forskydning];
    baseang=fore ? Vinge_Vinkel : Vinge_Vinkel*0.45;

    rotate(baseang) {
        stroke_bezier(root,
            [root[0]+span*0.25,root[1]+chord*0.02],
            [root[0]+span*0.58,root[1]+chord*(fore?0.15:-0.08)],
            [root[0]+span*0.90,root[1]+chord*(fore?0.28:-0.12)], eff_vein_thickness(),14);

        for(i=[1:eff_vein_density_count()]) {
            t=i/(eff_vein_density_count()+1);
            start=[root[0]+span*(0.07+0.50*t), root[1]+chord*(fore?0.04:-0.02)];
            ey = fore ? lerp(-0.31,0.48,t) : lerp(-0.38,0.30,t);
            end=[root[0]+span*lerp(0.50,0.95,t), root[1]+chord*ey];
            bend=Aare_Organisk*chord*0.10*sin(i*37);
            stroke_bezier(start,
                v2lerp(start,end,0.35)+[0,bend],
                v2lerp(start,end,0.72)+[0,-bend*0.4],end,
                eff_vein_thickness(),9);
        }

        if(eff_crossveins())
            for(i=[1:max(1,eff_vein_density_count()-1)]) {
                t=i/eff_vein_density_count();
                x=root[0]+span*(0.34+0.45*t);
                stroke_bezier([x,root[1]-chord*0.18],[x+span*0.03,root[1]-chord*0.05],
                              [x-span*0.02,root[1]+chord*0.15],[x,root[1]+chord*0.30],
                              eff_vein_thickness()*0.75,7);
            }
    }
}

module longwing_veins_half(yshift=0,scale_fac=1) {
    span=Vingefang/2*0.91*Vinge_Laengde*scale_fac;
    width=Vingefang*(chosen_family()=="Cikade"?0.14:0.09)*Vinge_Bredde;
    root=[eff_body_w()/2,yshift];
    rotate(Vinge_Vinkel) {
        for(j=[-1,0,1])
            stroke_bezier(root,
                [root[0]+span*0.28,root[1]+j*width*0.22],
                [root[0]+span*0.66,root[1]+j*width*0.26],
                [root[0]+span*0.92,root[1]+j*width*0.16],eff_vein_thickness(),12);
        if(eff_crossveins())
            for(i=[1:eff_vein_density_count()]) {
                t=i/(eff_vein_density_count()+1);
                x=root[0]+span*(0.15+0.70*t);
                w=width*(0.35+0.55*sin(t*180));
                stroke_bezier([x,root[1]-w],[x+span*0.025,root[1]-w*0.3],
                              [x-span*0.015,root[1]+w*0.3],[x,root[1]+w],eff_vein_thickness()*0.70,6);
            }
    }
}

module pterostigma_half(yshift=0,scale_fac=1) {
    if(Pterostigma && (chosen_family()=="Guldsmed" || chosen_family()=="Cikade")) {
        span=Vingefang/2*0.91*Vinge_Laengde*scale_fac;
        width=Vingefang*(chosen_family()=="Cikade"?0.14:0.09)*Vinge_Bredde;
        root=[eff_body_w()/2,yshift];
        rotate(Vinge_Vinkel)
            translate([root[0]+span*0.82,root[1]+width*0.18])
                scale([1.8,0.75]) circle(d=max(width*0.22*Pterostigma_Skala, eff_min_feature()*1.4));
    }
}

module wing_spots_half() {
    if(eff_spot_state() && eff_spot_count()>0 && is_butterfly()) {
        span=Vingefang/2*0.90*Vinge_Laengde*eff_forwing_scale();
        chord=Vingefang*0.24*Vinge_Bredde;
        root=[eff_body_w()/2,eff_body_len()*0.08];
        rotate(Vinge_Vinkel)
        for(i=[0:eff_spot_count()-1]) {
            t=(i+1)/(eff_spot_count()+1);
            c=[root[0]+span*lerp(0.52,0.78,t),root[1]+chord*lerp(-0.08,0.25,t)];
            d=Vingefang*0.045*Plet_Skala*(1-0.15*i);
            if(Plet_Ring) {
                difference() {
                    translate(c) circle(d=d);
                    translate(c) circle(d=max(d-2*max(eff_vein_thickness(),eff_min_feature()),eff_min_feature()));
                }
            } else translate(c) circle(d=d);
        }
    }
}

module beetle_spots_half() {
    if(eff_deck_spots() && is_beetle()) {
        span=Vingefang/2*(Artspreset=="Mariehoene" ? 0.42 : 0.45);
        y0=-eff_body_len()*0.12;
        for(i=[0:Daekvinge_Plet_Antal-1]) {
            t=(i+1)/(Daekvinge_Plet_Antal+1);
            px=eff_body_w()*0.18 + span*lerp(0.22,0.82,t);
            py=y0 + eff_body_len()*lerp(0.10,-0.28,t) + (i%2==0 ? 2.0 : -1.5);
            translate([px,py]) scale([1.15,0.95]) circle(d=Vingefang*0.045*(Artspreset=="Mariehoene" ? 1.0 : 0.75));
        }
    }
}

module body_decoration_2d() {
    L=eff_body_len(); W=eff_body_w();
    if(eff_segments()>0)
        for(i=[0:eff_segments()-1]) {
            t=(i+0.75)/(eff_segments()+1);
            y=lerp(-L*0.38,L*0.05,t);
            ww=lerp(W*eff_ab_taper(),W*0.75,t);
            stroke_polyline([[-ww*0.34,y],[ww*0.34,y]],max(eff_vein_thickness(),eff_min_feature()));
        }
    stroke_polyline([[0,L*0.03],[0,L*0.22]],max(eff_vein_thickness(),eff_min_feature()));

    if(Daekvinge_Soem && is_beetle())
        stroke_polyline([[0,-L*0.36],[0,L*0.18]],max(eff_vein_thickness(),eff_min_feature()));

    if(chosen_family()=="Cikade") {
        translate([ W*0.28, L*0.30]) circle(d=max(W*0.18, eff_min_feature()));
        translate([-W*0.28, L*0.30]) circle(d=max(W*0.18, eff_min_feature()));
    }
}

module decorations_raw_2d() {
    intersection() {
        union() {
            if(eff_veins_enabled()) {
                if(is_butterfly()) mirrored_pair() {
                    butterfly_veins_half(true);
                    butterfly_veins_half(false);
                }
                else if(is_longwing()) mirrored_pair() {
                    longwing_veins_half(+eff_long_sep()/2,Langvinge_For_Skala);
                    longwing_veins_half(-eff_long_sep()/2,Langvinge_Bag_Skala);
                    pterostigma_half(+eff_long_sep()/2,Langvinge_For_Skala);
                    pterostigma_half(-eff_long_sep()/2,Langvinge_Bag_Skala);
                }
                else if(is_beetle()) mirrored_pair() {
                    stroke_bezier([eff_body_w()*0.15,eff_body_len()*0.18],
                                  [Vingefang*0.13,eff_body_len()*0.12],
                                  [Vingefang*0.20,-eff_body_len()*0.15],
                                  [Vingefang*0.17,-eff_body_len()*0.35],eff_vein_thickness(),12);
                }
            }
            wing_spots_half();
            mirror([1,0,0]) wing_spots_half();
            beetle_spots_half();
            mirror([1,0,0]) beetle_spots_half();
        }
        wings_2d();
    }
    body_decoration_2d();
    ornamental_2d();
}

// ------------------------------------------------------------
// Ornamental / Art Nouveau
// ------------------------------------------------------------
module ornamental_half() {
    if(Ornamental_Mode && Ornamental_Styrke>0) {
        W=Vingefang;
        L=eff_body_len();
        w=max(Ornamental_Tykkelse,eff_min_feature()*0.65);
        for(i=[0:Ornamental_Slyng-1]) {
            t=(i+1)/(Ornamental_Slyng+1);
            p0=[eff_body_w()*0.40, lerp(-L*0.22,L*0.24,t)];
            p1=[W*lerp(0.10,0.17,t), lerp(-L*0.34,L*0.38,t)];
            p2=[W*lerp(0.25,0.36,t), lerp(L*0.18,-L*0.12,t)];
            p3=[W*lerp(0.34,0.46,t), lerp(-L*0.05,L*0.30,t)];
            stroke_bezier(p0,p1,p2,p3,w*Ornamental_Styrke,16);
            if(Ornamental_Ringe)
                translate(p3) difference() {
                    circle(d=W*(0.018+0.008*t)*Ornamental_Styrke+2*w);
                    circle(d=max(W*(0.018+0.008*t)*Ornamental_Styrke,w));
                }
        }
    }
}

module ornamental_2d() {
    intersection() {
        mirrored_pair() ornamental_half();
        wings_2d();
    }
}

// ------------------------------------------------------------
// Stencil bridges
// ------------------------------------------------------------
module stencil_bridges_half() {
    if(Stencil_Mode) {
        bw=max(Stencil_Bro_Bredde,eff_min_feature());
        for(i=[0:Stencil_Bro_Antal-1]) {
            t=(i+1)/(Stencil_Bro_Antal+1);
            y=lerp(-eff_body_len()*0.18,eff_body_len()*0.20,t);
            x0=eff_body_w()*0.25;
            x1=x0+Stencil_Bro_Laengde*(0.72+0.28*t);
            stroke_polyline([[x0,y],[x1,y+(t-0.5)*Stencil_Bro_Laengde*0.18]],bw);
        }
    }
}

module stencil_bridges_2d() {
    union() {
        mirrored_pair() stencil_bridges_half();
        if(Stencil_Mode && Stencil_Centerbro && Ophaengshul) {
            bw=max(Stencil_Bro_Bredde,eff_min_feature());
            y=eff_body_len()*0.32+Ophaengshul_Y;
            translate([-bw/2,y-Ophaengshul_Diameter/2-0.2]) square([bw,Ophaengshul_Diameter+0.4]);
        }
    }
}

// ------------------------------------------------------------
// Silhuet, udskaeringer, montage
// ------------------------------------------------------------
module cutout_pattern_half() {
    if(eff_cutout()>0) {
        span=Vingefang/2*0.78;
        for(i=[1:3]) {
            yy=lerp(-Vingefang*0.12,Vingefang*0.14,i/4);
            translate([eff_body_w()/2+span*(0.25+0.16*i),yy])
                scale([1.5,1]) circle(d=Vingefang*0.05*eff_cutout());
        }
    }
}

module silhouette_raw_2d() {
    union() { wings_2d(); body_2d(); }
}

module silhouette_2d() {
    union() {
        difference() {
            if(eff_outline()>0) offset(r=eff_outline()) offset(r=0.06) offset(delta=-0.06) silhouette_raw_2d();
            else offset(r=0.06) offset(delta=-0.06) silhouette_raw_2d();

            if(eff_cutout()>0)
                intersection() {
                    offset(delta=-Udskaering_Margin) wings_2d();
                    union() { cutout_pattern_half(); mirror([1,0,0]) cutout_pattern_half(); }
                }

            if(Ophaengshul)
                translate([0,eff_body_len()*0.32+Ophaengshul_Y]) circle(d=Ophaengshul_Diameter);
        }
        if(Stencil_Mode)
            intersection() { stencil_bridges_2d(); silhouette_raw_2d(); }
    }
}

module decoration_2d() {
    decorations_raw_2d();
}

// ------------------------------------------------------------
// Multi-layer helpers
// ------------------------------------------------------------
module wing_layer_2d() {
    if(Layer_Overlap>0) offset(delta=Layer_Overlap) wings_2d(); else wings_2d();
}
module body_layer_2d() {
    if(Layer_Overlap>0) offset(delta=Layer_Overlap) body_2d(); else body_2d();
}
module spot_layer_2d() {
    intersection() {
        union() {
            wing_spots_half(); mirror([1,0,0]) wing_spots_half();
            beetle_spots_half(); mirror([1,0,0]) beetle_spots_half();
            if(is_longwing()) mirrored_pair() {
                pterostigma_half(+eff_long_sep()/2,Langvinge_For_Skala);
                pterostigma_half(-eff_long_sep()/2,Langvinge_Bag_Skala);
            }
        }
        wings_2d();
    }
}
module vein_layer_2d() {
    difference() { decoration_2d(); spot_layer_2d(); }
}
module selected_layer_2d() {
    if(Layer_Output=="Vinger") wing_layer_2d();
    else if(Layer_Output=="Krop") body_layer_2d();
    else if(Layer_Output=="Aarer") vein_layer_2d();
    else if(Layer_Output=="Pletter") spot_layer_2d();
    else if(Layer_Output=="Stencilbroer") stencil_bridges_2d();
    else union() { silhouette_2d(); decoration_2d(); }
}

// ------------------------------------------------------------
// Panel / batch layout
// ------------------------------------------------------------
module panelize() {
    for(r=[0:Panel_Raekker-1])
        for(c=[0:Panel_Kolonner-1]) {
            idx=r*Panel_Kolonner+c;
            tx=(c-(Panel_Kolonner-1)/2)*Panel_Afstand_X;
            ty=((Panel_Raekker-1)/2-r)*Panel_Afstand_Y;
            translate([tx,ty,0])
                rotate(idx%2==1 ? Panel_Skiftevis_Rotation : 0)
                    if(Panel_Skiftevis_Spejling && idx%2==1) mirror([1,0,0]) children();
                    else children();
        }
}

// ------------------------------------------------------------
// 3D
// ------------------------------------------------------------
module extrude_soft(height=2) {
    linear_extrude(height=height) children();
}

module model_3d_flat() {
    extrude_soft(Tykkelse) silhouette_2d();
}

module model_3d_relief() {
    if(Relief_Haevede_Detaljer) {
        union() {
            extrude_soft(Tykkelse) silhouette_2d();
            translate([0,0,Tykkelse-EPS])
                linear_extrude(height=Relief_Hoejde+EPS)
                    intersection() { decoration_2d(); silhouette_2d(); }
        }
    } else {
        difference() {
            extrude_soft(Tykkelse) silhouette_2d();
            translate([0,0,max(0,Tykkelse-Relief_Hoejde)])
                linear_extrude(height=Relief_Hoejde+EPS*2)
                    intersection() { decoration_2d(); silhouette_2d(); }
        }
    }
}

// ------------------------------------------------------------
// Top-level output
// ------------------------------------------------------------
module single_output() {
    if(Output=="2D_SILHOUET")
        if(Layer_Output=="Alle") silhouette_2d(); else selected_layer_2d();
    else if(Output=="2D_DEKORATION")
        if(Layer_Output=="Alle") decoration_2d(); else selected_layer_2d();
    else if(Output=="2D_COMBINED")
        if(Layer_Output=="Alle") union() { silhouette_2d(); decoration_2d(); } else selected_layer_2d();
    else if(Output=="3D_FLAT")
        model_3d_flat();
    else
        model_3d_relief();
}

if(Panel_Mode)
    panelize() single_output();
else
    single_output();

if(Vis_Centerlinje && $preview && !Panel_Mode)
    color("red") translate([-0.15,-eff_body_len()/2,0]) square([0.3,eff_body_len()]);