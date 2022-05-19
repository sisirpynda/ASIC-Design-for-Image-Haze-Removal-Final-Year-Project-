# ASIC-Design-for-Image-Haze-Removal-Final-Year-Project

This Repository serves as a record for my final Semester B.Tech Project submitted to
Vellore Institute of Technology, Vellore (SENSE School).

////// add matlap apps to files section
////// add genus netist files to files section

## Table of Contents :

* Aim of The Project
* Motivation
* Abstract
* Tools Used
* Dark Channel Prior Algorithm
* MATLAB Simulation results
* Simulation Results from Xcelium
* IMC Coverage Analysis
* Genus Synthesis
* Metrics to Validate the Effectiveness of the Chip
* Author
* Acknowledgements
* References

## Aim of The Project

The aim of the project was to design an ASIC chip to remove haze from a hazr image, while ensuring that it is compatable with the real-time systems (that is have the smallest delay so that other processes on the system do not get delayed, use the lowest power possible and save resources on the system).

## Motivation

Haze removal is an  important pre-processing process in many computer vision based and many other systems, although many methods exist (like using high beam lights, advanced dehazing algorithms, etc.) many of them are not suitable for real-time systems as they either consume a lot of power or are just computationally complex. Real-time systems demand, fast, efficient and low power consuming solutions as delays in real-time systems can be catastrophic, for example if a self driving car fails to detect and act upon an obstacle in time it can lead to an accident.

In order to meet the above needs we use ASICs to carry out this computation.

Reasons for using  ASICs for Haze Removal:

* Most Image Processing Operations are complex calculations that use various matrices and their multiplications, this is often time consuming.

* Real time applications like Drones, Computer vision, IoT, etc. are often small and operate on batteries, Haze Removal is an important preprocessing step that helps them operate in haze environments. Many solutions to this exist in the form of usage of high visibility lights, sending images to base station to process them, etc.

* This makes them less scalable, not ideal for time critical applications and a natural need for a cheep, small, modular solution arises that can easily take care of the job.

* The ASICs can be hardwired to carry on these matrix applications, techniques like pipelining can be used to reduce delay caused by the intermediary chip, Low power techniques can be used to reduce load on the battery.

## Abstract

The designed ASIC chip is a 6 staged pipelined consisting of 2 modes namely “Low Power Mode” and “Normal Mode”. the architecture consists of 4 blocks, 7 sub blocks and 8 leaf modules (designed in a bottom-up fashion). The simulation was done using Cadence Xcelium simulator, verification was done using Cadence IMC. 

The logical synthesis of the DUT was done to produce net-list using Cadence Genus tool (some optimizations were also done by the tool).

## Tools Used

* Xcelium: Successor of the Insisive Simulatior, Xcelium is a 3rd generation parallel simulator, which boasts the highest performance in the field, with its intelligent multi core mode it can run simulation much faster by recognizing the Acceleratable and non- acceleratable code components. it offers many convenient  options for the user like generic waveform window, Schematic tracer window, memory viewer window, and Expression calculator which is very useful for debugging.

* Gensus: To address the problem of design, productivity gap in the industry Cadence offers Genus Synthesis tool, it runs both legacy mode and common UI mode, the common UI mode is particularly useful as the interface is same across the other tools like tempus, voltus, joules which assist in coming  up with the optimum netlist meeting the performance requirements.

* IMC: Integrated Metrics Center (IMC) is the analysis tool used to analyze, merge, and report coverage data. 
