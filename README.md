# README for Masterthesis project "Application of SBI to improve Geophysical inversion methods"

# KW 47 Hamburg

# KW 48 - 27.11
- Reading about forward model - about the experiment setup etc.
- Translation of Matlab model into python

# KW 49 - 04.12
- Reading about forward model - about the experiment setup etc.
- Translation of Matlab model into python

# KW 50 - 11.12
Mo 11.12
- Test the Inversion methods provided from SimPEG
- SBI testing for the inversion problem
Di. 12.12
- Präsentation für Seminar
- VES example for Reinhard

#### From discussion with Guy after showing the plots

From the posterior check the sounding curves and see how they look like, might be that they all match the original sounding curves
100 parameters is not that much.
increase the number of measurements, currently only 19 measurements were taken - increase up to 50 or even 100
set the thicknesses fixed - assume you already know them and then only infer the resistivities



# KW 51
Mo. 18.12
- Run on resistivities only - fixed layer depth
- Increase the number of iterations trained - 1000 to 10000 and also increase the number of measurements from 19 -> 100
- Check different SBI versions 
- Check the results for increasing the number of measurements taken (from 19 to 100)
- Check the results for increasing the number of simulations taken into the posterior

### Meeting with Guy 18.12
100 datapoints actually quite a lot - might be useful to use an embedding network for so many datapoints, as for each layer an own function for each input is trained and might take a lot of time for 100 inputs
for smooth example of synthetic generated data - 19 should actually be enough
Embedded network
Try on different SBI models or functionalities (like embedded nets) explore and try out
Parallelize code to be faster


Infer the depths as well
Fix the depth of layers and check this out 
E.g. every layer is of a fixed size of 1m or 2m



# ToDos
- done: check results when increasing the number of measurements from 19 to 100
- done: check the results when training for 10000 iterations (sample generations before creating the posterior, or on which the posterior is built on)
- improve the forward modeling s.t. one can give or provide the number of measurements and let them be generated on a linear scale or that one can give the (source_list) - the positions of the electrodes AB and MN


# KW 2 - 2024

Mi. 10.01.2024
- Check the model on a linear scale instead of log scale
- Check SBI inversion for 40 measurements - 20 in the range from 1 to 100 and 20 from 100 to 1000

# KW 3

Mo. 15.01.2024

#### Ideas for improvement: 
- Try normalization on the parameters space 
- Try to run more simulations
- Ty to limit in terms of standard deviation 
- Look for way to improve the SBI inversion
- Try less spacing instead of 1 - 1000 only 1 - 100
- Try less layers - only two for now
- Try multi-round inference

## Meeting with Guy: 
- SBI should be able to solve this problem
- Try limiting the prior
- From the 100 samples and the 10000 simulations save them and sample from them
- add noise to avoid the effect of a delta function
- add more simulations 1000 might be too little
- multi-round SBI might be an option

## Done: 
- Adding noise
- Limiting the prior space
- Restructuring the notebooks and the functions to run efficient experiments


### Urgently need to do: 
- Rerun the example with 100 measurements and 10000 simulations 
- Also 20 measurements and 10000 simulations? might be obsolete as we can subsample this form the 100 measurement example
- Think about alternative/better ways to visualize the results. 


Di. 16.01.2024 
### Done:
- Run on 20 measurements with more trainings iterations (Section 5)
- Limiting the measurement distance (Section 6)
- Rerun the 100 measurements and 10000 simulations

Mi. 17.01.2024
### Done
- Check the behaviour of shorter measurements
- Check out the needed simulations for a higher prior
- Introduction to cluster computation 
- GitLab action
- 
