# CR80 / ID-1 Card Holder

![Digital render](images/default-flex-tabs.png)

**Status:** Digitally validated; physical card fit and flex life still require testing.

The editable generator is [cr80-card-holder.scad](cr80-card-holder.scad). FDM printing in PLA or PETG; PETG is preferred for repeated flexing.

## Defaults and important controls

Portrait CR80 card, PETG Durable profile, flex tabs, top thumb notch, and top slot attachment.

**Fit and tolerance:** Defaults use 0.30 mm XY and 0.20 mm Z clearance. Test with a sacrificial card.

Open the SCAD file in OpenSCAD and use **Window → Customizer** to change the documented parameters. Dimensions are millimetres.

## OpenSCAD and export

This generator is maintained and validated with a recent OpenSCAD Nightly build.

1. Open the SCAD file and select parameters in Customizer.
2. Press **F6** for a full render.
3. Use **File → Export → Export as STL** for printable 3D output.
4. Slice with the actual printer, nozzle, material, and layer profile.

## Included examples

| Preset | STL | Digital render |
| --- | --- | --- |
| Default portrait flex tabs | [Download](stl-files/default-flex-tabs.stl) | [Preview](images/default-flex-tabs.png) |
| Landscape abuse-proof security rails | [Download](stl-files/landscape-security-rails.stl) | [Preview](images/landscape-security-rails.png) |
| Full bezel with round attachment | [Download](stl-files/full-bezel-round-attachment.stl) | [Preview](images/full-bezel-round-attachment.png) |

## Printing and fabrication

Print with the broad back plate flat on the bed.

The included STL files passed digital mesh and slicer checks. Digital validation does not establish physical fit, strength, fatigue life, or material suitability.

## Known limitations

- Card thickness and printer extrusion vary.
- Retention tabs and attachments need physical fatigue and load testing.

## License

The SCAD source, STL models, renders, and documentation in this public package are licensed under **CC BY-NC 4.0**. See the repository [LICENSE](../LICENSE.md).
