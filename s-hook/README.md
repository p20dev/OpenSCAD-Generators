# Parametric S-Hook

![Digital render](images/round.png)

**Status:** Reconstructed, corrected, and digitally validated; not load-rated.

The editable generator is [s-hook.scad](s-hook.scad). FDM printing in PETG or another material appropriate to the expected flex and creep.

## Defaults and important controls

22/18 mm hook radii, 290° sweeps, 22 mm neck, and 5 mm round section.

**Fit and tolerance:** Choose hook radii and section size for the actual objects; leave installation clearance.

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
| Default round section | [Download](stl-files/round.stl) | [Preview](images/round.png) |
| Flat section with bulb tips | [Download](stl-files/flat-bulb.stl) | [Preview](images/flat-bulb.png) |
| Curved reinforced oval section | [Download](stl-files/reinforced-oval.stl) | [Preview](images/reinforced-oval.png) |

## Printing and fabrication

Print flat in the generated orientation.

The included STL files passed digital mesh and slicer checks. Digital validation does not establish physical fit, strength, fatigue life, or material suitability.

## Known limitations

- Not certified or rated for overhead, valuable, or safety-related loads.
- Long-term creep and layer-direction strength require physical testing.

## License

The SCAD source, STL models, renders, and documentation in this public package are licensed under **CC BY-NC 4.0**. See the repository [LICENSE](../LICENSE.md).
