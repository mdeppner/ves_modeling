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
- check results when increasing the number of measurements from 19 to 100
- check the results when training for 10000 iterations (sample generations before creating the posterior, or on which the posterior is built on)
- improve the forward modeling s.t. one can give or provide the number of measurements and let them be generated on a linear scale or that one can give the (source_list) - the positions of the electrodes AB and MN
- 