# ASIC-Design-for-Image-Haze-Removal-Final-Year-Project

This Repository serves as a record for my final Semester B.Tech Project submitted to
Vellore Institute of Technology, Vellore (SENSE School).

////// add matlap apps to files section
////// add genus netist files to files section

## Table of Contents :

* Aim of The Project
* Abstract and Motivation
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

## Abstract and Motivation

Haze removal is an  important pre-processing process in many computer vision based and many other systems, although many methods exist (like using high beam lights, advanced dehazing algorithms, etc.) many of them are not suitable for real-time systems as they either consume a lot of power or are just computationally complex. Real-time systems demand, fast, efficient and low power consuming solutions as delays in real-time systems can be catastrophic, for example if a self driving car fails to detect and act upon an obstacle in time it can lead to an accident.

In order to meet the above needs we use ASICs to carry out this computation.

Reasons for using  ASICs for Haze Removal:

* Most Image Processing Operations are complex calculations that use various matrices and their multiplications, this is often time consuming.
* Real time applications like Drones, Computer vision, IoT, etc. are often small and operate on batteries, Haze Removal is an important preprocessing step that helps them operate in haze environments. Many solutions to this exist in the form of usage of high visibility lights, sending images to base station to process them, etc.
* This makes them less scalable, not ideal for time critical applications and a natural need for a cheep, small, modular solution arises that can easily take care of the job.
* The ASICs can be hardwired to carry on these matrix applications, techniques like pipelining can be used to reduce delay caused by the intermediary chip, Low power techniques can be used to reduce load on the battery.
