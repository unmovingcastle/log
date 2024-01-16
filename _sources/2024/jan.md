# January 2024

## Meeting with Kaeli, Thursday Jan. 11

### logistics
+   Start attending talks at least once per week, pick from below:
    +   Tuesday at noon - CCAPP seminar (overhang room, PRB 4{sup}`th` floor)
    +   Tuesday 3:45 - Physics General Colloquium
    +   <strike>Friday 11:15 - Astroparticle Lunch (Price Place)</strike>

+   **PUEO simulation call** (Wednesday 1:00, tentative)
+   individual meeting with Kaeli - Tuesday at 1:30

### Effective Volume Plot

+   Be sure to include units. For $x$-axis, use the following:\
    log(energy)[eV]
+   Make $y$-axis log scaled.
+   Our systematic error is 20% (no need to include in the plot)
+   statistical error normally goes like $1/\sqrt{N}$ but is more
    complicated for us; will deal with this next time.
+   **Re-compute the effective volume!** \
    Instead of [what I did in Dec. 2023](average_effective_volume_version1),
    do the following instead.
    +   Find out the (constant) total ice volume.
    +   For each array-output, obtain the *weighted* number of passed neutrinos.
        Add these all up (ie. run1 passed  + run2 passed + ...)
    +   Figure out the total number of neutrinos thrown.
    +   Use the following to compute effective volume:
        ```{math}
        {\rm(ice\,volume)} \cdot (4\pi) 
        \frac{\sum{\rm number\,passed\,(weighted)}}{\sum{\rm number\,thrown }}
        ```

### tasks
+ [x] Schedule 20 hours of research hours, put in calendar.
+ [ ] Read about [LPM effect](LPM_effect)
+ [x] Update the effective volume plot
+ [x] Read the {download}`GRA expectation document <pdf/gra_exp.pdf>`



## Meeting with Kaeli, Tuesday Jan.16

### Effective Volume Plot
+   This time, include error bars.

::::{dropdown} Error-bar script from Kaeli
``` python
def AddErrors(all_weights):#the input is a numpy array of all the event weights, where each entry is an event

	#set number of bins and max/min weights
	bin_num = 10
	max_weight = np.max(all_weights)
	min_weight = np.min(all_weights)

	#set bin values for weights
	bin_values = np.linspace(min_weight,max_weight,bin_num)

	#create arrays to hold both positive and negative errors
	bin_error_p = np.zeros(bin_num)
	bin_error_m = np.zeros(bin_num)
	test_error = np.zeros(bin_num)

	#Copy poisson errors from icemc:
	poissonerror_minus=[0.-0.00, 1.-0.37, 2.-0.74, 3.-1.10, 4.-2.34, 5.-2.75, 6.-3.82, 7.-4.25, 8.-5.30, 9.-6.33, 10.-6.78, 11.-7.81, 12.-8.83, 13.-9.28, 14.-10.30, 15.-11.32, 16.-12.33, 17.-12.79, 18.-13.81, 19.-14.82, 20.-15.83]
	poissonerror_plus=[1.29-0., 2.75-1., 4.25-2., 5.30-3., 6.78-4., 7.81-5., 9.28-6., 10.30-7., 11.32-8., 12.79-9., 13.81-10., 14.82-11., 16.29-12., 17.30-13., 18.32-14., 19.32-15., 20.80-16., 21.81-17., 22.82-18., 23.82-19., 25.30-20]
	
	#histogram weights into bins
	counts, bins =np.histogram(all_weights,bins=bin_values)
	bin_centers = (bins[1:]+bins[:-1])/2.0
	bin_width = bins[1]-bins[0]

	#loop over bins:
	for i, b in enumerate(bin_centers):
		#if bin has less than 20 events, use poisson errors
		if(counts[i]<20):
			this_pp = poissonerror_plus[counts[i]]
			this_pm = poissonerror_minus[counts[i]]
		#otherwise use sqrt(N)
		else:
			this_pp = np.sqrt(counts[i])
			this_pm = np.sqrt(counts[i])
		#print('this pp pm is :',this_pp, this_pm)

		#bin error is this error times the bin width
		bin_error_p[i]=this_pp*b#*bin_width
		bin_error_m[i]=this_pm*b#*bin_width

		#this is just here to compare against what I thought icemc was doing originally (not used)
		test_error[i]=this_pp*10**(-1*(i+0.5)/bin_num*(max_weight-min_weight)+min_weight)

	#total error is then added in quadrature 
	total_error_p = np.sqrt(np.sum(bin_error_p**2))
	total_error_m = np.sqrt(np.sum(bin_error_m**2))

	#again this is just a test to compare against icemc
	total_test = np.sqrt(np.sum(test_error**2))

	return(total_error_p,total_error_m)
```
::::

