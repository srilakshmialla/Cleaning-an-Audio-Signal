# Cleaning up an audio signal
The goal of project is to clean up an audio file that is corrupted by a colored noise and two sinusoids. The methods suggested for spectral analysis is the use of fft or freqz functions in Matlab while the method for filtering is the use of fir1. The ultimate goal is to achieve the cleanest possible version of the provided .wav file while utilizing the aforementioned methods.
Initially, the signal is loaded into Matlab and the spectrum is analyzed to identify the frequency of the colored noise and annoying sinusoids within the signal. This is achieved by plotting magnitude spectrum of signal versus normalized frequencies using Fast Fourier Transform.
## FFT Spectrum
![img]


The normalized frequencies/actual frequencies of the two sinusoids, a colored noise and a third sinusoid (which is the result of frequency change on the one of the two sinusoids) is identified as follows from spectrum of the signal.
Sin1 = 0 .05143	    		1134Hz
Sin2 = 0 .004988		110Hz
Sin3 =0.003538  		78Hz
Colored Noise = 0.15 to 0.18

These frequencies are filtered out from the given signal using band stop filters, designed at desirable cut off frequencies. The cutoff frequencies are chosen depending on the frequencies obtained from the spectrum. The order is found by trial and error method with which unwanted components are zeroed. The order of filters in this project is high. Higher order filters are very expensive and are very complicated to design in real world. The order of filter in this project is taken high to make signal free of noise but it is not advisable when it comes to real world. The order of filter introduces delays in the signal which shifts it.  For this, the minimum order that has the least impact on the shift without compromising the filter specifications is chosen. As there are four frequency components which are needed to be removed from the provided audio signal, four filters are designed. The table below shows the chosen values of cutoff frequencies and order 
Filter |	Noise Signal |	WN1 |	WN2 |	Order of Filter
------------ | -------------|------------ | -------------|------------ 
h1 |	Sin1 |	0.050 |	0.052 |	5000
h2 |	Colored Noise |	0.14 |	0.2 |	1000
h3 |	Sin2 |	0.0044 | 0.0055 |	10000
h4 |	Sin3 |	0.003 |	0.004 |	10000

First the signal is passed to filter1 and the output of first filter is given to second filter as input. The output of second filter is split into two and each part is filtered by sending it into different filters. The obtained output from these filters is joined back to one signal which is free of noise. Delays and shifts in signal results in loss of some signal. Even though maximum effort is put in to avoid the loss of samples, there is loss of a few samples which is unavoidable.

Finally, the cleaned audio signal is saved in .wav format 


## Conclusion:
	In conclusion, this project helps in learning how to use FFT to know all frequency components in a signal and how to design a fir filter which eliminates undesired frequency components in an audio signal that is corrupted by noise. In process of reaching to a cleaned signal many Matlab techniques are applied and learned. The spectrums of noisy and cleaned signal concludes that provided signal is cleaned.


