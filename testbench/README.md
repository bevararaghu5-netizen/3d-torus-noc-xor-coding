# Verilog Testbenches

Author/maintainer: **B. Raghunadh**

This directory contains testbench files transcribed from the supplied `codes.pdf` material. Use each testbench with its corresponding RTL module and inspect the waveform in AMD/Xilinx Vivado.

| Testbench | RTL under test |
|---|---|
| `tb_mesh_router_3d.v` | `mesh_router_3d.v` |
| `tb_mesh_router_algo_3d.v` | `mesh_router_algo_3d.v` |
| `tb_torus_router_3d.v` | `torus_router_3d.v` |
| `tb_torus_router_algo_3d.v` | `torus_router_algo_3d.v` |

## Suggested validation checklist

1. Add the matching RTL module and testbench to a Vivado simulation project.
2. Set the testbench as the simulation top.
3. Run behavioral simulation and inspect routing outputs, data outputs, and hop-count signals where present.
4. Record the Vivado version and the exact test conditions.
5. Add explicit assertions or pass/fail checks before treating a waveform as proof of functional correctness.

**Status:** PDF-extracted source; compile and simulation validation are still required.
