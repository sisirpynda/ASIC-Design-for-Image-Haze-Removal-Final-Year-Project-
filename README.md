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
* MATLAB Simulation Results
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

## Dark Channel Prior Algorithm (DCP Algorithm)

The problem of Haze removal is Mathematically Ambiguous a there are more number of unknowns than number of equations. To solve this ambiguity we estimate some of the unknown values using statictical analysis, Physical properties of objects, assumptions from common knowledge, etc.

The use of "Priors" is one of the methods to solve the ambiguity. Priors are "prior knowledge" that we use to solve the ambiguity, the DCP algorithm uses the "Dark Channel Prior", this prior assumed that every haze free pixel (with three color channels namely Red(R), Green(G), Blue(B)) has a color channel that has a lower value compared to other two, this can be understood intuitively as in a pixel with all three channels of high values it would be close to white color which is inferred as fog. this prior is used to find the treansperency of the medium at each pixel.

The equation used to model the Haze is called "Haze Image Equation".

<p align = "center">
I(x) = J(x)t(x) + Ac(1 − t(x)).
Haze Image Equation
</p>

In the above equation ‘x’ represents the coordinates (x, y), I represent the Image captured by the camera, ‘t’ represents the transmission map, ‘Ac ’represents the Atmospheric Light (where c ϵ R, G, B), ‘J’ represents the original scene radiance (image without haze).

The problem of haze removal is mathematically ambiguous, considering an image of ‘N’ pixels, each having 3 channels (R, G, B) whose values are between 0 and 255, consequently each channel of a pixel will consist of 8 bits. Both I (image captured) and J (the value to compute) have 3N variables (thus forming 3n equations where I data is known and J data is unknown), t is representative of the transparency of the medium whose value lies between 0 and 1 (value 0 represents completely opaque and 1 represents completely transparent medium) thus making N unknowns, and Atmospheric Light has 3 unknowns (1 byte corresponding to each colour channel).

Assimilating all of the variables described above,
* Known data = 3N equations
* Unknown data = 3N + N + 3 variables 
It is evident that the number of unknowns us more than number of equations so this problem is mathematically ambiguous.

The design is based on DCP (Dark Channel Prior) Algorithm. The haze attenuates the light reflected from the objects and also further blends it with some additive light in the atmosphere and making the problem of haze removal mathematically ambiguous (there are more unknowns than equations), to solve this problem priors are used, these are assumptions or statistical and physical properties known beforehand which are used to solve the ambiguity. The DCP algorithm uses the prior that all the pixels in an image without haze have at least one color channel whose intensity is low, thus determining haze effected areas in the image.

The goal is to find the unknown variables in the haze image equation, for finding the value of Atmospheric Light, we consider the values of some of the highest brightness pixels in the image (generally estimated from 0.1% brightest pixels), for t we use “Dark Channel Prior Operator” which is a combination of 2 minimum operators, which finds the minimum of the three channels for a pixel(minc ϵ {R,G,B}) followed by a minimum operator which finds the minimum value present  in the window (generally taken 3 x 3, although bigger windows have higher probabilities of finding a darker pixel thus making transmission map more contentious, in some cases that can lead to block artifacts)(the designer may incorporate soft matting to improve the transmission map but  in our design we do not incorporate it as it will lead to additional power consumption). According to our prior the haze free pixels have at least one minimum channel and thus we can assume the following:

<p align = "center">
minc ϵ {R, G, B}(minx’ϵ Ω(x)(Jc(x’))) ≈ 0
</p>

The expression shows the dark channel prior applied on the haze free image (Ω represents the 3 x 3 window and x’ represents the coordinates of the pixels within the window), 
using this and applying the DCP operator on the haze image equation and solving for t we get:

<p align = "center">
t(x) = 1 - (minc ϵ {R, G, B}( minx’ϵ Ω(x)( Ic(x’) ) ) ) / Ac
</p>

We can write it in simple terms as:

<p align = "center">
t(x) = 1 -  Idark
</p>
  
Idark is called the dark channel of the image which is subsequently used to find the transmission map of the image as shown above. Here we may introduce another parameter ω (0 < ω < 1) which will control the amount of fog being removed (0 representing none and 1 representing complete haze removal), this will help us to adjust the contrast of the image and prevent the image from being over-saturated. Thus, the equation for ‘t’ becomes:

<p align = "center">
t(x) = 1 - (ω * Idark)
</p> 
 
Now that we have the ‘t’ and ‘Ac’ values we can substitute them in the haze image equation and find the “I(x)” as follows (t0 generally 0.25):


<p align = "center">
<img src = "https://user-images.githubusercontent.com/50233470/169224788-f6a3429d-6510-4a2d-bec6-a25ce8980920.png">
</p>



## MATLAB Simulation Results

Before designing the chip, the algorithm was tested on matlab.
the results are as follows:
![Simulation Results : Haze Free Image](https://user-images.githubusercontent.com/50233470/169220688-1b37372d-f58d-41a3-af38-faf76464c149.png)
<p align = "center">
Simulation Results : Haze Free Image
</p>

![Simulation Results : Intermidiate variables](https://user-images.githubusercontent.com/50233470/169220695-002e694a-3420-4f6b-ba5d-d434d463b181.png)
<p align = "center">
Simulation Results : Intermidiate variables
</p>

## Simulation Results from Xcelium

Test Images used:

![ti1](https://user-images.githubusercontent.com/50233470/169229041-62d36e01-52f6-4638-a582-dd42111c26c4.png)

<p align = "center">
  Test Image 1
</p>

![ti2](https://user-images.githubusercontent.com/50233470/169228910-529197b8-3cdf-4e9e-97c3-2e076281cde0.png)

<p align = "center">
  Test Image 2
</p>



