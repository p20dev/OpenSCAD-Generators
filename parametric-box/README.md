# Parametric Box

![Digital render](images/inner-lip.png)

**Status:** Digitally validated for three lid systems; physical mechanisms require calibration.

The editable generator is [parametric-box.scad](parametric-box.scad). FDM printing in PLA or PETG.

## Defaults and important controls

100 × 70 × 40 mm inside volume, 2.4 mm walls, rounded corners, and inner-lip lid.

**Fit and tolerance:** Lid clearance defaults to 0.25 mm; sliding, hinge, snap, and magnet fits are separate controls.

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
| Default inner-lip layout | [Download](stl-files/inner-lip.stl) | [Preview](images/inner-lip.png) |
| Sliding lid with pull tab | [Download](stl-files/sliding-lid.stl) | [Preview](images/sliding-lid.png) |
| Hinged lid with front snap | [Download](stl-files/hinged-snap.stl) | [Preview](images/hinged-snap.png) |

## Printing and fabrication

Print the box on its bottom and detached lids on their largest flat face.

The included STL files passed digital mesh and slicer checks. Digital validation does not establish physical fit, strength, fatigue life, or material suitability.

## Known limitations

- Combined layouts can exceed a nominal 220 mm usable bed width.
- Hinges, snaps, and magnets require physical fit testing.

## License

The SCAD source, STL models, renders, and documentation in this public package are licensed under **CC BY-NC 4.0**. See the repository [LICENSE](../LICENSE.md).
