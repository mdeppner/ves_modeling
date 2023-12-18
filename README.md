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



# ToDos
- check results when increasing the number of measurements from 19 to 100
- check the results when training for 10000 iterations (sample generations before creating the posterior, or on which the posterior is built on)
- improve the forward modeling s.t. one can give or provide the number of measurements and let them be generated on a linear scale or that one can give the (source_list) - the positions of the electrodes AB and MN
- 