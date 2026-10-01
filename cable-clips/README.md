# Adjustable Cable Clips

![Digital render](images/small.png)

**Status:** Prototype; digitally validated but not cycle- or adhesive-tested.

The editable generator is [cable-clips.scad](cable-clips.scad). FDM printing; PETG is preferred where the retaining lips flex repeatedly.

## Defaults and important controls

35 mm long clip for a nominal 6 mm cable with a 2.4 mm adhesive base.

**Fit and tolerance:** Measure the cable and use cable_clearance rather than forcing an oversized cable.

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
| 3 mm cable | [Download](stl-files/small.stl) | [Preview](images/small.png) |
| 6 mm cable | [Download](stl-files/standard.stl) | [Preview](images/standard.png) |
| 12 mm cable | [Download](stl-files/large.stl) | [Preview](images/large.png) |

## Printing and fabrication

Print with the flat adhesive base on the build plate.

The included STL files passed digital mesh and slicer checks. Digital validation does not establish physical fit, strength, fatigue life, or material suitability.

## Known limitations

- Adhesive performance depends on the tape, plastic, and mounting surface.
- Do not use for hazardous or load-bearing wiring.

## License

The SCAD source, STL models, renders, and documentation in this public package are licensed under **CC BY-NC 4.0**. See the repository [LICENSE](../LICENSE.md).
