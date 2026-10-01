# Tea-Bag Dispenser

![Digital render](images/front-pull.png)

**Status:** Digitally validated; packet feeding and mounting require physical tests.

The editable generator is [tea-bag-dispenser.scad](tea-bag-dispenser.scad). FDM printing in PLA or PETG; use at least three perimeters for a durable kitchen part.

## Defaults and important controls

Front-pull magazine for 60 × 70 × 1.6 mm packets with capacity 24.

**Fit and tolerance:** Measure a real packet stack because seams and wrapper thickness vary by brand.

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
| Default front-pull magazine | [Download](stl-files/front-pull.stl) | [Preview](images/front-pull.png) |
| Angled counter tray | [Download](stl-files/angled-tray.stl) | [Preview](images/angled-tray.png) |
| Open organizer with magnetic back | [Download](stl-files/open-organizer.stl) | [Preview](images/open-organizer.png) |

## Printing and fabrication

Print the front-pull magazine with its back flat on the bed.

The included STL files passed digital mesh and slicer checks. Digital validation does not establish physical fit, strength, fatigue life, or material suitability.

## Known limitations

- Packet feeding, jamming, and cleanability require physical testing.
- Wall fasteners and magnets must be selected for the installation.

## License

The SCAD source, STL models, renders, and documentation in this public package are licensed under **CC BY-NC 4.0**. See the repository [LICENSE](../LICENSE.md).
